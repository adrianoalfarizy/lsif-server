#!/usr/bin/env python3
"""SAIF v0.26A.1.21 property source composer.

Usage:
  python saif_gtasa_property_source_parser.py \
    --source-root SAIF-OFFLINE-SOURCE \
    --pickup-audit GTASA_OFFLINE_PICKUP_QUEUE_AUDIT_v0.26A.1.17.json \
    --enex-audit GTASA_OFFLINE_ENEX_AUDIT_v0.26A.1.5.json \
    --output house_property_source_audit.json

This tool deliberately composes prior exact-source audits instead of reinterpreting
SCM/ENEX from scratch, then scans IPL GRGE sections directly. It never connects to
MariaDB and never modifies SAIF runtime tables.
"""
from pathlib import Path
import argparse,csv,hashlib,json,re,collections

def h(s): return hashlib.sha256(s.encode()).hexdigest()
def slot(v):
    m=re.search(r'\[(\d+)\]',v or '')
    return int(m.group(1)) if m else -1

def main():
    ap=argparse.ArgumentParser(); ap.add_argument('--source-root',required=True); ap.add_argument('--pickup-audit',required=True); ap.add_argument('--enex-audit',required=True); ap.add_argument('--output',required=True); a=ap.parse_args()
    root=Path(a.source_root); pickup=json.load(open(a.pickup_audit,encoding='utf-8')); enex=json.load(open(a.enex_audit,encoding='utf-8'))
    lines=(root/'01_DECOMPILED/main_decompiled.txt').read_text(errors='ignore').splitlines(); assign={}
    for line in lines:
        m=re.match(r'\s*(\$[A-Za-z0-9_]+)\s*=\s*(-?\d+)\s*(?://.*)?$',line)
        if m: assign[m.group(1)]=int(m.group(2))
    rows=[]
    for r in pickup['records']:
        if r.get('pickup_category') not in ('property_for_sale','property_locked','savegame'): continue
        rows.append({'source':'SCM','kind':r['pickup_category'],'slot':slot(r.get('handle_name')),'price':assign.get(r.get('property_price_token','')),'x':r.get('pos_x',0),'y':r.get('pos_y',0),'z':r.get('pos_z',0),'file':r['source_file'],'line':r['source_line'],'hash':r['record_hash'],'raw':r['raw_record']})
    for r in enex['interior_queue']:
        if r.get('context_type') not in ('savehouse','property'): continue
        rows.append({'source':'IPL_ENEX','kind':'enex_'+r['context_type'],'name':r['raw_name'],'x':r['entry_x'],'y':r['entry_y'],'z':r['entry_z'],'exit':[r['exit_x'],r['exit_y'],r['exit_z']],'interior':r['interior_id'],'file':r['source_file'],'line':r['source_line'],'hash':r['record_hash'],'raw':r['raw_record']})
    maps=root/'00_RAW/data/maps'
    for f in maps.rglob('*.ipl'):
        sec=''
        for n,raw in enumerate(f.read_text(errors='ignore').splitlines(),1):
            s=raw.strip(); low=s.lower()
            if low in {'inst','cull','pick','path','grge','enex','cars','jump','tcyc','auzo','mult','occl','zone'}: sec=low; continue
            if low=='end': sec=''; continue
            if sec!='grge' or not s or s.startswith('#'): continue
            p=next(csv.reader([s],skipinitialspace=True))
            if len(p)>=11: rows.append({'source':'IPL_GRGE','kind':'garage_reference','name':p[10].strip(' "'),'file':'00_RAW/data/maps/'+f.relative_to(maps).as_posix(),'line':n,'hash':h(str(f)+str(n)+raw),'raw':raw})
    counts=collections.Counter(r['kind'] for r in rows)
    out={'parser_version':'saif-property-source-parser-v0.26A.1.21','total':len(rows),'counts':dict(counts),'rows':rows}
    Path(a.output).write_text(json.dumps(out,indent=2),encoding='utf-8'); print(json.dumps({'total':len(rows),'counts':dict(counts)},indent=2))
if __name__=='__main__': main()
