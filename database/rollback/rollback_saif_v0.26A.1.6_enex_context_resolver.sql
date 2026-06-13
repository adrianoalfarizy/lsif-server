-- SAIF v0.26A.1.6 context metadata rollback preview
-- SAFETY: transaction intentionally ends in ROLLBACK.
-- Review @offline_session_id and row counts before changing final ROLLBACK to COMMIT.
SET NAMES utf8mb4;
START TRANSACTION;

SET @offline_session_id := (SELECT id FROM offline_import_sessions ORDER BY id DESC LIMIT 1);

SELECT @offline_session_id AS rollback_session_id;
SELECT COUNT(*) AS evidence_rows_to_delete
FROM offline_interior_context_evidence
WHERE session_id=@offline_session_id
  AND resolver_version='saif-enex-context-resolver-v0.26A.1.6';

DELETE FROM offline_interior_context_evidence
WHERE session_id=@offline_session_id
  AND resolver_version='saif-enex-context-resolver-v0.26A.1.6';

UPDATE offline_interior_queue
SET resolved_display_name='',
    resolved_category='',
    resolved_context_type='',
    access_scope='review_required',
    service_type='',
    recommended_runtime_target='review_required',
    resolver_status='pending',
    resolver_confidence=0,
    resolver_version='',
    resolver_reason='',
    scm_reference_count=0,
    scm_shop_binding_count=0,
    pair_group_key='',
    pair_group_size=0,
    pair_status='unresolved',
    duplicate_group_size=1,
    point_a_space='',
    point_b_space='',
    resolved_at=NULL
WHERE session_id=@offline_session_id
  AND resolver_version='saif-enex-context-resolver-v0.26A.1.6';

UPDATE offline_import_sessions
SET status='parsed'
WHERE id=@offline_session_id AND status='context_resolved';

SELECT ROW_COUNT() AS queue_rows_reset;
ROLLBACK;
