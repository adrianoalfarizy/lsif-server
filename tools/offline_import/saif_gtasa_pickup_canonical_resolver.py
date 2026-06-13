#!/usr/bin/env python3
"""SAIF v0.26A.1.18 GTA SA pickup canonical resolver.

Reads the v0.26A.1.17 pickup audit JSON and reproduces the canonical resolver
report. It never connects to MariaDB and never mutates world_pickups.
"""
from __future__ import annotations

import argparse
import collections
import hashlib
import json
from pathlib import Path

PARSER_VERSION = "saif-pickup-parser-v0.26A.1.17"
RESOLVER_VERSION = "saif-pickup-resolver-v0.26A.1.18"


def base_decision(rec: dict) -> str:
    category = rec["pickup_category"]
    if rec.get("zero_coordinate"):
        return "invalid_placeholder"
    if not rec.get("position_resolved"):
        return "dynamic_position_deferred"
    if rec.get("source_scope") == "IPL":
        return "interior_ipl_deferred" if float(rec.get("pos_z", 0.0)) >= 800.0 else "ipl_semantics_deferred"
    if category in {"property_for_sale", "property_locked", "savegame"}:
        return "property_bridge_deferred"
    if category.startswith("collectible_"):
        return "collectible_persistence_deferred"
    if category == "story_item":
        return "mission_story_excluded"
    if category == "weapon":
        return "weapon_economy_deferred"
    if category in {"money", "revenue"}:
        return "economy_backend_deferred"
    if category in {"info", "model_reference"}:
        return "reference_only"
    if category == "clothing":
        return "mission_context_deferred"
    if category in {"health", "armor", "bribe"}:
        if float(rec.get("pos_z", 0.0)) >= 800.0:
            return "interior_context_deferred"
        if rec.get("script_name") == "INITIAL":
            return "baseline_ready"
        return "mission_context_deferred"
    return "review_required"


def runtime_target(rec: dict, base: str) -> str:
    category = rec["pickup_category"]
    if base == "baseline_ready":
        return "world_pickups"
    if category in {"health", "armor", "bribe", "weapon"}:
        return "world_pickups_context_bridge"
    if category.startswith("collectible_"):
        return "player_collectibles"
    if category in {"property_for_sale", "property_locked", "savegame"}:
        return "player_houses_property_bridge"
    if category == "revenue":
        return "business_revenue_bridge"
    if category == "money":
        return "mission_money_bridge"
    if category == "clothing":
        return "wardrobe_mission_bridge"
    if rec.get("source_scope") == "IPL":
        return "ipl_pick_context_resolver"
    return "reference_only"


def canonical_type(category: str) -> str:
    return category if category in {"health", "armor", "bribe", "weapon"} else ("hidden" if category in {"money", "revenue"} else "")


def canonical_amount(rec: dict) -> int | None:
    category = rec["pickup_category"]
    if category in {"health", "armor"}:
        return 100
    if category == "bribe":
        return 1
    if category == "weapon":
        ammo = rec.get("ammo_amount")
        return int(ammo) if ammo is not None and int(ammo) > 0 else 30
    if category == "money" and rec.get("cash_amount") is not None:
        return int(rec["cash_amount"])
    return None


def cooldown(category: str) -> int:
    return {
        "bribe": 180,
        "armor": 240,
        "health": 120,
        "weapon": 300,
        "money": 600,
        "revenue": 600,
    }.get(category, 0)


def resolve(records: list[dict]) -> list[dict]:
    groups: dict[str, list[int]] = collections.defaultdict(list)
    for index, rec in enumerate(records):
        if rec.get("duplicate_key"):
            groups[rec["duplicate_key"]].append(index)

    shadow_indices: set[int] = set()
    primary_hashes: dict[int, str] = {}
    for indices in groups.values():
        ordered = sorted(indices, key=lambda i: (
            records[i]["source_file"], records[i]["source_line"], records[i]["record_hash"]
        ))
        primary = records[ordered[0]]["record_hash"]
        for index in ordered:
            primary_hashes[index] = primary
        shadow_indices.update(ordered[1:])

    plans: list[dict] = []
    for index, rec in enumerate(records):
        base = base_decision(rec)
        decision = "duplicate_shadow_blocked" if index in shadow_indices else base
        category = rec["pickup_category"]
        ready = decision == "baseline_ready"
        blocked = decision in {"duplicate_shadow_blocked", "invalid_placeholder", "mission_story_excluded"}
        requires_interior = int(
            (rec.get("position_resolved") and float(rec.get("pos_z", 0.0)) >= 800.0)
            or decision == "interior_ipl_deferred"
        )
        requires_account = int(category.startswith("collectible_") or category in {"property_for_sale", "property_locked", "savegame"})
        requires_backend = int(not ready and decision not in {"reference_only", "invalid_placeholder", "mission_story_excluded", "duplicate_shadow_blocked"})
        plans.append({
            "record_hash": rec["record_hash"],
            "base_decision_code": base,
            "decision_code": decision,
            "canonical_category": category,
            "runtime_target": runtime_target(rec, base),
            "canonical_model_id": rec.get("model_id"),
            "canonical_pickup_type": canonical_type(category),
            "canonical_amount": canonical_amount(rec),
            "canonical_cooldown_seconds": cooldown(category),
            "canonical_weapon_id": int(rec.get("weapon_id_guess") or 0),
            "canonical_ammo": int(rec["ammo_amount"]) if rec.get("ammo_amount") is not None else None,
            "recommended_interior": 0 if rec.get("position_resolved") and float(rec.get("pos_z", 0.0)) < 800.0 else -1,
            "recommended_virtual_world": 0 if rec.get("position_resolved") and float(rec.get("pos_z", 0.0)) < 800.0 else -1,
            "runtime_z_lift": 0.25 if ready else 0.0,
            "duplicate_resolution": "shadow_blocked" if decision == "duplicate_shadow_blocked" else ("primary" if rec.get("duplicate_key") else "unique"),
            "duplicate_primary_record_hash": primary_hashes.get(index, ""),
            "requires_interior_context": requires_interior,
            "requires_backend_bridge": requires_backend,
            "requires_account_persistence": requires_account,
            "safety_class": "ready" if ready else ("blocked" if blocked else "deferred"),
            "review_status": "ready" if ready else ("blocked" if blocked else "deferred"),
            "enabled": 0,
            "apply_status": "draft",
        })
    return plans


def write_markdown(path: Path, plans: list[dict]) -> None:
    decisions = collections.Counter(plan["decision_code"] for plan in plans)
    baseline = collections.Counter(
        plan["canonical_category"] for plan in plans if plan["decision_code"] == "baseline_ready"
    )
    lines = [
        "# GTA SA Pickup Canonical Resolver — SAIF v0.26A.1.18",
        "",
        f"- Total plans: **{len(plans)}**",
        f"- Baseline-ready: **{decisions['baseline_ready']}**",
        f"- Police bribe baseline: **{baseline['bribe']}**",
        f"- Body armour baseline: **{baseline['armor']}**",
        f"- Duplicate shadows blocked: **{decisions['duplicate_shadow_blocked']}**",
        "- Runtime mutation: **none**",
        "",
        "## Decisions",
        "",
        "| Decision | Rows |",
        "|---|---:|",
    ]
    for decision, count in decisions.most_common():
        lines.append(f"| `{decision}` | {count} |")
    path.write_text("\n".join(lines) + "\n", encoding="utf-8")


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("input_json", type=Path)
    parser.add_argument("--output-json", type=Path, required=True)
    parser.add_argument("--output-md", type=Path)
    args = parser.parse_args()

    source = json.loads(args.input_json.read_text(encoding="utf-8"))
    if source.get("parser_version") != PARSER_VERSION:
        raise SystemExit(f"Expected {PARSER_VERSION}, got {source.get('parser_version')}")

    plans = resolve(source["records"])
    decisions = collections.Counter(plan["decision_code"] for plan in plans)
    baseline = collections.Counter(
        plan["canonical_category"] for plan in plans if plan["decision_code"] == "baseline_ready"
    )
    if len(plans) != 782 or decisions["baseline_ready"] != 89 or baseline != {"bribe": 49, "armor": 40}:
        raise SystemExit("Resolver invariant failed; source dataset differs from accepted v0.26A.1.17 audit.")

    payload_checksum = hashlib.sha256(
        json.dumps(plans, sort_keys=True, separators=(",", ":")).encode()
    ).hexdigest()
    report = {
        "version": "v0.26A.1.18",
        "resolver_version": RESOLVER_VERSION,
        "source_parser_version": PARSER_VERSION,
        "payload_checksum": payload_checksum,
        "summary": {
            "total": len(plans),
            "decisions": dict(sorted(decisions.items())),
            "baseline_categories": dict(sorted(baseline.items())),
            "enabled_rows": sum(plan["enabled"] for plan in plans),
            "non_draft_rows": sum(plan["apply_status"] != "draft" for plan in plans),
        },
        "plans": plans,
    }
    args.output_json.parent.mkdir(parents=True, exist_ok=True)
    args.output_json.write_text(json.dumps(report, indent=2), encoding="utf-8")
    if args.output_md:
        args.output_md.parent.mkdir(parents=True, exist_ok=True)
        write_markdown(args.output_md, plans)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
