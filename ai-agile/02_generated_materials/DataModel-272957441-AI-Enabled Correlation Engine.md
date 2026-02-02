# AI-Enabled Correlation Engine

Following the establishment of a base product and framework for the Correlation Engine, we can evaluate when and how Artificial Intelligence should be introduced into the process. The objective is to enhance decision accuracy, reduce operational noise, and increase automation while preserving safety, auditability, and governance.

AI can be introduced in multiple ways, including: (1) leveraging AI to write and automatically iterate correlation rules, and (2) using AI as an alternative to deterministic correlation rules. The following sections outline prerequisites, guardrails, workflows, and rollout strategies for both approaches.

## Prerequisites and Safety Principles
- Stable DQI payload schema, normalized EWI status/priority mappings, and a functioning rules framework (DEFAULT “one-in-one-out” baseline).
- Comprehensive audit trail across DQI receipt, rule evaluation, action execution, and EME updates, ingested into the Analytics Warehouse.
- Strict data sensitivity separation (DQI vs BRI), data minimization, and role-based access; prefer operating with INTERNAL classification for early phases.
- Human-in-the-loop approval gates, deterministic fallbacks, and champion–challenger controls for safe experimentation.

## Approach #1 — AI-Assisted Rule Authoring and Iteration
AI is used to discover patterns in historical DQI and EWI outcomes, propose candidate correlation rules, simulate their impact, and iteratively tune thresholds. The CE remains the authoritative execution engine; AI assists authoring and calibration.

### Capabilities
- Pattern mining on $DQI events (e.g., frequency spikes, co-occurrence across systems/fields) and lineage-aware features from $PDL to surface candidate routing, aggregation, suppression, and prioritization rules.
- Automatic rule drafting in the CE’s Correlation Rule Language (human-readable), including CREATE/UPDATE/SUPPRESS/AGGREGATE/LINK actions, and versioned Specification/Description.
- Offline simulation and A/B comparison against historical streams; outcome metrics include precision/recall of escalation, suppression accuracy, workload reduction, and resolution lead time.
- Automatic threshold tuning and overlap detection to reduce duplicate or conflicting rules; proposals require steward approval and can be rolled out in staged modes.

### Workflow
1. Discover patterns → draft candidate rule(s) with specs.
2. Simulate on historical streams and produce metrics + diffs vs baseline.
3. Human steward review and approval → staged rollout (shadow, limited scope).
4. Monitor outcomes, audit trail, and drift; auto-propose refinements as needed.

## Approach #2 — AI as an Alternative to Deterministic Rules
A supervised model predicts recommended actions (e.g., assignment group, priority, aggregation/suppression) directly from $DQI, lineage context ($PDL), recent work item state ($EWI), and business calendars. Deterministic rules provide a fallback when confidence or explainability thresholds are not met.

### Modeling Options
- Tree-based classifiers/regressors for tabular features (counts, time windows, severity, normalized statuses).
- Graph-aware models leveraging lineage graphs to learn downstream impact and root-cause linkages.
- LLM reasoning wrappers (guardrailed) to map structured inputs to CE actions in human-readable form, subject to strict validation.

### Operational Controls
- Champion–Challenger with shadow mode; AI recommends actions, CE executes deterministic path unless confidence ≥ threshold.
- Feature store with versioned inputs; model registry with versioning and rollback.
- Explainability artifacts (feature attributions, rule-equivalent hints), and complete per-decision audit (model version, features, recommendation, executed action).
- Drift detection, periodic offline re-training, and data minimization to avoid introduction of sensitive BRI unless explicitly gated.

## Evaluation and Rollout Plan
- Phase 0: Baseline deterministic CE with DEFAULT rule and audit pipeline.
- Phase 1: AI-assisted authoring (draft + simulation + approval), no direct execution.
- Phase 2: Automatic threshold iteration for selected categories (e.g., threshold-based alerting), with steward gating.
- Phase 3: Limited direct AI recommendations for high-confidence scenarios with champion–challenger controls.
- Phase 4: Broader coverage with explainability, continuous monitoring, and strong fallbacks.

## Governance and Compliance
- Formal approvals, reproducibility of experiments, versioned documentation, and immediate rollback paths.
- Bias and fairness monitoring on assignment/prioritization outcomes; periodic policy reviews.
- Strict segregation of sensitive BRI, with opt-in gating and minimized feature sets where applicable.

## Integration Touchpoints
- DQE ingress: near-real-time event stream + job signals for PASS inference.
- Inventory/Lineage: enrichment lookups (owners, CDEs, downstream impact) with caching.
- EME bi-directional: normalized status/priority maps, assignment resolution, and ticket linkage for aggregation/dependency.
- Analytics Warehouse: audit and performance metrics for AI evaluation.
- Model Registry/Feature Store: lifecycle management and reproducibility.
