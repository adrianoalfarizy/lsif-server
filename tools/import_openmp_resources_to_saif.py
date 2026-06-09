#!/usr/bin/env python3
"""
SAIF / LSIF open.mp resource importer.

Purpose:
- Fetch official open.mp resource pages.
- Extract table/list rows generically.
- Store them as raw searchable resource rows in saif_resource_items.
- Does NOT spawn resources in-game. Everything is imported disabled/staging by default.

Install on Ubuntu:
    python3 -m pip install requests beautifulsoup4 pymysql

Usage examples:
    python3 tools/import_openmp_resources_to_saif.py --manifest tools/openmp_resources_manifest.json --write-sql /tmp/saif_openmp_resources_seed.sql

    python3 tools/import_openmp_resources_to_saif.py --manifest tools/openmp_resources_manifest.json \
      --mysql-host 127.0.0.1 --mysql-user lsif_user --mysql-password 'PASSWORD' --mysql-db lsif_db
"""
import argparse
import json
import re
import sys
from datetime import datetime
from pathlib import Path
from typing import Any, Dict, List, Optional, Tuple

import requests
from bs4 import BeautifulSoup

ID_PATTERNS = [
    re.compile(r"\b(?:ID|Model ID|Weapon ID|Skin ID|Sound ID|Vehicle Model ID)\s*:?\s*(\d{1,6})\b", re.I),
    re.compile(r"^\s*(\d{1,6})\s*(?:\||\t|\s{2,}|-|:)", re.I),
    re.compile(r"\b(\d{1,6})\b"),
]

NAME_KEYS = ["name", "vehicle name", "skin name", "weapon", "description", "texture", "library", "model name"]
CATEGORY_KEYS = ["category", "type", "class", "modifications"]
MODEL_KEYS = ["model name", "model", "texture", "library"]


def normalise_space(value: str) -> str:
    return re.sub(r"\s+", " ", value or "").strip()


def extract_first_int(text: str) -> Optional[int]:
    text = normalise_space(text)
    for pattern in ID_PATTERNS:
        m = pattern.search(text)
        if m:
            try:
                return int(m.group(1))
            except ValueError:
                return None
    return None


def pick_value(row: Dict[str, str], keys: List[str]) -> Optional[str]:
    lowered = {k.lower().strip(): v for k, v in row.items() if v}
    for key in keys:
        for lk, value in lowered.items():
            if key in lk:
                return normalise_space(value)
    return None


def parse_tables(soup: BeautifulSoup) -> List[Dict[str, str]]:
    rows: List[Dict[str, str]] = []
    for table in soup.find_all("table"):
        headers = [normalise_space(th.get_text(" ")) for th in table.find_all("th")]
        for tr in table.find_all("tr"):
            cells = [normalise_space(td.get_text(" ")) for td in tr.find_all("td")]
            if not cells:
                continue
            if headers and len(headers) == len(cells):
                row = {headers[i] or f"col_{i+1}": cells[i] for i in range(len(cells))}
            else:
                row = {f"col_{i+1}": cells[i] for i in range(len(cells))}
            if any(row.values()):
                rows.append(row)
    return rows


def parse_definition_like_content(soup: BeautifulSoup) -> List[Dict[str, str]]:
    """Fallback parser for Docusaurus pages that render resource rows as plain paragraphs/lists."""
    rows: List[Dict[str, str]] = []
    main = soup.find("main") or soup
    texts = []
    for tag in main.find_all(["p", "li", "pre", "code"]):
        text = normalise_space(tag.get_text(" "))
        if text and len(text) >= 2:
            texts.append(text)
    seen = set()
    for text in texts:
        if text in seen:
            continue
        seen.add(text)
        if extract_first_int(text) is not None:
            rows.append({"raw": text})
    return rows


def fetch_source(source: Dict[str, Any], timeout: int = 30) -> Tuple[List[Dict[str, str]], str]:
    url = source["url"]
    headers = {"User-Agent": "SAIF-openmp-resource-importer/1.0"}
    response = requests.get(url, headers=headers, timeout=timeout)
    response.raise_for_status()
    soup = BeautifulSoup(response.text, "html.parser")
    rows = parse_tables(soup)
    if not rows:
        rows = parse_definition_like_content(soup)
    return rows, response.url


def make_item(source: Dict[str, Any], row: Dict[str, str]) -> Dict[str, Any]:
    raw_label = normalise_space(" | ".join(str(v) for v in row.values() if v))[:255]
    external_id = extract_first_int(raw_label)
    name = pick_value(row, NAME_KEYS)
    category = pick_value(row, CATEGORY_KEYS)
    model_name = pick_value(row, MODEL_KEYS)

    if not name:
        # Try to form a short name from raw label with the first ID removed.
        name_candidate = re.sub(r"\b\d{1,6}\b", "", raw_label, count=1)
        name = normalise_space(name_candidate[:128]) or None

    return {
        "source_key": source["source_key"],
        "resource_group": source.get("resource_group", source["source_key"]),
        "external_id": external_id,
        "name": name[:128] if name else None,
        "category": category[:128] if category else None,
        "model_name": model_name[:128] if model_name else None,
        "raw_label": raw_label,
        "raw_json": json.dumps(row, ensure_ascii=False),
        "offline_like": 1 if source.get("offline_like", True) else 0,
    }


def sql_escape(value: Optional[Any]) -> str:
    if value is None:
        return "NULL"
    if isinstance(value, int):
        return str(value)
    text = str(value).replace("\\", "\\\\").replace("'", "''")
    return f"'{text}'"


def generate_sql(manifest: Dict[str, Any], all_items: List[Dict[str, Any]], logs: List[Dict[str, Any]]) -> str:
    now = datetime.utcnow().strftime("%Y-%m-%d %H:%M:%S")
    lines = [
        "-- Generated by import_openmp_resources_to_saif.py",
        f"-- Generated at UTC: {now}",
        "SET FOREIGN_KEY_CHECKS=0;",
        "",
    ]

    for source in manifest["sources"]:
        lines.append(
            "INSERT INTO saif_resource_sources (source_key, title, source_url, offline_like, enabled, last_imported_at, notes) VALUES "
            f"({sql_escape(source['source_key'])}, {sql_escape(source.get('title'))}, {sql_escape(source.get('url'))}, "
            f"{1 if source.get('offline_like', True) else 0}, 1, NOW(), {sql_escape('Imported from official open.mp docs manifest')}) "
            "ON DUPLICATE KEY UPDATE title=VALUES(title), source_url=VALUES(source_url), offline_like=VALUES(offline_like), last_imported_at=NOW();"
        )

    if all_items:
        lines.append("DELETE FROM saif_resource_items WHERE source_key IN (%s);" % ",".join(sql_escape(s["source_key"]) for s in manifest["sources"]))
        chunk_size = 250
        columns = "source_key, resource_group, external_id, name, category, model_name, raw_label, raw_json, offline_like, enabled, imported_at"
        for i in range(0, len(all_items), chunk_size):
            chunk = all_items[i:i + chunk_size]
            values = []
            for item in chunk:
                values.append("(" + ", ".join([
                    sql_escape(item["source_key"]),
                    sql_escape(item["resource_group"]),
                    sql_escape(item["external_id"]),
                    sql_escape(item["name"]),
                    sql_escape(item["category"]),
                    sql_escape(item["model_name"]),
                    sql_escape(item["raw_label"]),
                    sql_escape(item["raw_json"]),
                    str(item["offline_like"]),
                    "0",
                    "NOW()",
                ]) + ")")
            lines.append(f"INSERT INTO saif_resource_items ({columns}) VALUES\n" + ",\n".join(values) + ";")

    for log in logs:
        lines.append(
            "INSERT INTO saif_resource_import_logs (source_key, source_url, status, rows_found, message) VALUES "
            f"({sql_escape(log['source_key'])}, {sql_escape(log['source_url'])}, {sql_escape(log['status'])}, {int(log['rows_found'])}, {sql_escape(log['message'])});"
        )

    lines.append("SET FOREIGN_KEY_CHECKS=1;")
    lines.append("SELECT source_key, COUNT(*) AS imported_rows FROM saif_resource_items GROUP BY source_key ORDER BY source_key;")
    return "\n".join(lines) + "\n"


def import_mysql(args: argparse.Namespace, manifest: Dict[str, Any], all_items: List[Dict[str, Any]], logs: List[Dict[str, Any]]) -> None:
    import pymysql

    conn = pymysql.connect(
        host=args.mysql_host,
        port=args.mysql_port,
        user=args.mysql_user,
        password=args.mysql_password,
        database=args.mysql_db,
        charset="utf8mb4",
        autocommit=False,
    )
    try:
        with conn.cursor() as cur:
            for source in manifest["sources"]:
                cur.execute(
                    """
                    INSERT INTO saif_resource_sources (source_key, title, source_url, offline_like, enabled, last_imported_at, notes)
                    VALUES (%s,%s,%s,%s,1,NOW(),%s)
                    ON DUPLICATE KEY UPDATE title=VALUES(title), source_url=VALUES(source_url), offline_like=VALUES(offline_like), last_imported_at=NOW()
                    """,
                    (source["source_key"], source.get("title"), source.get("url"), 1 if source.get("offline_like", True) else 0, "Imported from official open.mp docs manifest"),
                )
            if all_items:
                cur.execute(
                    "DELETE FROM saif_resource_items WHERE source_key IN (" + ",".join(["%s"] * len(manifest["sources"])) + ")",
                    tuple(s["source_key"] for s in manifest["sources"]),
                )
                cur.executemany(
                    """
                    INSERT INTO saif_resource_items
                    (source_key, resource_group, external_id, name, category, model_name, raw_label, raw_json, offline_like, enabled, imported_at)
                    VALUES (%s,%s,%s,%s,%s,%s,%s,CAST(%s AS JSON),%s,0,NOW())
                    """,
                    [
                        (
                            item["source_key"], item["resource_group"], item["external_id"], item["name"],
                            item["category"], item["model_name"], item["raw_label"], item["raw_json"], item["offline_like"]
                        )
                        for item in all_items
                    ],
                )
            for log in logs:
                cur.execute(
                    "INSERT INTO saif_resource_import_logs (source_key, source_url, status, rows_found, message) VALUES (%s,%s,%s,%s,%s)",
                    (log["source_key"], log["source_url"], log["status"], log["rows_found"], log["message"]),
                )
            conn.commit()
    except Exception:
        conn.rollback()
        raise
    finally:
        conn.close()


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--manifest", required=True, help="Path to openmp_resources_manifest.json")
    parser.add_argument("--write-sql", help="Write SQL seed output instead of direct DB import")
    parser.add_argument("--mysql-host")
    parser.add_argument("--mysql-port", type=int, default=3306)
    parser.add_argument("--mysql-user")
    parser.add_argument("--mysql-password")
    parser.add_argument("--mysql-db")
    parser.add_argument("--timeout", type=int, default=30)
    args = parser.parse_args()

    manifest = json.loads(Path(args.manifest).read_text(encoding="utf-8"))
    all_items: List[Dict[str, Any]] = []
    logs: List[Dict[str, Any]] = []

    for source in manifest["sources"]:
        try:
            rows, final_url = fetch_source(source, timeout=args.timeout)
            items = [make_item(source, row) for row in rows]
            all_items.extend(items)
            logs.append({"source_key": source["source_key"], "source_url": final_url, "status": "ok", "rows_found": len(items), "message": "Imported"})
            print(f"OK {source['source_key']}: {len(items)} rows", file=sys.stderr)
        except Exception as exc:
            logs.append({"source_key": source["source_key"], "source_url": source["url"], "status": "error", "rows_found": 0, "message": str(exc)})
            print(f"ERROR {source['source_key']}: {exc}", file=sys.stderr)

    if args.write_sql:
        Path(args.write_sql).write_text(generate_sql(manifest, all_items, logs), encoding="utf-8")
        print(f"Wrote SQL seed: {args.write_sql}")
    elif args.mysql_host and args.mysql_user and args.mysql_db:
        import_mysql(args, manifest, all_items, logs)
        print(f"Imported {len(all_items)} rows into MySQL")
    else:
        print(generate_sql(manifest, all_items, logs))

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
