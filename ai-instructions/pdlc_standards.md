
# AI Product Development Lifecycle (AI PDLC) Standards
Version: 2.0.0
Applies to: All Product Changes (Enhancements, Bug Fixes, New Features, Backfill Adoption)

## Principle: Design First

> **The product documentation IS the product.**  
> Code is the implementation of the design — not the other way around.  
> No implementation work begins until the design is documented, complete, and signed off.

All aspects of the product design must be **specifiable** (written down without ambiguity) and **testable** (verifiable through acceptance criteria or automated tests). If you cannot write a failing test for a design requirement, the requirement is not ready.

> **Every change to the product — regardless of type — must be initiated from a tracked ticket.**  
> This includes changes to product design, documentation, technical architecture, and code.  
> There are no exceptions. A conversation, a verbal agreement, or an AI session alone is not sufficient authorisation to change the product.

---

## 1. Work Item Tracking (Mandatory)

**Every unit of work — without exception — must be tracked as an issue** before any AI agent or developer begins work.

This applies to **all** of the following change types:

| Change Type | Examples | Ticket Required |
|-------------|----------|-----------------|
| Product design | User stories, acceptance criteria, feature scope | ✅ |
| Product documentation | Confluence pages, wikis, README, API docs | ✅ |
| Technical architecture | ADRs, system diagrams, data models, API contracts | ✅ |
| Code | Features, bug fixes, refactors, dependency updates | ✅ |
| Infrastructure | IaC changes, CI/CD pipelines, environment config | ✅ |

If a request does not have a ticket, ask for one before proceeding with **any** work — including drafting documentation or design artefacts.

### Supported Trackers
Use whichever tracker your project has standardised on: **GitHub Issues**, **Jira**, or **Azure Boards**.

> **AI gate**: Before any implementation, run the Design First Gate in `master_standards.md §6`. All five checks must pass.

### Tag Systems

Three tag systems are applied as GitHub labels, Jira labels, or Azure Boards tags.

---

#### Stage:Step:Status Tags

Track every work item step. Format: `stage:step-name:status`

| Segment | Allowed values |
|---------|----------------|
| `stage` | `backfill` · `discover` · `design` · `sign-off` · `implement` · `verify` · `release` |
| `step-name` | Single-word step name from the phase table (e.g. `problem`, `criteria`, `deploy`) |
| `status` | `active` · `review` · `blocked` · `passed` · `failed` · `skipped` |

| Status | Meaning | Permanent? |
|--------|---------|------------|
| `active` | Currently being worked | No |
| `review` | Work done; awaiting human approval | No |
| `blocked` | Cannot advance; reason in ticket comment | No |
| `passed` | Human-approved ✅ | **Yes** |
| `failed` | Rejected; rework required | No |
| `skipped` | Not applicable; reason recorded | **Yes** |

> **Rule**: Only a human may move a step from `review` to `passed`. The AI may not self-approve.

**Lifecycle rules:**
1. Enter step → add `stage:step:active`; remove previous `:active`
2. Work done → replace `:active` with `:review`; notify reviewer
3. Passed → reviewer replaces `:review` with `:passed` (human only)
4. Failed → reviewer replaces `:review` with `:failed`; rework then revert to `:active`
5. `passed` and `skipped` are permanent — they form the audit trail
6. Blocked → replace active status with `:blocked`; record reason; revert when resolved

**AI gate check** — before starting any step, verify:
1. Previous step carries `:passed` or `:skipped`
2. When entering a new phase: the previous phase's final step is `:passed` or `:skipped`
3. `:review` is **not** sufficient to advance

If any check fails: stop, report the missing tag, redirect to the correct step.

| Phase gate (must be `:passed`) | Unlocks |
|--------------------------------|---------|
| `backfill:close` | Discover |
| `discover:confirm` | Design |
| `design:canonical` | Sign-off |
| `sign-off:approved` | Implement |
| `implement:approved` | Verify |
| `verify:approved` | Release |

---

#### Relationship Tags

Express dependencies between tickets. Format: `relationship:ticket-id`. Managed by `issue-planner` agent.

| Tag | Meaning |
|-----|---------|
| `blocks:TICKET-ID` | This ticket must resolve before the referenced ticket can proceed |
| `blockedby:TICKET-ID` | This ticket cannot proceed until the referenced ticket resolves |
| `relatedto:TICKET-ID` | Overlapping scope; coordination recommended but non-blocking |

**Rules:** `blocks:B` on A requires `blockedby:A` on B (reciprocal, enforced by `issue-planner`). Removed only when the blocking ticket reaches `release:close:passed`. A ticket with `blockedby:X` sets its active step to `:blocked` until X clears.

---

#### Impact Tags

Declare which architecture components a ticket touches. Applied at `discover:impact`. Managed by `impact-assessment` agent. At least one required before a ticket exits DISCOVER.

Format: `impacts:component`

| Tag | Component | Agents triggered | Required artefacts |
|-----|-----------|------------------|--------------------|
| `impacts:ui` | User-facing screens and flows | `ui-design` | Wireframes, annotated user flows |
| `impacts:frontend` | Client-side code | `developer` | Component spec, accessibility checklist |
| `impacts:api` | REST / GraphQL / event API contracts | `developer`, `api-review` | OpenAPI diff, versioning decision |
| `impacts:backend` | Server-side logic, services, workers | `developer` | Sequence diagrams, service boundaries |
| `impacts:database` | Relational or document schemas | `developer`, `data-review` | Schema diff, migration plan, rollback plan |
| `impacts:data-model` | Domain / entity model | `developer`, `data-review` | ERD or domain model diagram |
| `impacts:auth` | Authentication, authorisation, sessions | `security-review` | Auth flow diagram, role/permission matrix |
| `impacts:security` | Security controls, secrets, certificates | `security-review` | Threat model delta, OWASP checklist |
| `impacts:infra` | Cloud resources, networking, compute | `cloud-engineer` | IaC diff, cost estimate |
| `impacts:pipeline` | CI/CD, build scripts, deployment | `devops-engineer` | Pipeline diagram, rollback procedure |
| `impacts:config` | Env vars, feature flags, secrets | `devops-engineer` | Config change table, environment matrix |
| `impacts:integrations` | Third-party services, webhooks | `developer` | Integration contract, error/retry strategy |
| `impacts:notifications` | Email, push, SMS, outbound events | `developer` | Notification spec, opt-out requirements |
| `impacts:monitoring` | Dashboards, alerts, log schema, SLOs | `devops-engineer` | Alert runbook, SLO delta |
| `impacts:docs` | User-facing docs, help, changelogs | `technical-writer` | Docs change scope, affected pages |

Every triggered agent must contribute their required artefact before SIGN-OFF. New impact discovered after DISCOVER → add tag immediately and trigger agent before continuing.

---

## 2. The AI PDLC — Phases and Steps

Every work item progresses through the standard phases in order. **No phase may be skipped.**

> **Active tag for any step**: `<stage>:<step>:active` — e.g. entering the `criteria` step in DESIGN → `design:criteria:active`. See [`pdlc_tags.md`](pdlc_tags.md) for full lifecycle rules.

```
DISCOVER → DESIGN → SIGN-OFF → IMPLEMENT → VERIFY → RELEASE
```

For existing projects adopting this framework for the first time, run **BACKFILL** once before entering the standard flow (see Phase 0 below).

---

### Phase 0 — BACKFILL *(existing projects only, run once)*
**Owner**: Product Manager persona + Developer persona  
**Output**: Existing product behaviour fully documented; all deviations triaged as tickets; team aligned on the approved baseline  
**Done when**: Every area of the codebase has a corresponding product documentation page with sign-off; all known deviations are logged as Bug or Enhancement tickets  
**Trigger**: New project adopting the AI PDLC framework for the first time, or a project resuming after a period without documentation governance

> **Gate check (AI)**: No prior phase gate required. BACKFILL is the entry point for existing project adoption.

| Step | Action | Owner | Agent |
|------|--------|-------|-------|
| `ticket` | Create a BACKFILL ticket in the tracker to govern the adoption work itself | PM | `product-manager` |
| `inventory` | Inventory the codebase: list all modules, APIs, data models, and user-facing surfaces | Developer | `developer` |
| `assessment` | For each surface, assess whether product documentation already exists | PM + Dev | `product-manager` |
| `document` | Write documentation for all existing approved behaviour (document what it *does*, not what it *should* do) | PM | `product-manager` |
| `validate` | Verify all documented requirements are specifiable and testable | PM | `product-manager` |
| `gaps` | Identify gaps: behaviour that exists but cannot be specified or justified | Developer | `developer` |
| `triage` | Triage each gap: is it acceptable current behaviour (document it) or a defect (log a Bug ticket)? | PM + Tech Lead | `product-manager` |
| `missing` | Identify missing capabilities that are needed but not yet built — log each as an Enhancement ticket | PM | `product-manager` |
| `submit` | Submit all backfilled documentation for sign-off (same approval process as Phase 3 — SIGN-OFF) | Approver | — |
| `signoff` | Record sign-off in the BACKFILL ticket; mark the baseline as "Design Approved" | Approver | — |
| `close` | Close the BACKFILL ticket; all future work proceeds through the standard PDLC flow | PM | `product-manager` |

> **Note**: No new features or behaviour changes may be introduced during BACKFILL. If a gap requires new work, log it as an Enhancement and address it through the standard PDLC after the baseline is signed off.

---

### Phase 1 — DISCOVER
**Owner**: Product Manager persona  
**Output**: Draft issue in tracker with problem statement, user goal, initial scope, and work item classification  
**Done when**: Issue created; work item type confirmed; stakeholders have agreed the problem is worth solving

> **Gate check (AI)**: No prior phase gate required for new work items. If this project ran BACKFILL, verify `backfill:close:passed` is on the backfill ticket before starting new work items.

| Step | Action | Owner | Agent |
|------|--------|-------|-------|
| `ticket` | Create a ticket in the tracker (GitHub Issues / Jira / Azure Boards) | PM | `product-manager` |
| `problem` | Write the problem statement: what is broken or missing, and for whom | PM | `product-manager` |
| `goal` | Define the user goal: what outcome the user needs | PM | `product-manager` |
| `scope` | Set initial scope: what is in and out of bounds | PM | `product-manager` |
| `classify` | Classify the work item type: Enhancement, Bug, Spike, or Chore | PM | `product-manager` |
| `impact` | Identify affected areas; apply `impacts:` tags | PM + Dev | `impact-assessment` |
| `clarify` | Resolve ambiguity and fill requirement gaps before advancing | PM | `product-manager` |
| `confirm` | Get stakeholder confirmation that the problem is worth solving; record in ticket | PM | `product-manager` |

---

### Phase 2 — DESIGN
**Owner**: Product Manager persona (with Developer for technical design)  
**Output**: Product documentation page updated; API contracts, data model, and UX flows written and complete  
**Done when**: All steps below are complete and recorded in the ticket

> **Gate check (AI)**: Verify `discover:confirm:passed` is present on this ticket. If not, stop and redirect to Phase 1 — DISCOVER.

| Step | Action | Owner | Agent |
|------|--------|-------|-------|
| `document` | Create or update the product documentation page (Confluence, Notion, GitHub Wiki, etc.) and link it in the ticket | PM | `product-manager` |
| `stories` | Write user stories in "As a / I want / So that" format | PM | `product-manager` |
| `criteria` | Write acceptance criteria in Given/When/Then (Gherkin) format — minimum 2 happy path, 2 negative | PM | `product-manager` |
| `validate` | Verify every requirement is specifiable (unambiguous) and testable (a failing test can be derived) | PM | `product-manager` |
| `api` | Update API contract (OpenAPI / GraphQL schema / Proto) — if applicable | Developer | `developer` |
| `datamodel` | Update data model (ERD or schema diff) — if applicable | Developer | `developer` |
| `nonfunctional` | Define non-functional requirements: performance SLOs, security constraints, reliability targets | PM + Dev | `product-manager` |
| `adr` | Write an Architecture Decision Record (ADR) for any significant design decision | Developer | `developer` |
| `risk` | Complete risk assessment | PM | `product-manager` |
| `canonical` | Produce canonical requirements JSON if machine-readable format is required | PM | `product-manager` |

---

### Phase 3 — SIGN-OFF
**Owner**: Designated approver (product owner, tech lead, or architect)  
**Output**: Ticket status updated to **"Design Approved"**; approval recorded with approver name and date  
**Done when**: All steps below are complete

> **Gate check (AI)**: Verify `design:canonical:passed` is present on this ticket. If not, stop and redirect to Phase 2 — DESIGN.

| Step | Action | Owner | Agent |
|------|--------|-------|-------|
| `checklist` | Confirm all Phase 2 steps are complete; no outstanding gaps | PM | `product-manager` |
| `submit` | Submit design documentation for approver review | PM | `product-manager` |
| `review` | Approver validates: requirements are specifiable, testable, and complete | Approver | — |
| `record` | Approver records sign-off (name, date) in the ticket | Approver | — |
| `approved` | Ticket status updated to "Design Approved" | PM | `product-manager` |

> **Gate**: No implementation code, schema migrations, or infrastructure changes may be generated until `sign-off:approved:passed` is present on this ticket.  
> In an AI session without a tracker: the user must explicitly state *"Design approved"* before the AI proceeds.

---

### Phase 4 — IMPLEMENT
**Owner**: Developer persona  
**Output**: Code, tests, and infrastructure changes that satisfy all acceptance criteria  
**Done when**: All acceptance criteria pass; code review approved; branch ready for merge

> **Gate check (AI)**: Verify `sign-off:approved:passed` is present on this ticket. If not, stop and redirect to Phase 3 — SIGN-OFF.

| Step | Action | Owner | Agent |
|------|--------|-------|-------|
| `gate` | Confirm ticket reference and "Design Approved" status before writing any code | Developer | `developer` |
| `branch` | Create a feature branch linked to the ticket | Developer | `developer` |
| `standards` | Load the language-specific standards for the target language | Developer | `developer` |
| `code` | Implement code and infrastructure changes against the acceptance criteria | Developer | `developer` |
| `tests` | Write or update automated tests; all acceptance criteria must have test coverage | Developer | `developer` |
| `review` | Self-review against the project coding standards and security checklist | Developer | `developer` |
| `alignment` | Verify implementation matches the documented design exactly; surface any deviation immediately | Developer | `developer` |
| `pullrequest` | Open a pull/merge request linked to the ticket; include acceptance criteria references | Developer | `developer` |
| `approved` | Peer code review approved | Reviewer | — |

---

### Phase 5 — VERIFY
**Owner**: Quality Engineer persona  
**Output**: Full test plan executed; security and ops readiness confirmed  
**Done when**: All acceptance criteria tests pass; no blocking security findings; ops readiness confirmed

> **Gate check (AI)**: Verify `implement:approved:passed` is present on this ticket. If not, stop and redirect to Phase 4 — IMPLEMENT.

| Step | Action | Owner | Agent |
|------|--------|-------|-------|
| `testcases` | Generate test cases from the acceptance criteria | QE | `quality-engineer` |
| `execute` | Execute all test cases; record results against each acceptance criterion | QE | `quality-engineer` |
| `security` | Run security review for any change touching auth, data handling, or external integrations | QE | `quality-engineer` |
| `ops` | Run ops readiness check | QE | `quality-engineer` |
| `confirm` | Confirm all acceptance criteria pass; record results in ticket | QE | `quality-engineer` |
| `approved` | Obtain QE sign-off; update ticket status to "Verified" | QE | — |

---

### Phase 6 — RELEASE
**Owner**: DevOps Engineer persona  
**Output**: Deployment completed; product documentation finalised; issue closed  
**Done when**: Deployment confirmed healthy; release notes published; issue closed

> **Gate check (AI)**: Verify `verify:approved:passed` is present on this ticket. If not, stop and redirect to Phase 5 — VERIFY.

| Step | Action | Owner | Agent |
|------|--------|-------|-------|
| `merge` | Merge feature branch to main; confirm CI pipeline passes | DevOps | `devops-engineer` |
| `deploy` | Deploy to production using approved IaC / pipeline | DevOps | `devops-engineer` |
| `health` | Verify deployment health: smoke tests, error rates, key metrics | DevOps | `devops-engineer` |
| `monitoring` | Confirm monitoring and alerting are active for the changed surfaces | DevOps | `devops-engineer` |
| `document` | Finalise product documentation: mark any draft pages as approved | PM | `product-manager` |
| `notes` | Publish release notes linked to the ticket | PM | `product-manager` |
| `close` | Close the ticket; all phase gates recorded | PM | `product-manager` |

---

## 3. Work Item Types

```
What kind of work is this?
├── Changes what the product does or is supposed to do → Enhancement → full PDLC (Phases 1–6)
├── Code is broken relative to the approved design → Bug → fix implementation (skip Phase 2 design update)
├── Time-boxed investigation, no production code → Spike → Phase 1 only
└── Dependency / lint / CI / formatting, no behavior change → Chore → no PDLC phases (issue still required)
```

### Enhancement
> An intentional addition to or change of the product's specified behavior.
- Must update product documentation **before** implementation.
- Must go through all 6 PDLC phases.
- Implementation that diverges from the documented design is an undocumented change (forbidden).

### Bug
> A deviation of the implementation from the approved product design.
- The design is the source of truth — bugs are in the code, never in the design.
- Bug fixes **must not** alter the product documentation.
- If investigation reveals the design was wrong, reclassify as an Enhancement and complete Phases 1–3 before any code is written.

### Spike
> A time-boxed investigation to reduce uncertainty.
- Issue required ✅. Requires a time-box and a defined question to answer.
- PDLC phases required: DISCOVER only (Phase 1).
- Output: a written summary (ADR draft, findings note) — not merged code.
- If spike code is intended for production, promote to an Enhancement and run the full PDLC from Phase 2.

### Chore
> Maintenance work that does not change product behavior.
- Issue required ✅.
- No PDLC phases required.
- Must not change any public API surface, data schema, or documented behavior. If it does, reclassify as an Enhancement.

---

## 4. Specifiable and Testable Requirements

Every requirement written in the product documentation must pass both tests:

### Specifiable
A requirement is specifiable if and only if:
- It is written in precise, unambiguous language
- Two independent developers reading it would produce equivalent implementations
- It defines the expected inputs, outputs, and state changes explicitly
- It does not use vague terms like "fast", "user-friendly", "secure", "appropriate" without measurable thresholds

| ❌ Not Specifiable | ✅ Specifiable |
|---|---|
| "The system should be fast" | "The API P99 response time must be ≤ 200ms under 100 concurrent users" |
| "Error messages should be helpful" | "Error responses return HTTP 400 with a JSON body containing `code` and `message` fields" |
| "Users must be authenticated" | "All endpoints except `/health` and `/auth/login` require a valid JWT in the `Authorization: Bearer` header" |

### Testable
A requirement is testable if and only if:
- A failing automated test or manual verification step can be written from it **before** any implementation exists
- There is a clear pass/fail criterion
- It is expressed in Gherkin (Given/When/Then) or an equivalent structured format

If a requirement cannot be expressed as a Gherkin scenario, it is not ready for implementation.

---
