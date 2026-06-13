#!/usr/bin/env python3
"""SAIF GTA SA SCM car generator parser v0.26A.1.11.

Pure Python (no pip dependency). It reads:
  <source-root>/01_DECOMPILED/main_decompiled.txt
  <source-root>/00_RAW/data/vehicles.ide
and writes a JSON audit. The repository package already includes generated SQL.
"""
from __future__ import annotations
import argparse, hashlib, json, re
from collections import Counter, defaultdict
from pathlib import Path

ASSIGN_RE = re.compile(r'^\s*(\$[A-Za-z0-9_\[\]]+)\s*=\s*(-?\d+(?:\.\d+)?(?:e[+-]?\d+)?)\s*$', re.I)
CREATE_RE = re.compile(
 r'^\s*(?P<gen>\$[A-Za-z0-9_\[\]]+)\s*=\s*create_car_generator(?P<plate>_with_plate)?\s+'
 r'(?P<x>\S+)\s+\{y\}\s+(?P<y>\S+)\s+\{z\}\s+(?P<z>\S+)\s+\{heading\}\s+(?P<h>\S+)\s+'
 r'\{modelId\}\s+(?P<model>\S+)\s+\{primaryColor\}\s+(?P<c1>\S+)\s+\{secondaryColor\}\s+(?P<c2>\S+)\s+'
 r'\{forceSpawn\}\s+(?P<force>\S+)\s+\{alarmChance\}\s+(?P<alarm>\S+)\s+\{doorLockChance\}\s+(?P<lock>\S+)\s+'
 r'\{minDelay\}\s+(?P<mind>\S+)\s+\{maxDelay\}\s+(?P<maxd>\S+)(?:\s+\{plateName\}\s+"(?P<platename>[^"]*)")?\s*$', re.I)
SWITCH_RE = re.compile(r'^\s*switch_car_generator\s+(\$[A-Za-z0-9_\[\]]+)\s+\{amount\}\s+(-?\d+)', re.I)
OWNED_RE = re.compile(r'^\s*set_has_been_owned_for_car_generator\s+(\$[A-Za-z0-9_\[\]]+)\s+\{state\}\s+(True|False)', re.I)

def models_from_ide(path: Path) -> dict[int, dict[str, str]]:
    result, active = {}, False
    for raw in path.read_text(errors='ignore').splitlines():
        line = raw.strip()
        if not line or line.startswith('#'): continue
        if line.lower() in {'cars','boats','planes','trains','bikes'}: active = True; continue
        if line.lower() == 'end': active = False; continue
        if not active: continue
        parts = [p.strip() for p in line.split(',')]
        try: model_id = int(parts[0])
        except (ValueError, IndexError): continue
        if 400 <= model_id <= 611 and len(parts) >= 6:
            result[model_id] = {'model_name': parts[1], 'vehicle_type': parts[3], 'game_name': parts[5]}
    return result

def parse(source_root: Path) -> dict:
    main = source_root/'01_DECOMPILED/main_decompiled.txt'
    ide = source_root/'00_RAW/data/vehicles.ide'
    if not main.is_file() or not ide.is_file():
        raise FileNotFoundError('main_decompiled.txt or vehicles.ide not found under source root')
    lines = main.read_text(errors='ignore').splitlines()
    models = models_from_ide(ide)
    switches, owned = defaultdict(list), defaultdict(list)
    for line_no, line in enumerate(lines, 1):
        m = SWITCH_RE.match(line)
        if m: switches[m.group(1)].append((line_no, int(m.group(2))))
        m = OWNED_RE.match(line)
        if m: owned[m.group(1)].append((line_no, m.group(2).lower() == 'true'))
    variables, records = {}, []
    for line_no, line in enumerate(lines, 1):
        m = ASSIGN_RE.match(line)
        if m: variables[m.group(1)] = float(m.group(2))
        m = CREATE_RE.match(line)
        if not m: continue
        data = m.groupdict()
        def resolve(token: str):
            if token in variables: return variables[token], 'variable'
            try: return float(token), 'literal'
            except ValueError: return None, 'unresolved'
        values, modes = {}, {}
        for key in ('x','y','z','h','model','c1','c2','alarm','lock','mind','maxd'):
            values[key], modes[key] = resolve(data[key])
        first_switch = next((amount for ln, amount in switches[data['gen']] if ln > line_no), None)
        first_owned = next((state for ln, state in owned[data['gen']] if ln > line_no), False)
        model_id = int(values['model']) if values['model'] is not None else -999
        zero = all(values[k] is not None and abs(values[k]) < 1e-7 for k in ('x','y','z'))
        status = 'placeholder_zero' if zero else ('random_model_reference' if model_id == -1 else ('resolved' if 400 <= model_id <= 611 else 'invalid_model'))
        model = models.get(model_id, {})
        records.append({
            'source_line': line_no,
            'record_hash': hashlib.sha256((str(line_no)+'|'+line).encode()).hexdigest(),
            'generator_name': data['gen'],
            'source_command': 'SCM_CARGEN_PLATE' if data['plate'] else 'SCM_CARGEN',
            'modelid': model_id,
            'vehicle_model_name': model.get('model_name', 'RANDOM' if model_id == -1 else ''),
            'vehicle_type': model.get('vehicle_type', ''),
            'pos_x': values['x'], 'pos_y': values['y'], 'pos_z': values['z'], 'pos_a': values['h'],
            'color1': values['c1'], 'color2': values['c2'],
            'force_spawn': data['force'].lower() == 'true',
            'alarm_chance': values['alarm'], 'door_lock_chance': values['lock'],
            'min_delay_ms': values['mind'], 'max_delay_ms': values['maxd'],
            'plate_name': data.get('platename') or '',
            'initial_switch_amount': first_switch,
            'has_been_owned': first_owned,
            'resolution_mode': 'variable_resolved' if any(modes[k] == 'variable' for k in ('x','y','z','h')) else 'literal',
            'candidate_status': status,
            'raw_record': line,
        })
    summary = {
        'total': len(records),
        'resolved': sum(r['candidate_status'] == 'resolved' for r in records),
        'random_model_reference': sum(r['candidate_status'] == 'random_model_reference' for r in records),
        'placeholder_zero': sum(r['candidate_status'] == 'placeholder_zero' for r in records),
        'variable_resolved': sum(r['resolution_mode'] == 'variable_resolved' for r in records),
        'initial_switch': dict(Counter(str(r['initial_switch_amount']) for r in records)),
    }
    return {'parser_version': 'saif-vehicle-parser-v0.26A.1.11', 'summary': summary, 'records': records}

def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument('--source-root', required=True, type=Path)
    ap.add_argument('--output-json', required=True, type=Path)
    args = ap.parse_args()
    result = parse(args.source_root)
    args.output_json.parent.mkdir(parents=True, exist_ok=True)
    args.output_json.write_text(json.dumps(result, indent=2))
    print(json.dumps(result['summary'], indent=2))
    return 0
if __name__ == '__main__':
    raise SystemExit(main())
