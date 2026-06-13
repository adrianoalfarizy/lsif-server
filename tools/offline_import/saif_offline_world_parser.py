#!/usr/bin/env python3
"""SAIF GTA San Andreas offline-world staging parser.

Stage v0.26A.1.5 scope:
- register raw/decompiled source files;
- parse text IPL ENEX sections;
- resolve broad map/info zone codes;
- generate idempotent MySQL staging SQL;
- never write to SAIF runtime tables.

No third-party modules are required.
"""

from __future__ import annotations

import argparse
import csv
import hashlib
import json
import os
import sys
from dataclasses import asdict, dataclass
from datetime import datetime, timezone
from pathlib import Path
from typing import Iterable, Optional

PARSER_VERSION = "saif-offline-parser-v0.26A.1.5"

SECTION_NAMES = {
    "inst", "cull", "pick", "path", "grge", "enex", "cars", "jump",
    "tcyc", "auzo", "mult", "occl", "zone",
}


@dataclass(frozen=True)
class Zone:
    source: str
    name: str
    text_key: str
    min_x: float
    min_y: float
    min_z: float
    max_x: float
    max_y: float
    max_z: float

    @property
    def area_xy(self) -> float:
        return abs((self.max_x - self.min_x) * (self.max_y - self.min_y))

    def contains(self, x: float, y: float, z: float) -> bool:
        return (
            self.min_x <= x <= self.max_x
            and self.min_y <= y <= self.max_y
            and self.min_z <= z <= self.max_z
        )


@dataclass
class SourceFile:
    relative_path: str
    file_name: str
    extension: str
    source_type: str
    size_bytes: int
    sha256: str
    parse_status: str = "registered"
    record_count: int = 0
    warning_text: str = ""


@dataclass
class InteriorQueueRow:
    source_file: str
    source_line: int
    record_hash: str
    raw_name: str
    display_name: str
    category: str
    context_type: str
    confidence: int
    entry_x: float
    entry_y: float
    entry_z: float
    entry_a: float
    entry_size_x: float
    entry_size_y: float
    entry_size_z: float
    exit_x: float
    exit_y: float
    exit_z: float
    exit_a: float
    interior_id: int
    flags: int
    sky_color: int
    num_peds: int
    time_on: int
    time_off: int
    city_code: str
    area_code: str
    notes: str
    raw_record: str


@dataclass
class ParseWarning:
    source_file: str
    source_line: int
    message: str


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def sql_string(value: object) -> str:
    if value is None:
        return "NULL"
    text = str(value)
    # MySQL-safe literal without depending on backslash escape mode.
    text = text.replace("'", "''")
    return "'" + text + "'"


def sql_float(value: float) -> str:
    return format(value, ".8f").rstrip("0").rstrip(".") if value else "0"


def detect_source_root(input_path: Path) -> Path:
    path = input_path.resolve()
    candidates = [path, *[p for p in path.iterdir() if p.is_dir()]] if path.is_dir() else []
    for candidate in candidates:
        if (candidate / "00_RAW" / "data").is_dir():
            return candidate
    raise FileNotFoundError(
        f"Tidak menemukan struktur 00_RAW/data di {input_path}. "
        "Arahkan --source-root ke folder SAIF-OFFLINE-SOURCE."
    )


def source_type_for(relative_path: str) -> str:
    lower = relative_path.lower()
    suffix = Path(lower).suffix
    if lower.endswith("main.scm"):
        return "SCM_BINARY"
    if lower.endswith("script.img"):
        return "SCM_EXTERNAL_ARCHIVE"
    if "01_decompiled/" in lower and lower.endswith(".txt"):
        return "SCM_DECOMPILED"
    if suffix == ".ipl":
        return "IPL"
    if suffix == ".ide":
        return "IDE"
    if suffix == ".zon":
        return "ZONE"
    if suffix == ".dat":
        return "DAT"
    if suffix == ".cfg":
        return "CONFIG"
    if suffix == ".img":
        return "IMG"
    if suffix == ".txt":
        return "TEXT"
    return "OTHER"


def discover_source_files(source_root: Path) -> list[tuple[Path, SourceFile]]:
    selected_roots = [source_root / "00_RAW" / "data"]
    decompiled = source_root / "01_DECOMPILED" / "main_decompiled.txt"

    paths: list[Path] = []
    for root in selected_roots:
        paths.extend(p for p in root.rglob("*") if p.is_file())
    if decompiled.is_file():
        paths.append(decompiled)

    result: list[tuple[Path, SourceFile]] = []
    for path in sorted(set(paths), key=lambda p: p.as_posix().lower()):
        relative = path.relative_to(source_root).as_posix()
        result.append(
            (
                path,
                SourceFile(
                    relative_path=relative,
                    file_name=path.name,
                    extension=path.suffix.lower().lstrip("."),
                    source_type=source_type_for(relative),
                    size_bytes=path.stat().st_size,
                    sha256=sha256_file(path),
                ),
            )
        )
    return result


def parse_zone_file(path: Path, source_root: Path) -> list[Zone]:
    zones: list[Zone] = []
    section: Optional[str] = None
    for raw_line in path.read_text(encoding="latin-1", errors="replace").splitlines():
        stripped = raw_line.strip()
        if not stripped or stripped.startswith("#"):
            continue
        lower = stripped.lower()
        if lower == "zone":
            section = "zone"
            continue
        if lower == "end":
            section = None
            continue
        if section != "zone":
            continue

        fields = next(csv.reader([stripped], skipinitialspace=True))
        if len(fields) < 10:
            continue
        try:
            zones.append(
                Zone(
                    source=path.relative_to(source_root).as_posix(),
                    name=fields[0].strip(),
                    text_key=fields[9].strip(),
                    min_x=float(fields[2]),
                    min_y=float(fields[3]),
                    min_z=float(fields[4]),
                    max_x=float(fields[5]),
                    max_y=float(fields[6]),
                    max_z=float(fields[7]),
                )
            )
        except ValueError:
            continue
    return zones


def resolve_zone(zones: Iterable[Zone], x: float, y: float, z: float) -> str:
    matches = [zone for zone in zones if zone.contains(x, y, z)]
    if not matches:
        # Some exterior ENEX Z values are slightly outside info.zon's practical bounds.
        matches = [
            zone
            for zone in zones
            if zone.min_x <= x <= zone.max_x and zone.min_y <= y <= zone.max_y
        ]
    if not matches:
        return ""
    selected = min(matches, key=lambda zone: zone.area_xy)
    text_key = selected.text_key.strip()
    if text_key and text_key.upper() not in {"UNUSED", "NONE", "NULL"}:
        return text_key
    return selected.name


def classify_enex(raw_name: str, source_file: str) -> tuple[str, str, str, int, str]:
    name = raw_name.strip().upper()
    notes: list[str] = []

    rules: list[tuple[tuple[str, ...], str, str, str, int]] = [
        (("AMMUN",), "shop", "ammunation", "Ammu-Nation", 100),
        (("FDCHICK",), "restaurant", "cluckin_bell", "Cluckin' Bell", 100),
        (("FDPIZA",), "restaurant", "pizza_stack", "Pizza Stack", 100),
        (("FDBURG",), "restaurant", "burger_shot", "Burger Shot", 100),
        (("FDDONUT",), "restaurant", "donut_shop", "Donut Shop", 98),
        (("FDREST", "DINER", "TSDINER", "REST"), "restaurant", "restaurant", "Restaurant / Diner", 88),
        (("X7_11", "X711"), "shop", "247", "24/7", 100),
        (("BARBER",), "shop", "barber", "Barber Shop", 100),
        (("TATTO",), "shop", "tattoo", "Tattoo Parlor", 100),
        (("CLOTH", "CSCHP", "CSSPRT", "CSEXL"), "shop", "clothing", "Clothing Store", 98),
        (("CHANGER",), "service", "wardrobe", "Wardrobe / Changing Room", 95),
        (("GYM",), "service", "gym", "Gym", 100),
        (("POLICE",), "service", "police", "Police Station", 100),
        (("CASINO", "MAFCAS", "TRICAS"), "entertainment", "casino", "Casino", 96),
        (("CARMOD",), "garage", "vehicle_mod_shop", "Vehicle Modification Shop", 100),
        (("BIKESCH",), "service", "bike_school", "Bike School", 100),
        (("DRIVES",), "service", "driving_school", "Driving School", 100),
        (("AIRPORT", "AIRPOR2"), "transport", "airport", "Airport", 98),
        (("PDOMES", "8TRACK", "DIRBIKE"), "entertainment", "stadium", "Stadium / Event Interior", 92),
        (("BAR1", "BAR2", "UFOBAR"), "entertainment", "bar", "Bar", 90),
        (("STRIP", "LASTRIP"), "entertainment", "club", "Club", 90),
        (("SEXSHOP",), "shop", "adult_shop", "Adult Shop", 95),
        (("BROTHL", "BROTHEL"), "mission", "adult_venue", "Story / Adult Venue", 82),
        (("GANG",), "gang", "gang_hq", "Gang Interior", 90),
        (("SV", "SFHS", "LAHS", "VGHS"), "property", "savehouse", "Savehouse / Property", 82),
        (("DESHOUS", "BURHOUS", "MOTEL"), "property", "property", "House / Property", 80),
    ]

    for prefixes, category, context_type, display_name, confidence in rules:
        if any(name.startswith(prefix) for prefix in prefixes):
            return category, context_type, display_name, confidence, ""

    mission_names = {
        "MADDOGS", "MDDOGS", "CARTER", "RYDERS", "SWEETS", "OGLOCS",
        "BDUPS", "BDUPS1", "STUDIO", "WUZIBET", "PAPER", "ABATOIR",
        "SMASHTV", "JETINT", "MOROOM", "RCPLAY", "GF1", "GF2", "GF3",
        "GF4", "GF5", "GF6", "DAMIN", "DAMOUT", "STUDRAN",
    }
    if name in mission_names:
        return "mission", "story_interior", name.title(), 78, "Kandidat interior story/mission; jangan apply otomatis."

    if not name:
        notes.append("Nama ENEX kosong; wajib review manual.")
        return "unknown", "unknown", "Unnamed ENEX", 20, " ".join(notes)

    # Source path can add a weak hint, but does not auto-approve anything.
    if "/interior/" in source_file.lower():
        notes.append("Berasal dari IPL folder interior; konteks belum teridentifikasi.")
    return "unknown", "unknown", name, 40, " ".join(notes)


def parse_enex_rows(
    source_root: Path,
    source_entries: list[tuple[Path, SourceFile]],
    city_zones: list[Zone],
    info_zones: list[Zone],
) -> tuple[list[InteriorQueueRow], list[ParseWarning]]:
    rows: list[InteriorQueueRow] = []
    warnings: list[ParseWarning] = []

    for path, source_file in source_entries:
        if path.suffix.lower() != ".ipl":
            continue

        section: Optional[str] = None
        file_records = 0
        lines = path.read_text(encoding="latin-1", errors="replace").splitlines()
        for line_no, raw_line in enumerate(lines, start=1):
            stripped = raw_line.strip()
            if not stripped or stripped.startswith("#"):
                continue
            lower = stripped.lower()
            if lower in SECTION_NAMES:
                section = lower
                continue
            if lower == "end":
                section = None
                continue
            if section != "enex":
                continue

            try:
                fields = next(csv.reader([stripped], skipinitialspace=True))
            except csv.Error as exc:
                warnings.append(ParseWarning(source_file.relative_path, line_no, f"CSV error: {exc}"))
                continue

            if len(fields) != 18:
                warnings.append(
                    ParseWarning(
                        source_file.relative_path,
                        line_no,
                        f"ENEX field count {len(fields)}; expected 18.",
                    )
                )
                continue

            try:
                entry_x = float(fields[0])
                entry_y = float(fields[1])
                entry_z = float(fields[2])
                entry_a = float(fields[3])
                entry_size_x = float(fields[4])
                entry_size_y = float(fields[5])
                entry_size_z = float(fields[6])
                exit_x = float(fields[7])
                exit_y = float(fields[8])
                exit_z = float(fields[9])
                exit_a = float(fields[10])
                interior_id = int(float(fields[11]))
                flags = int(float(fields[12]))
                raw_name = fields[13].strip()
                sky_color = int(float(fields[14]))
                num_peds = int(float(fields[15]))
                time_on = int(float(fields[16]))
                time_off = int(float(fields[17]))
            except ValueError as exc:
                warnings.append(ParseWarning(source_file.relative_path, line_no, f"Numeric parse error: {exc}"))
                continue

            category, context_type, display_name, confidence, notes = classify_enex(
                raw_name, source_file.relative_path
            )
            city_code = resolve_zone(city_zones, entry_x, entry_y, entry_z)
            area_code = resolve_zone(info_zones, entry_x, entry_y, entry_z)

            canonical = "|".join(
                [
                    source_file.sha256,
                    str(line_no),
                    stripped,
                ]
            )
            record_hash = hashlib.sha256(canonical.encode("utf-8")).hexdigest()

            if abs(entry_x) > 4000 or abs(entry_y) > 4000 or entry_z < -1000 or entry_z > 2000:
                notes = (notes + " Koordinat entry di luar range audit normal.").strip()
                confidence = min(confidence, 25)
                warnings.append(
                    ParseWarning(source_file.relative_path, line_no, "Koordinat entry di luar range audit normal.")
                )

            if not raw_name:
                warnings.append(ParseWarning(source_file.relative_path, line_no, "Nama ENEX kosong."))

            rows.append(
                InteriorQueueRow(
                    source_file=source_file.relative_path,
                    source_line=line_no,
                    record_hash=record_hash,
                    raw_name=raw_name,
                    display_name=display_name,
                    category=category,
                    context_type=context_type,
                    confidence=confidence,
                    entry_x=entry_x,
                    entry_y=entry_y,
                    entry_z=entry_z,
                    entry_a=entry_a,
                    entry_size_x=entry_size_x,
                    entry_size_y=entry_size_y,
                    entry_size_z=entry_size_z,
                    exit_x=exit_x,
                    exit_y=exit_y,
                    exit_z=exit_z,
                    exit_a=exit_a,
                    interior_id=interior_id,
                    flags=flags,
                    sky_color=sky_color,
                    num_peds=num_peds,
                    time_on=time_on,
                    time_off=time_off,
                    city_code=city_code,
                    area_code=area_code,
                    notes=notes,
                    raw_record=stripped,
                )
            )
            file_records += 1

        if file_records:
            source_file.parse_status = "parsed"
            source_file.record_count = file_records
        elif source_file.source_type == "IPL":
            source_file.parse_status = "parsed_no_enex"

    return rows, warnings


def compute_session_key(source_entries: list[tuple[Path, SourceFile]]) -> str:
    digest = hashlib.sha256()
    digest.update(PARSER_VERSION.encode("ascii"))
    for _, source_file in source_entries:
        digest.update(source_file.relative_path.encode("utf-8"))
        digest.update(source_file.sha256.encode("ascii"))
    return digest.hexdigest()


def write_import_sql(
    output_path: Path,
    source_root: Path,
    source_root_label: str,
    session_label: str,
    source_version: str,
    session_key: str,
    source_entries: list[tuple[Path, SourceFile]],
    rows: list[InteriorQueueRow],
    warnings: list[ParseWarning],
) -> None:
    generated_at = datetime.now(timezone.utc).isoformat()
    lines: list[str] = [
        "-- SAIF v0.26A.1.5 GTA SA Offline Source Registry + ENEX Queue import",
        f"-- Generated by {PARSER_VERSION} at {generated_at}",
        "-- SAFETY: staging tables only; no runtime table is modified.",
        "SET NAMES utf8mb4;",
        "START TRANSACTION;",
        "",
        "INSERT INTO offline_import_sessions",
        "(session_key, session_label, source_root, source_version, parser_version, status, total_files, parsed_files, total_records, warning_count, error_count)",
        "VALUES (",
        f"  {sql_string(session_key)}, {sql_string(session_label)}, {sql_string(source_root_label)},",
        f"  {sql_string(source_version)}, {sql_string(PARSER_VERSION)}, 'parsed',",
        f"  {len(source_entries)}, {sum(1 for _, f in source_entries if f.parse_status.startswith('parsed'))}, {len(rows)}, {len(warnings)}, 0",
        ")",
        "ON DUPLICATE KEY UPDATE",
        "  id = LAST_INSERT_ID(id),",
        "  session_label = VALUES(session_label),",
        "  source_root = VALUES(source_root),",
        "  source_version = VALUES(source_version),",
        "  parser_version = VALUES(parser_version),",
        "  status = VALUES(status),",
        "  total_files = VALUES(total_files),",
        "  parsed_files = VALUES(parsed_files),",
        "  total_records = VALUES(total_records),",
        "  warning_count = VALUES(warning_count),",
        "  error_count = VALUES(error_count),",
        "  updated_at = CURRENT_TIMESTAMP;",
        "SET @offline_session_id := LAST_INSERT_ID();",
        "",
        "-- Keep reruns idempotent without resetting queue review/apply state.",
        "DELETE FROM offline_import_logs",
        "WHERE session_id = @offline_session_id AND component = 'ENEX_PARSER';",
        "",
    ]

    for _, source_file in source_entries:
        lines.extend(
            [
                "INSERT INTO offline_source_files",
                "(session_id, relative_path, file_name, extension, source_type, size_bytes, sha256, parse_status, record_count, warning_text)",
                "VALUES (",
                f"  @offline_session_id, {sql_string(source_file.relative_path)}, {sql_string(source_file.file_name)},",
                f"  {sql_string(source_file.extension)}, {sql_string(source_file.source_type)}, {source_file.size_bytes},",
                f"  {sql_string(source_file.sha256)}, {sql_string(source_file.parse_status)}, {source_file.record_count}, {sql_string(source_file.warning_text)}",
                ")",
                "ON DUPLICATE KEY UPDATE",
                "  file_name = VALUES(file_name), extension = VALUES(extension), source_type = VALUES(source_type),",
                "  size_bytes = VALUES(size_bytes), sha256 = VALUES(sha256), parse_status = VALUES(parse_status),",
                "  record_count = VALUES(record_count), warning_text = VALUES(warning_text), updated_at = CURRENT_TIMESTAMP;",
            ]
        )

    lines.append("")
    for row in rows:
        values = [
            "@offline_session_id",
            "NULL",
            sql_string(row.source_file),
            str(row.source_line),
            sql_string(row.record_hash),
            "'IPL_ENEX'",
            sql_string(row.raw_name),
            sql_string(row.display_name),
            sql_string(row.category),
            sql_string(row.context_type),
            str(row.confidence),
            sql_float(row.entry_x),
            sql_float(row.entry_y),
            sql_float(row.entry_z),
            sql_float(row.entry_a),
            sql_float(row.entry_size_x),
            sql_float(row.entry_size_y),
            sql_float(row.entry_size_z),
            sql_float(row.exit_x),
            sql_float(row.exit_y),
            sql_float(row.exit_z),
            sql_float(row.exit_a),
            str(row.interior_id),
            str(row.flags),
            str(row.sky_color),
            str(row.num_peds),
            str(row.time_on),
            str(row.time_off),
            sql_string(row.city_code),
            sql_string(row.area_code),
            "0",
            "'pending'",
            "'pending'",
            "'offline_enex_queue'",
            sql_string(row.notes),
            sql_string(row.raw_record),
        ]
        lines.extend(
            [
                "INSERT INTO offline_interior_queue",
                "(session_id, source_file_id, source_file, source_line, record_hash, source_type, raw_name, display_name, category, context_type, confidence,",
                " entry_x, entry_y, entry_z, entry_a, entry_size_x, entry_size_y, entry_size_z, exit_x, exit_y, exit_z, exit_a, interior_id, flags,",
                " sky_color, num_peds, time_on, time_off, city_code, area_code, enabled, review_status, apply_status, source_tag, notes, raw_record)",
                "VALUES (" + ", ".join(values) + ")",
                "ON DUPLICATE KEY UPDATE",
                "  session_id = VALUES(session_id), source_file = VALUES(source_file), source_line = VALUES(source_line),",
                "  raw_name = VALUES(raw_name), display_name = VALUES(display_name), category = VALUES(category),",
                "  context_type = VALUES(context_type), confidence = VALUES(confidence),",
                "  entry_x = VALUES(entry_x), entry_y = VALUES(entry_y), entry_z = VALUES(entry_z), entry_a = VALUES(entry_a),",
                "  entry_size_x = VALUES(entry_size_x), entry_size_y = VALUES(entry_size_y), entry_size_z = VALUES(entry_size_z),",
                "  exit_x = VALUES(exit_x), exit_y = VALUES(exit_y), exit_z = VALUES(exit_z), exit_a = VALUES(exit_a),",
                "  interior_id = VALUES(interior_id), flags = VALUES(flags), sky_color = VALUES(sky_color),",
                "  num_peds = VALUES(num_peds), time_on = VALUES(time_on), time_off = VALUES(time_off),",
                "  city_code = VALUES(city_code), area_code = VALUES(area_code), notes = VALUES(notes), raw_record = VALUES(raw_record),",
                "  updated_at = CURRENT_TIMESTAMP;",
            ]
        )

    lines.extend(
        [
            "",
            "UPDATE offline_interior_queue q",
            "JOIN offline_source_files f",
            "  ON f.session_id = q.session_id AND f.relative_path = q.source_file",
            "SET q.source_file_id = f.id",
            "WHERE q.session_id = @offline_session_id;",
            "",
        ]
    )

    for warning in warnings:
        lines.extend(
            [
                "INSERT INTO offline_import_logs",
                "(session_id, log_level, component, message, source_file, source_line)",
                "VALUES (",
                f"  @offline_session_id, 'warning', 'ENEX_PARSER', {sql_string(warning.message)},",
                f"  {sql_string(warning.source_file)}, {warning.source_line}",
                ");",
            ]
        )

    lines.extend(
        [
            "",
            "COMMIT;",
            "",
            "-- Expected for supplied vanilla source: 376 IPL_ENEX queue rows.",
            "SELECT @offline_session_id AS imported_session_id;",
            "SELECT COUNT(*) AS source_file_rows FROM offline_source_files WHERE session_id = @offline_session_id;",
            "SELECT COUNT(*) AS enex_queue_rows FROM offline_interior_queue WHERE session_id = @offline_session_id;",
        ]
    )
    output_path.write_text("\n".join(lines) + "\n", encoding="utf-8")


def main() -> int:
    parser = argparse.ArgumentParser(description="Generate SAIF offline-world staging SQL from GTA SA source files.")
    parser.add_argument("--source-root", required=True, help="Folder containing 00_RAW/data and optionally 01_DECOMPILED.")
    parser.add_argument("--output-sql", required=True, help="Generated MySQL import SQL path.")
    parser.add_argument("--output-json", required=True, help="Generated audit JSON path.")
    parser.add_argument("--session-label", default="GTA SA Offline Source Full", help="Human-readable import label.")
    parser.add_argument("--source-root-label", default="SAIF-OFFLINE-SOURCE", help="Logical source label stored in DB; avoids temporary parser paths.")
    parser.add_argument("--source-version", default="GTA SA PC 1.0 US", help="Source version label.")
    args = parser.parse_args()

    source_root = detect_source_root(Path(args.source_root))
    source_entries = discover_source_files(source_root)
    if not source_entries:
        raise RuntimeError("Tidak ada source file yang ditemukan.")

    raw_data = source_root / "00_RAW" / "data"
    city_zones = parse_zone_file(raw_data / "map.zon", source_root) if (raw_data / "map.zon").is_file() else []
    info_zones = parse_zone_file(raw_data / "info.zon", source_root) if (raw_data / "info.zon").is_file() else []
    rows, warnings = parse_enex_rows(source_root, source_entries, city_zones, info_zones)
    session_key = compute_session_key(source_entries)

    output_sql = Path(args.output_sql)
    output_json = Path(args.output_json)
    output_sql.parent.mkdir(parents=True, exist_ok=True)
    output_json.parent.mkdir(parents=True, exist_ok=True)

    write_import_sql(
        output_sql,
        source_root,
        args.source_root_label,
        args.session_label,
        args.source_version,
        session_key,
        source_entries,
        rows,
        warnings,
    )

    category_counts: dict[str, int] = {}
    context_counts: dict[str, int] = {}
    for row in rows:
        category_counts[row.category] = category_counts.get(row.category, 0) + 1
        context_counts[row.context_type] = context_counts.get(row.context_type, 0) + 1

    report = {
        "parser_version": PARSER_VERSION,
        "generated_at_utc": datetime.now(timezone.utc).isoformat(),
        "source_root": args.source_root_label,
        "source_root_label": args.source_root_label,
        "session_key": session_key,
        "session_label": args.session_label,
        "source_version": args.source_version,
        "source_file_count": len(source_entries),
        "parsed_source_file_count": sum(1 for _, f in source_entries if f.parse_status.startswith("parsed")),
        "city_zone_count": len(city_zones),
        "info_zone_count": len(info_zones),
        "enex_queue_count": len(rows),
        "warning_count": len(warnings),
        "category_counts": dict(sorted(category_counts.items())),
        "context_counts": dict(sorted(context_counts.items())),
        "warnings": [asdict(warning) for warning in warnings],
        "source_files": [asdict(source_file) for _, source_file in source_entries],
        "interior_queue": [asdict(row) for row in rows],
    }
    output_json.write_text(json.dumps(report, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")

    print(f"Source root     : {source_root}")
    print(f"Source files    : {len(source_entries)}")
    print(f"City zones      : {len(city_zones)}")
    print(f"Info zones      : {len(info_zones)}")
    print(f"ENEX queue rows : {len(rows)}")
    print(f"Warnings        : {len(warnings)}")
    print(f"Session key     : {session_key}")
    print(f"SQL output      : {output_sql}")
    print(f"JSON output     : {output_json}")

    if len(rows) == 0:
        print("ERROR: tidak ada ENEX yang berhasil diparse.", file=sys.stderr)
        return 2
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
