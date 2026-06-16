# ColAndreas dependency gate

Required runtime layout:

```text
plugins/ColAndreas_static.so
scriptfiles/ColAndreas/ColAndreas.cadb
```

Required `config.json` fragment, preserving other existing entries:

```json
"legacy_plugins": [
    "mysql_static",
    "ColAndreas_static"
]
```

Required Windows development include:

```text
D:\LSIF-DEV\qawno\include\colandreas.inc
```

Run the included preflight from the repository root:

```bash
bash tools/verify/verify_colandreas_v0.26A.1.31.6.sh /opt/lsif-repo
```

Expected:

```text
COLANDREAS_DEPENDENCY_GATE=1
```
