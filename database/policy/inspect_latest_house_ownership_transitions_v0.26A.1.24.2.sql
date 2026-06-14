-- Read-only ownership transition audit for latest house_catalog archive.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
SET @archive_session_id := (SELECT id FROM offline_runtime_archive_sessions WHERE archive_scope='house_catalog' ORDER BY id DESC LIMIT 1);
SELECT t.id transition_id,t.archive_session_id,t.player_house_id,t.owner_id,COALESCE(p.username,'UNKNOWN') username,
       t.old_house_catalog_id,t.old_house_index,COALESCE(h.display_name,'MISSING CATALOG') old_house_name,
       t.policy_status,t.target_canonical_slot,t.target_plan_id,t.notes,t.resolved_at
FROM offline_house_ownership_transition_plan t
LEFT JOIN players p ON p.id=t.owner_id
LEFT JOIN house_catalog h ON h.id=t.old_house_catalog_id
WHERE t.archive_session_id=@archive_session_id
ORDER BY FIELD(t.policy_status,'pending_mapping','invalid_source','preserve_legacy','mapped','refund_then_release'),t.id;
