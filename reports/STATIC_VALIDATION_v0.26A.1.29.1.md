# SAIF / LSIF Dev v0.26A.1.29.1
## House Link Verify Alias Hotfix

- Apply/runtime data mutation: none.
- PWN change: none.
- SQL change: verification query only.
- Root cause: `SUM(enabled=1)` was ambiguous after joining `house_garage_links`, `house_catalog`, and `garage_catalog`.
- Fix: qualify HOUSE_LINK_GATE columns with the `hgl` alias.
- Re-apply required: no.
- Rollback required: no.
