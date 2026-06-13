#!/usr/bin/env python3
"""SAIF v0.26A.1.22 GTA SA house/property canonical resolver.

Input: GTASA_HOUSE_PROPERTY_SOURCE_AUDIT_v0.26A.1.21.json
Output: canonical 32-slot plan. This tool never connects to MariaDB and never mutates runtime data.
"""
from __future__ import annotations
import argparse, json, math, hashlib
from pathlib import Path

RESOLVER_VERSION = "saif-house-property-resolver-v0.26A.1.22"

def distance(a,b):
    return ((a["position_x"]-b["position_x"])**2+(a["position_y"]-b["position_y"])**2+(a["position_z"]-b["position_z"])**2)**0.5

def main():
    ap=argparse.ArgumentParser()
    ap.add_argument("input_json", type=Path)
    ap.add_argument("output_json", type=Path)
    args=ap.parse_args()
    src=json.loads(args.input_json.read_text(encoding="utf-8"))
    recs=src["records"]
    forsale={r["slot_index"]:r for r in recs if r["evidence_type"]=="property_for_sale_pickup"}
    enex=[r for r in recs if r["evidence_type"] in ("enex_savehouse","enex_property")]
    plans=[]
    for slot in range(32):
        row=forsale[slot]
        nearest=min(enex,key=lambda e:distance(row,e))
        exterior=nearest if distance(row,nearest)<=25.0 else None
        interior=None
        if exterior:
            candidates=[e for e in enex if e["raw_name"]==exterior["raw_name"] and e["interior_id"]>0]
            if candidates: interior=sorted(candidates,key=lambda e:(e["source_file"],e["source_line"]))[0]
        decision="baseline_ready" if slot>=3 else ("story_asset_deferred" if slot==2 else "business_asset_deferred")
        plans.append({
            "slot_index":slot,
            "decision_code":decision,
            "for_sale_hash":row["record_hash"],
            "exterior_hash":exterior["record_hash"] if exterior else "",
            "interior_hash":interior["record_hash"] if interior else "",
            "pair_group_key":exterior["raw_name"] if exterior else "",
            "price_value":row["price_value"],
        })
    out={"resolver_version":RESOLVER_VERSION,"total":len(plans),"baseline_ready":sum(p["decision_code"]=="baseline_ready" for p in plans),"plans":plans}
    args.output_json.write_text(json.dumps(out,indent=2),encoding="utf-8")
if __name__=="__main__": main()
