#!/usr/bin/env python3
"""Resolve GTA SA IPL ENEX staging rows into SAIF runtime context recommendations.

SAIF / LSIF Dev v0.26A.1.6 scope:
- consume the v0.26A.1.5 ENEX audit JSON and the original/decompiled GTA SA source;
- correlate ENEX names with main.scm references, shop bindings, source-space, zone and pair groups;
- emit idempotent SQL that updates staging columns and writes context evidence;
- never mutate runtime tables and never enable/apply queue rows.

No third-party Python modules are required.
"""
from __future__ import annotations

import argparse
import collections
import hashlib
import json
import re
from dataclasses import dataclass, asdict
from datetime import datetime, timezone
from pathlib import Path
from typing import Any

RESOLVER_VERSION = "saif-enex-context-resolver-v0.26A.1.6"

# context -> category, display, access scope, service type, recommended target, base confidence
CONTEXT_POLICY: dict[str, tuple[str, str, str, str, str, int]] = {
    "ammunation": ("shop", "Ammu-Nation", "public_shared", "ammunation", "public_interiors+ammu_config", 100),
    "247": ("shop", "24/7", "public_shared", "247", "public_interiors+public_service_config", 100),
    "burger_shot": ("restaurant", "Burger Shot", "public_shared", "burgershot", "public_interiors+public_service_config", 100),
    "cluckin_bell": ("restaurant", "Cluckin' Bell", "public_shared", "cluckinbell", "public_interiors+public_service_config", 100),
    "pizza_stack": ("restaurant", "Pizza Stack", "public_shared", "pizzastack", "public_interiors+public_service_config", 100),
    "donut_shop": ("restaurant", "Donut Shop", "public_shared", "donut_shop", "public_interiors+public_service_config", 96),
    "restaurant": ("restaurant", "Restaurant / Diner", "public_shared", "restaurant", "public_interiors+public_service_config", 90),
    "barber": ("shop", "Barber Shop", "public_shared", "barber", "public_interiors+public_service_config", 100),
    "tattoo": ("shop", "Tattoo Parlor", "public_shared", "tattoo", "public_interiors+public_service_config", 100),
    "clothing": ("shop", "Clothing Store", "public_shared", "clothing", "public_interiors+skin_catalog", 98),
    "wardrobe": ("service", "Wardrobe / Changing Room", "player_private", "wardrobe", "skin_wardrobe_reference", 94),
    "gym": ("service", "Gym", "public_shared", "gym", "public_interiors+public_service_config", 100),
    "police": ("service", "Police Station", "public_shared", "police", "public_interiors+police_service", 100),
    "casino": ("entertainment", "Casino", "public_shared", "casino", "public_interiors+casino_service", 96),
    "vehicle_mod_shop": ("garage", "Vehicle Modification Shop", "public_shared", "vehicle_mod", "public_interiors+offline_garage_queue", 100),
    "bike_school": ("service", "Bike School", "public_shared", "bike_school", "public_interiors+license_service", 96),
    "driving_school": ("service", "Driving School", "public_shared", "driving_school", "public_interiors+license_service", 96),
    "airport": ("transport", "Airport", "public_shared", "airport", "public_interiors+transport_reference", 94),
    "stadium": ("entertainment", "Stadium / Event Interior", "event_shared", "stadium", "public_interiors+event_reference", 92),
    "bar": ("entertainment", "Bar", "public_shared", "bar", "public_interiors+public_service_config", 90),
    "club": ("entertainment", "Club", "public_shared", "club", "public_interiors+public_service_config", 90),
    "adult_shop": ("shop", "Adult Shop", "public_shared", "adult_shop", "public_interiors", 90),
    "adult_venue": ("mission", "Story / Adult Venue", "mission_reference", "", "reference_only", 82),
    "gang_hq": ("gang", "Gang Interior", "gang_shared", "gang_hq", "gang_preset_config", 90),
    "savehouse": ("property", "Savehouse / Property", "property_private", "savehouse", "player_houses", 92),
    "property": ("property", "House / Property", "property_private", "property", "player_houses", 84),
    "story_interior": ("mission", "Story / Mission Interior", "mission_reference", "", "reference_only", 82),
    "betting_shop": ("entertainment", "Inside Track Betting", "public_shared", "betting_shop", "public_interiors+betting_reference", 98),
    "warehouse": ("mission", "Warehouse Interior", "mission_reference", "", "reference_only", 78),
    "test_interior": ("mission", "Developer / Test Interior", "mission_reference", "", "reference_only", 95),
    "casino_heist_access": ("mission", "Casino Heist Access", "mission_reference", "", "reference_only", 98),
    "crack_den": ("mission", "Crack Den / Story Interior", "mission_reference", "", "reference_only", 94),
    "pier_access": ("mission", "Pier 69 Access", "mission_reference", "", "reference_only", 82),
    "building_access": ("service", "Building / Rooftop Access", "public_shared", "building_access", "public_interiors", 74),
    "atrium": ("service", "Atrium Interior Access", "review_required", "atrium", "reference_only", 68),
    "unknown": ("unknown", "Unresolved ENEX", "review_required", "", "review_required", 20),
}

# Explicit corrections/expansions learned from exact GTA SA main.scm and ENEX naming.
NAME_CONTEXT_OVERRIDES: dict[str, tuple[str, str]] = {
    "GENOTB": ("betting_shop", "main.scm INTMAN binds GENOTB to OTB_SCRIPT/OTB_AMBIENCE/OTB_STAFF."),
    "CSDESGN": ("clothing", "main.scm wardrobe table binds CSDESGN to the clothes shop subsystem."),
    "LACS1": ("clothing", "main.scm wardrobe table binds LACS1 to the clothes shop subsystem."),
    "CARLS": ("savehouse", "main.scm explicitly enables CARLS as Carl's savehouse after the intro mission."),
    "VGSHS2": ("savehouse", "VGSH naming and interior pair identify a Las Venturas savehouse interior."),
    "VGSHM2": ("savehouse", "VGSH naming and interior pair identify a Las Venturas savehouse interior."),
    "VGSHM3": ("savehouse", "VGSH naming and interior pair identify a Las Venturas savehouse interior."),
    "GENWRHS": ("warehouse", "Generic warehouse ENEX is retained as mission/reference-only."),
    "OFTEST": ("test_interior", "ENEX name and interior source identify an unused/test interior."),
    "S1TEST": ("test_interior", "ENEX name and interior source identify an unused/test interior."),
    "JUMP1": ("casino_heist_access", "main.scm HEIST9 toggles JUMP1 as an internal casino-heist access route."),
    "JUMP2": ("casino_heist_access", "main.scm HEIST9 toggles JUMP2 as an internal casino-heist access route."),
    "LACRAK": ("crack_den", "main.scm repeatedly gates LACRAK during Los Santos story missions."),
    "P69_ENT": ("pier_access", "Exterior pair at Esplanade North identifies Pier 69 mission access."),
    "SKYLAN2": ("building_access", "Paired Downtown Los Santos ground/roof ENEX indicates skyscraper access."),
    "ATRIUME": ("atrium", "Interior-source atrium endpoint; no safe gameplay binding found in main.scm."),
    "ATRIUMX": ("atrium", "Interior-source atrium endpoint; no safe gameplay binding found in main.scm."),
}

# Existing parser contexts receive stronger evidence when main.scm has known subsystem bindings.
KNOWN_SCM_SYSTEM: dict[str, tuple[str, ...]] = {
    "ammunation": ("AMMU",),
    "barber": ("BARBER",),
    "tattoo": ("TATTOO",),
    "clothing": ("CLOTHES",),
    "wardrobe": ("WARDROBE",),
    "burger_shot": ("JUNKFUD", "FOODBRAINS", "SHOPKEEPER"),
    "cluckin_bell": ("JUNKFUD", "FOODBRAINS", "SHOPKEEPER"),
    "pizza_stack": ("JUNKFUD", "FOODBRAINS", "SHOPKEEPER"),
    "restaurant": ("FOOD_VENDOR", "FOODBRAINS"),
    "bar": ("BAR_AMBIENCE", "BAR_STAFF"),
    "club": ("STRIP_AMBIENCE", "BOUNCER"),
    "betting_shop": ("OTB_SCRIPT", "OTB_AMBIENCE", "OTB_STAFF"),
    "vehicle_mod_shop": ("CARMOD1",),
    "savehouse": ("HOME_BRAINS",),
    "police": ("COPSIT", "COPLOOK"),
}

@dataclass
class Evidence:
    evidence_type: str
    evidence_source: str
    evidence_key: str
    evidence_value: str
    confidence_delta: int = 0

@dataclass
class ResolvedRow:
    record_hash: str
    raw_name: str
    resolved_display_name: str
    resolved_category: str
    resolved_context_type: str
    access_scope: str
    service_type: str
    recommended_runtime_target: str
    resolver_status: str
    resolver_confidence: int
    resolver_reason: str
    scm_reference_count: int
    scm_shop_binding_count: int
    pair_group_key: str
    pair_group_size: int
    pair_status: str
    duplicate_group_size: int
    point_a_space: str
    point_b_space: str
    evidence: list[Evidence]


def sql_string(value: Any) -> str:
    if value is None:
        return "NULL"
    return "'" + str(value).replace("'", "''") + "'"


def find_source_root(path: Path) -> Path:
    path = path.resolve()
    if (path / "00_RAW" / "data").is_dir():
        return path
    for child in path.iterdir() if path.is_dir() else []:
        if child.is_dir() and (child / "00_RAW" / "data").is_dir():
            return child
    raise FileNotFoundError(f"Tidak menemukan 00_RAW/data di {path}")


def load_decompiled(source_root: Path) -> tuple[str, list[str], dict[int, str]]:
    path = source_root / "01_DECOMPILED" / "main_decompiled.txt"
    text = path.read_text(encoding="latin-1", errors="replace")
    lines = text.splitlines()
    script_names: dict[int, str] = {}
    pattern = re.compile(r"^DEFINE SCRIPT\s+(\S+)\s+AT\s+\S+\s+//\s+(\d+)")
    for line in lines[:2000]:
        match = pattern.search(line)
        if match:
            script_names[int(match.group(2))] = match.group(1)
    return text, lines, script_names


def exact_name_line_index(lines: list[str], names: set[str]) -> dict[str, list[int]]:
    index = {name: [] for name in names if name}
    if not index:
        return index
    quoted = re.compile(r"['\"]([A-Za-z0-9_]{1,32})['\"]")
    for line_no, line in enumerate(lines, start=1):
        if "'" not in line and '"' not in line:
            continue
        for token in quoted.findall(line):
            upper = token.upper()
            if upper in index:
                index[upper].append(line_no)
    return index


def build_shop_binding_counts(text: str, names: set[str]) -> dict[str, int]:
    counts = {name: 0 for name in names if name}
    patterns = [
        re.compile(r"\$shop_section[^\n]*=\s*['\"]([A-Za-z0-9_]{1,32})['\"]", re.IGNORECASE),
        re.compile(r"s\$shop_name\s*==\s*['\"]([A-Za-z0-9_]{1,32})['\"]", re.IGNORECASE),
        re.compile(r"get_loaded_shop[^\n]*['\"]([A-Za-z0-9_]{1,32})['\"]", re.IGNORECASE),
    ]
    for pattern in patterns:
        for token in pattern.findall(text):
            upper = token.upper()
            if upper in counts:
                counts[upper] += 1
    return counts


def is_interior_source(row: dict[str, Any]) -> bool:
    source = row["source_file"].replace("\\", "/").lower()
    return "/maps/interior/" in source or (row.get("interior_id", 0) > 0 and row.get("entry_z", 0.0) > 500.0)


def space_for_a(row: dict[str, Any]) -> str:
    interior = int(row.get("interior_id", 0))
    if interior > 0 and is_interior_source(row):
        return f"interior:{interior}"
    if row.get("entry_z", 0.0) > 500.0 and interior <= 0:
        return "unsafe_high_z"
    return "world:0"


def space_for_b(row: dict[str, Any]) -> str:
    interior = int(row.get("interior_id", 0))
    if interior > 0:
        return f"interior:{interior}"
    if row.get("exit_z", 0.0) > 500.0:
        return "unsafe_high_z"
    return "world:0"


def pair_status_for(rows: list[dict[str, Any]]) -> str:
    a_spaces = {space_for_a(row) for row in rows}
    if any(s.startswith("interior:") for s in a_spaces) and "world:0" in a_spaces:
        return "exterior_interior_pair"
    if len(rows) == 1:
        return "single_record"
    if all(s.startswith("interior:") for s in a_spaces):
        return "interior_group"
    if a_spaces == {"world:0"}:
        return "multi_exterior_group"
    return "mixed_review"


def resolve_context(row: dict[str, Any]) -> tuple[str, str]:
    raw = row.get("raw_name", "").strip().upper()
    if raw in NAME_CONTEXT_OVERRIDES:
        return NAME_CONTEXT_OVERRIDES[raw]
    context = row.get("context_type", "unknown") or "unknown"
    if context in CONTEXT_POLICY:
        return context, "Baseline ENEX name classification retained and enriched with source evidence."
    return "unknown", "No authoritative context binding found; manual review remains required."


def resolve_rows(audit: dict[str, Any], source_root: Path) -> list[ResolvedRow]:
    rows: list[dict[str, Any]] = audit["interior_queue"]
    text, lines, _script_names = load_decompiled(source_root)
    names = {str(row.get("raw_name", "")).strip().upper() for row in rows}
    line_index = exact_name_line_index(lines, names)
    shop_counts = build_shop_binding_counts(text, names)

    by_name: dict[str, list[dict[str, Any]]] = collections.defaultdict(list)
    for row in rows:
        by_name[str(row.get("raw_name", "")).strip().upper()].append(row)

    duplicate_counter: collections.Counter[tuple[Any, ...]] = collections.Counter()
    for row in rows:
        key = (
            str(row.get("raw_name", "")).strip().upper(),
            round(float(row.get("entry_x", 0.0)), 3), round(float(row.get("entry_y", 0.0)), 3), round(float(row.get("entry_z", 0.0)), 3),
            round(float(row.get("exit_x", 0.0)), 3), round(float(row.get("exit_y", 0.0)), 3), round(float(row.get("exit_z", 0.0)), 3),
            int(row.get("interior_id", 0)),
        )
        duplicate_counter[key] += 1

    output: list[ResolvedRow] = []
    for row in rows:
        raw = str(row.get("raw_name", "")).strip().upper()
        context, base_reason = resolve_context(row)
        category, display, access, service, target, base_conf = CONTEXT_POLICY[context]
        references = line_index.get(raw, []) if raw else []
        shop_count = shop_counts.get(raw, 0)
        group = by_name[raw]
        pstatus = pair_status_for(group)
        pair_key = raw if raw else f"UNNAMED:{row['record_hash'][:12]}"
        dup_key = (
            raw,
            round(float(row.get("entry_x", 0.0)), 3), round(float(row.get("entry_y", 0.0)), 3), round(float(row.get("entry_z", 0.0)), 3),
            round(float(row.get("exit_x", 0.0)), 3), round(float(row.get("exit_y", 0.0)), 3), round(float(row.get("exit_z", 0.0)), 3),
            int(row.get("interior_id", 0)),
        )
        duplicate_count = duplicate_counter[dup_key]

        evidence: list[Evidence] = [
            Evidence("IPL_ENEX", row["source_file"], f"line:{row['source_line']}", row.get("raw_record", "")[:240], 20),
            Evidence("ZONE_MATCH", "info.zon/map.zon", row.get("area_code", "") or "unknown", f"city={row.get('city_code','')}; area={row.get('area_code','')}", 5 if row.get("area_code") else 0),
            Evidence("PAIR_GROUP", "IPL_ENEX_SET", pair_key, f"size={len(group)}; status={pstatus}", 8 if len(group) > 1 else 0),
        ]
        if raw:
            evidence.append(Evidence("NAME_RULE", "resolver_rulebook", raw, f"context={context}; {base_reason}", 25))
        if references:
            sample = ",".join(str(n) for n in references[:8])
            evidence.append(Evidence("SCM_REFERENCE", "main_decompiled.txt", raw, f"count={len(references)}; lines={sample}", min(20, 5 + len(references))))
        if shop_count:
            evidence.append(Evidence("SCM_SHOP_BINDING", "main_decompiled.txt", raw, f"shop binding count={shop_count}", 20))
        subsystem_names = KNOWN_SCM_SYSTEM.get(context, ())
        if subsystem_names:
            evidence.append(Evidence("SCM_SUBSYSTEM", "main.scm/script.img", raw or context, ",".join(subsystem_names), 15))
        if duplicate_count > 1:
            evidence.append(Evidence("DUPLICATE_RECORD", "IPL_ENEX_SET", pair_key, f"exact normalized duplicate count={duplicate_count}", -5))
        if not raw:
            evidence.append(Evidence("MANUAL_REVIEW", "resolver", row["record_hash"], "Blank ENEX name; no automatic gameplay target selected.", -40))

        confidence = base_conf
        if references and confidence < 100:
            confidence = min(100, confidence + 4)
        if shop_count and confidence < 100:
            confidence = min(100, confidence + 5)
        if len(group) > 1 and confidence < 100:
            confidence = min(100, confidence + 2)
        if duplicate_count > 1:
            confidence = max(20, confidence - 5)
        if not raw:
            confidence = 20
        if context in {"unknown", "atrium"}:
            status = "review_required"
        elif confidence >= 90:
            status = "resolved"
        else:
            status = "partial"

        reason_parts = [base_reason]
        if references:
            reason_parts.append(f"main.scm exact references={len(references)}")
        else:
            reason_parts.append("no exact quoted main.scm reference")
        if shop_count:
            reason_parts.append(f"shop bindings={shop_count}")
        reason_parts.append(f"pair={pstatus}/{len(group)}")
        if duplicate_count > 1:
            reason_parts.append(f"duplicate={duplicate_count}")
        reason = "; ".join(reason_parts)

        output.append(ResolvedRow(
            record_hash=row["record_hash"],
            raw_name=raw,
            resolved_display_name=display if context != "story_interior" else (row.get("display_name") or display),
            resolved_category=category,
            resolved_context_type=context,
            access_scope=access,
            service_type=service,
            recommended_runtime_target=target,
            resolver_status=status,
            resolver_confidence=confidence,
            resolver_reason=reason[:500],
            scm_reference_count=len(references),
            scm_shop_binding_count=shop_count,
            pair_group_key=pair_key,
            pair_group_size=len(group),
            pair_status=pstatus,
            duplicate_group_size=duplicate_count,
            point_a_space=space_for_a(row),
            point_b_space=space_for_b(row),
            evidence=evidence,
        ))
    return output


def write_sql(path: Path, audit: dict[str, Any], rows: list[ResolvedRow]) -> None:
    now = datetime.now(timezone.utc).isoformat()
    lines = [
        "-- SAIF / LSIF Dev v0.26A.1.6 - ENEX Context Resolver",
        f"-- Generated by {RESOLVER_VERSION} at {now}",
        "-- SAFETY: updates offline staging metadata/evidence only. Runtime tables and queue enable/apply state are untouched.",
        "SET NAMES utf8mb4;",
        "START TRANSACTION;",
        f"SET @offline_session_key := {sql_string(audit['session_key'])};",
        "SET @offline_session_id := (SELECT id FROM offline_import_sessions WHERE session_key=@offline_session_key LIMIT 1);",
        "",
        "DELETE e FROM offline_interior_context_evidence e",
        "JOIN offline_interior_queue q ON q.id=e.queue_id",
        "WHERE q.session_id=@offline_session_id AND e.resolver_version=" + sql_string(RESOLVER_VERSION) + ";",
        "",
    ]
    for row in rows:
        lines.extend([
            "UPDATE offline_interior_queue SET",
            f"  resolved_display_name={sql_string(row.resolved_display_name)},",
            f"  resolved_category={sql_string(row.resolved_category)},",
            f"  resolved_context_type={sql_string(row.resolved_context_type)},",
            f"  access_scope={sql_string(row.access_scope)},",
            f"  service_type={sql_string(row.service_type)},",
            f"  recommended_runtime_target={sql_string(row.recommended_runtime_target)},",
            f"  resolver_status={sql_string(row.resolver_status)},",
            f"  resolver_confidence={row.resolver_confidence},",
            f"  resolver_version={sql_string(RESOLVER_VERSION)},",
            f"  resolver_reason={sql_string(row.resolver_reason)},",
            f"  scm_reference_count={row.scm_reference_count},",
            f"  scm_shop_binding_count={row.scm_shop_binding_count},",
            f"  pair_group_key={sql_string(row.pair_group_key)},",
            f"  pair_group_size={row.pair_group_size},",
            f"  pair_status={sql_string(row.pair_status)},",
            f"  duplicate_group_size={row.duplicate_group_size},",
            f"  point_a_space={sql_string(row.point_a_space)},",
            f"  point_b_space={sql_string(row.point_b_space)},",
            "  resolved_at=CURRENT_TIMESTAMP",
            f"WHERE session_id=@offline_session_id AND record_hash={sql_string(row.record_hash)};",
        ])
        for ev in row.evidence:
            lines.extend([
                "INSERT INTO offline_interior_context_evidence",
                "(session_id, queue_id, resolver_version, evidence_type, evidence_source, evidence_key, evidence_value, confidence_delta)",
                "SELECT q.session_id, q.id, " + sql_string(RESOLVER_VERSION) + ", " + sql_string(ev.evidence_type) + ", " + sql_string(ev.evidence_source) + ", " + sql_string(ev.evidence_key) + ", " + sql_string(ev.evidence_value) + f", {ev.confidence_delta}",
                "FROM offline_interior_queue q",
                f"WHERE q.session_id=@offline_session_id AND q.record_hash={sql_string(row.record_hash)}",
                "ON DUPLICATE KEY UPDATE evidence_value=VALUES(evidence_value), confidence_delta=VALUES(confidence_delta), updated_at=CURRENT_TIMESTAMP;",
            ])
    lines.extend([
        "",
        "UPDATE offline_import_sessions",
        "SET status='context_resolved', updated_at=CURRENT_TIMESTAMP",
        "WHERE id=@offline_session_id;",
        "",
        "DELETE FROM offline_import_logs",
        "WHERE session_id=@offline_session_id AND component='ENEX_CONTEXT_RESOLVER';",
        "INSERT INTO offline_import_logs (session_id, log_level, component, message, source_file, source_line)",
        "VALUES (@offline_session_id, 'info', 'ENEX_CONTEXT_RESOLVER',",
        f"        {sql_string(f'Resolved {len(rows)} ENEX staging rows with {RESOLVER_VERSION}; runtime untouched.')},",
        "        '01_DECOMPILED/main_decompiled.txt', 0);",
        "",
        "COMMIT;",
        "",
        "SELECT @offline_session_id AS context_resolved_session_id;",
        "SELECT resolver_status, COUNT(*) AS total FROM offline_interior_queue WHERE session_id=@offline_session_id GROUP BY resolver_status ORDER BY resolver_status;",
        "SELECT recommended_runtime_target, COUNT(*) AS total FROM offline_interior_queue WHERE session_id=@offline_session_id GROUP BY recommended_runtime_target ORDER BY total DESC;",
        "SELECT COUNT(*) AS enabled_rows_must_remain_zero FROM offline_interior_queue WHERE session_id=@offline_session_id AND enabled=1;",
    ])
    path.write_text("\n".join(lines) + "\n", encoding="utf-8")


def write_report(md_path: Path, json_path: Path, audit: dict[str, Any], rows: list[ResolvedRow]) -> None:
    status = collections.Counter(r.resolver_status for r in rows)
    contexts = collections.Counter(r.resolved_context_type for r in rows)
    targets = collections.Counter(r.recommended_runtime_target for r in rows)
    scopes = collections.Counter(r.access_scope for r in rows)
    pair_status = collections.Counter(r.pair_status for r in rows)
    unknowns = [r for r in rows if r.resolver_status == "review_required"]
    data = {
        "resolver_version": RESOLVER_VERSION,
        "generated_at_utc": datetime.now(timezone.utc).isoformat(),
        "source_session_key": audit["session_key"],
        "row_count": len(rows),
        "status_counts": dict(status),
        "context_counts": dict(contexts),
        "target_counts": dict(targets),
        "scope_counts": dict(scopes),
        "pair_status_counts": dict(pair_status),
        "rows": [{**asdict(r), "evidence": [asdict(e) for e in r.evidence]} for r in rows],
    }
    json_path.write_text(json.dumps(data, indent=2, ensure_ascii=False), encoding="utf-8")

    lines = [
        "# SAIF v0.26A.1.6 — ENEX Context Resolver Report",
        "",
        f"- Resolver: `{RESOLVER_VERSION}`",
        f"- Source session: `{audit['session_key']}`",
        f"- ENEX rows processed: **{len(rows)}**",
        "- Runtime mutation: **none**",
        "- Queue enabled/apply state changed: **no**",
        "",
        "## Resolver status",
        "",
    ]
    for key, value in sorted(status.items()):
        lines.append(f"- `{key}`: **{value}**")
    lines += ["", "## Recommended runtime targets", ""]
    for key, value in targets.most_common():
        lines.append(f"- `{key}`: **{value}**")
    lines += ["", "## Access scopes", ""]
    for key, value in scopes.most_common():
        lines.append(f"- `{key}`: **{value}**")
    lines += ["", "## Pair status", ""]
    for key, value in pair_status.most_common():
        lines.append(f"- `{key}`: **{value}**")
    lines += ["", "## Context counts", ""]
    for key, value in contexts.most_common():
        lines.append(f"- `{key}`: **{value}**")
    lines += ["", "## Rows still requiring review", ""]
    if not unknowns:
        lines.append("None.")
    else:
        for row in unknowns:
            lines.append(f"- `{row.raw_name or '<blank>'}` / `{row.record_hash[:12]}` — {row.resolver_reason}")
    lines += [
        "",
        "## Safety statement",
        "",
        "This resolver writes only to `offline_interior_queue`, `offline_interior_context_evidence`, `offline_import_sessions`, and `offline_import_logs`.",
        "It does not insert, update, delete, archive, reload, or spawn records in `public_interiors`, `world_pickups`, `parked_vehicles`, `player_houses`, or any other runtime dataset.",
    ]
    md_path.write_text("\n".join(lines) + "\n", encoding="utf-8")


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--source-root", required=True, type=Path)
    parser.add_argument("--input-audit-json", required=True, type=Path)
    parser.add_argument("--output-sql", required=True, type=Path)
    parser.add_argument("--output-json", required=True, type=Path)
    parser.add_argument("--output-md", required=True, type=Path)
    args = parser.parse_args()

    source_root = find_source_root(args.source_root)
    audit = json.loads(args.input_audit_json.read_text(encoding="utf-8"))
    rows = resolve_rows(audit, source_root)
    for path in (args.output_sql, args.output_json, args.output_md):
        path.parent.mkdir(parents=True, exist_ok=True)
    write_sql(args.output_sql, audit, rows)
    write_report(args.output_md, args.output_json, audit, rows)
    print(f"Resolved {len(rows)} ENEX rows with {RESOLVER_VERSION}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
