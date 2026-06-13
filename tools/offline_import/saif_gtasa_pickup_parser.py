#!/usr/bin/env python3
"""SAIF v0.26A.1.17 GTA SA pickup source scanner.
Usage: python saif_gtasa_pickup_parser.py <SAIF-OFFLINE-SOURCE-root> <output.json>
Scans 01_DECOMPILED/main_decompiled.txt plus all 00_RAW/data/maps/**/*.ipl PICK sections.
The repository package already contains generated SQL and reports; this tool is for reproducible re-audit.
"""
from pathlib import Path
import re,json,sys,hashlib
from collections import Counter
if len(sys.argv)<3:
 print("Usage: python saif_gtasa_pickup_parser.py <source-root> <output.json>"); raise SystemExit(2)
root=Path(sys.argv[1]); main=root/'01_DECOMPILED/main_decompiled.txt'; maps=root/'00_RAW/data/maps'
commands=['create_pickup_with_ammo','create_snapshot_pickup','create_oyster_pickup','create_horseshoe_pickup','create_forsale_property_pickup','create_locked_property_pickup','create_protection_pickup','create_money_pickup','create_pickup']
rows=[]
for line_no,raw in enumerate(main.read_text(errors='ignore').splitlines(),1):
 clean=raw.split('//',1)[0]
 found=None
 for cmd in commands:
  if re.search(r'\b'+re.escape(cmd)+r'\b',clean,re.I): found=cmd; break
 if found: rows.append({'source_scope':'SCM','source_file':'01_DECOMPILED/main_decompiled.txt','source_line':line_no,'source_command':found,'record_hash':hashlib.sha256((str(line_no)+'|'+raw).encode()).hexdigest(),'raw_record':raw})
ipl_sections=[]
for f in sorted(maps.rglob('*.ipl')):
 in_pick=False; section_line=0; count=0
 for line_no,raw in enumerate(f.read_text(errors='ignore').splitlines(),1):
  s=raw.strip().lower()
  if s=='pick': in_pick=True; section_line=line_no; continue
  if in_pick and s=='end': break
  if in_pick and raw.strip() and not raw.lstrip().startswith('#'):
   p=[x.strip() for x in raw.split(',')]
   if len(p)>=4:
    try: int(p[0]); float(p[1]); float(p[2]); float(p[3])
    except: continue
    count+=1; rel='00_RAW/data/maps/'+str(f.relative_to(maps)).replace('\\','/')
    rows.append({'source_scope':'IPL','source_file':rel,'source_line':line_no,'source_command':'IPL_PICK','record_hash':hashlib.sha256((rel+'|'+str(line_no)+'|'+raw).encode()).hexdigest(),'raw_record':raw})
 if section_line: ipl_sections.append({'source_file':str(f),'section_line':section_line,'entry_count':count})
out={'total':len(rows),'commands':dict(Counter(r['source_command'] for r in rows)),'ipl_sections':ipl_sections,'rows':rows}
Path(sys.argv[2]).write_text(json.dumps(out,indent=2)); print(json.dumps({'total':out['total'],'commands':out['commands']},indent=2))
