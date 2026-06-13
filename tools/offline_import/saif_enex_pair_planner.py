#!/usr/bin/env python3
"""SAIF v0.26A.1.7 ENEX pair planner (stdlib only).
Reads v0.26A.1.5 source audit JSON and v0.26A.1.6 resolver JSON, then writes a plan JSON.
It never connects to MariaDB and never mutates runtime tables.
"""
import argparse,json,hashlib
from collections import defaultdict,Counter
CONTEXTS=['ammunation','247','burger_shot','cluckin_bell','pizza_stack','barber','tattoo','clothing','gym','police']
CANONICAL={'AMMUN1','FDBURG','FDCHICK','FDPIZA','BARBERS','TATTOO','CSCHP','GYM1','POLICE1'}

def main():
 p=argparse.ArgumentParser();p.add_argument('--source-audit',required=True);p.add_argument('--resolver',required=True);p.add_argument('--output-json',required=True);a=p.parse_args()
 src=json.load(open(a.source_audit,encoding='utf-8')); rr=json.load(open(a.resolver,encoding='utf-8'))
 base={x['record_hash']:x for x in src['interior_queue']}; rows=rr['rows']; ints={}
 for r in rows:
  if r['resolved_context_type'] in CONTEXTS and r['point_a_space'].startswith('interior:') and r['point_b_space'].startswith('interior:'):ints[(r['resolved_context_type'],r['pair_group_key'])]=r
 seen={};out=[]
 for r in rows:
  c=r['resolved_context_type']
  if c not in CONTEXTS or r['point_a_space']!='world:0' or r['point_b_space']!='world:0':continue
  i=ints.get((c,r['pair_group_key']));
  if not i:continue
  b=base[r['record_hash']];ib=base[i['record_hash']];key=(c,r['pair_group_key'],round(b['entry_x'],3),round(b['entry_y'],3),round(b['entry_z'],3),round(b['exit_x'],3),round(b['exit_y'],3),round(b['exit_z'],3));dup=seen.get(key,'');seen.setdefault(key,r['record_hash'])
  readiness='blocked_duplicate' if dup else ('dry_run_ready' if r['pair_group_key'] in CANONICAL else 'service_point_pending')
  out.append({'plan_key':hashlib.sha256((r['record_hash']+'|'+i['record_hash']+'|v0.26A.1.7').encode()).hexdigest(),'context_type':c,'pair_group_key':r['pair_group_key'],'exterior_record_hash':r['record_hash'],'interior_record_hash':i['record_hash'],'interior_id':ib['interior_id'],'apply_readiness':readiness,'duplicate_of_hash':dup})
 doc={'planner_version':'saif_enex_pair_planner_v0.26A.1.7','source_session_key':rr['source_session_key'],'plan_count':len(out),'status_counts':dict(Counter(x['apply_readiness'] for x in out)),'plans':out}
 json.dump(doc,open(a.output_json,'w',encoding='utf-8'),indent=2,ensure_ascii=False)
if __name__=='__main__':main()
