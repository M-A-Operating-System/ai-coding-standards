# PDLC Tag Reference — MERGED

This file has been merged into `pdlc_standards.md §1 — Tag Systems`.

See [`pdlc_standards.md`](pdlc_standards.md) for all tag definitions, lifecycle rules, and the impact registry.

This file defines the three tag systems used to track work item state, dependencies, and architecture component impacts. Tags are applied as GitHub labels, Jira labels, or Azure Boards tags.

---

## 1. Stage:Step:Status Tags

Every work item step is tracked using a **`stage:step-name:status`** triple.

### Format

```
stage:step-name:status
```

| Segment | Allowed Values |
|---------|----------------|
| `stage` | `backfill` · `discover` · `design` · `sign-off` · `implement` · `verify` · `release` |
| `step-name` | Single-word step name from the phase table (e.g. `problem`, `criteria`, `deploy`) |
| `status` | See Official Status List below |

### Official Status List

| Status | Meaning | Enters when | Permanent? |
|--------|---------|-------------|------------|
| `active` | Step is currently being worked | Work begins | No |
| `review` | Work done; awaiting human approval | AI/dev submits for sign-off | No |
| `blocked` | Cannot advance; reason in ticket comment | Dependency unresolved | No |
| `passed` | Human-approved ✅ | Reviewer approves | **Yes — never removed** |
| `failed` | Rejected; rework required | Reviewer rejects | No |
| `skipped` | Not applicable; reason recorded | Step irrelevant for this work type | **Yes — never removed** |

> **Rule**: Only a human may move a step from `review` to `passed`. The AI may not self-approve.

### Lifecycle Rules

1. **Enter step**: Add `stage:step:active`. Remove the previous step's `:active` tag.
2. **Submit for review**: Replace `:active` with `:review`. Notify the reviewer.
3. **Review passed**: Reviewer replaces `:review` with `:passed`. Human only.
4. **Review failed**: Reviewer replaces `:review` with `:failed`. Rework → revert to `:active`.
5. **`passed` and `skipped` are permanent** — they form the immutable audit trail.
6. **Blocked**: Replace active status with `:blocked`. Record reason in ticket. Unblock → revert.

### AI Gate Check Rule

Before starting any step, verify:
1. The **previous step** carries `:passed` or `:skipped`.
2. When **entering a new phase**: the final step of the previous phase carries `:passed` or `:skipped`.
3. A step in `:review` is **not** sufficient to advance — it must reach `:passed` first.

If any check fails, **stop**, report the missing tag, and redirect to the appropriate step.

**Phase gate signals** (must be `:passed` to unlock the next phase):

| Current phase gate | Unlocks |
|--------------------|---------|
| `backfill:close:passed` | Discover |
| `discover:confirm:passed` | Design |
| `design:canonical:passed` | Sign-off |
| `sign-off:approved:passed` | Implement |
| `implement:approved:passed` | Verify |
| `verify:approved:passed` | Release |

---

## 2. Relationship Tags

Relationship tags express dependencies and associations **between tickets**. Managed by the `issue-planner` agent.

### Format

```
relationship:ticket-id
```

| Tag | Meaning | Example |
|-----|---------|---------|
| `blocks:TICKET-ID` | This ticket must be resolved before the referenced ticket can proceed | `blocks:PROJ-42` |
| `blockedby:TICKET-ID` | This ticket cannot proceed until the referenced ticket is resolved | `blockedby:PROJ-38` |
| `relatedto:TICKET-ID` | Overlapping scope; coordination recommended | `relatedto:PROJ-55` |

### Rules

1. **Reciprocal**: `A blocks:B` requires `B blockedby:A`. Enforced by `issue-planner`.
2. **Permanent while relevant**: Removed only when the blocking ticket reaches `release:close:passed`.
3. **`blockedby` triggers `blocked` status**: Any active step on a blocked ticket must be set to `:blocked` until the referenced ticket clears.
4. **`relatedto` is non-blocking**: Surfaces for coordination; does not prevent advancement.
5. **Multiple relationships allowed**: Each is a separate label.

See `.claude/agents/issue-planner.md` for agent responsibilities.

---

## 3. Impact Tags

Impact tags declare which architecture components a ticket will change. Applied at `discover:impact`. Managed by the `impact-assessment` agent.

### Format

```
impacts:component
```

### Impact Tag Registry

| Tag | Component | Agents triggered | Required artefacts |
|-----|-----------|------------------|--------------------|
| `impacts:ui` | User-facing screens, flows, interactive components | `ui-design` | Wireframes, mockups, annotated user flows |
| `impacts:frontend` | Client-side code (React, Angular, Vue, etc.) | `developer` | Component spec, accessibility checklist |
| `impacts:api` | REST, GraphQL, or event-driven API contracts | `developer`, `api-review` | OpenAPI / schema diff, versioning decision |
| `impacts:backend` | Server-side business logic, services, workers | `developer` | Sequence diagrams, service boundaries |
| `impacts:database` | Relational or document database schemas | `developer`, `data-review` | Schema diff, migration plan, rollback plan |
| `impacts:data-model` | Domain / entity model (shared across layers) | `developer`, `data-review` | ERD or domain model diagram |
| `impacts:auth` | Authentication, authorisation, session management | `security-review` | Auth flow diagram, role/permission matrix |
| `impacts:security` | Security controls, secrets, certificates, access policies | `security-review` | Threat model delta, OWASP checklist |
| `impacts:infra` | Cloud resources, networking, DNS, storage, compute | `cloud-engineer` | IaC diff (Bicep/Terraform), cost estimate |
| `impacts:pipeline` | CI/CD workflows, build scripts, deployment automation | `devops-engineer` | Pipeline diagram, rollback procedure |
| `impacts:config` | Environment variables, feature flags, secrets, app config | `devops-engineer` | Config change table, environment matrix |
| `impacts:integrations` | Third-party services, webhooks, external APIs | `developer` | Integration contract, error/retry strategy |
| `impacts:notifications` | Email, push, SMS, webhook outbound events | `developer` | Notification spec, opt-out requirements |
| `impacts:monitoring` | Dashboards, alerts, log schema, SLOs | `devops-engineer` | Alert runbook, SLO delta |
| `impacts:docs` | User-facing documentation, help content, changelogs | `technical-writer` | Docs change scope, affected pages list |

### Rules

1. **Applied at `discover:impact`**: At least one `impacts:` tag required before a ticket exits DISCOVER.
2. **Multiple tags allowed**: Each is a separate label.
3. **Agent participation is mandatory**: Every triggered agent must contribute their required artefact before SIGN-OFF.
4. **`impact-assessment` is source of truth**: Performs initial tagging. Humans may add tags; may not remove without agent confirmation.
5. **Tags are additive**: New impact discovered after DISCOVER → add tag immediately, trigger agent before continuing.

See `.claude/agents/impact-assessment.md` for agent responsibilities.
