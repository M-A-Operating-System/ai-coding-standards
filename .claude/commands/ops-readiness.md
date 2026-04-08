---
description: Check pre-deployment readiness before releasing to production — ops checklist, monitoring, rollback plan, and documentation finalization.
---

Act as the **DevOps Engineer** persona. Load `ai-coding-standards/ai-instructions/skills/ops_readiness.md`.

The release or deployment being reviewed: $ARGUMENTS

Verify readiness across:
- CI pipeline passing (all tests green)
- Secrets and config externalized (no hardcoded values)
- Infrastructure IaC reviewed and applied
- Database migrations reviewed and rolled back safely
- Monitoring and alerting configured
- Rollback procedure documented and tested
- Product documentation finalized
- Release notes drafted
- Issue closure criteria met

Output a readiness summary: ✅ READY or ❌ NOT READY with a list of blocking items.
