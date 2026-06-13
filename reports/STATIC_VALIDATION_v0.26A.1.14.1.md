# Static Validation

- Planner `apply_status` references in joined query qualified as `p.apply_status`.
- Planner `decision_code`, `runtime_modelid`, `requires_model_resolution`, and `requires_state_bridge` qualified as `p.*`.
- SQL contains only SET/SELECT statements.
- No runtime mutation statements.
