#!/usr/bin/env python3
"""SAIF v0.26A.1.8 service-point resolver.
Pure Python, no pip dependencies. This tool validates the decompiled SCM markers used by the generated staging import.
It does not connect to MariaDB and cannot mutate runtime tables.
"""
from pathlib import Path
import argparse, json, re, sys
REQUIRED={
 "AMUNAT":["$keep_offX = 296.506","is_var_text_label_equal_to_text_label s$shop_name == 'AMMUN5'"],
 "TATTO":["$keep_offX = -203.318","is_var_text_label_equal_to_text_label s$shop_name == 'TATTO3'"],
 "BARB":["$keep_offX = 414.3","is_var_text_label_equal_to_text_label s$shop_name == 'BARBER3'"],
 "CLOTH":["$clothes_locateX = 214.622","is_var_text_label_equal_to_text_label s$shop_name == 'CSEXL'"],
 "JFUD":["$junkfudX = 374.0","$keep_off_dirY = 2.5"],
}
def main():
 p=argparse.ArgumentParser();p.add_argument('--scm',required=True);p.add_argument('--output-json',required=True);a=p.parse_args()
 text=Path(a.scm).read_text(encoding='utf-8',errors='replace')
 report={'source':str(Path(a.scm)),'checks':{},'ok':True}
 for block,markers in REQUIRED.items():
  missing=[m for m in markers if m not in text];report['checks'][block]={'markers':markers,'missing':missing,'ok':not missing}
  if missing: report['ok']=False
 Path(a.output_json).write_text(json.dumps(report,indent=2),encoding='utf-8')
 print(json.dumps({'ok':report['ok'],'output':a.output_json}))
 return 0 if report['ok'] else 2
if __name__=='__main__': raise SystemExit(main())
