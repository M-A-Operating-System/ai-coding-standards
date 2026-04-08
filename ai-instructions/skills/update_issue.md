---
**Skill Name**: Update Issue  
**Version**: 1.0 (2026-04-03)  
**Persona(s)**: All personas  
**Description**:  
Modify an existing work item: advance a PDLC step tag, add or update metadata, record decisions, apply relationship or impact tags, or flag a blocker. All mutations must preserve the immutable audit trail — `passed` and `skipped` tags are never removed.

**Usage Example**:
```prompt
Update issue [ISSUE-ID]:
  - Advance step: design:criteria from :active to :review
  - Add impact tag: impacts:api
  - Record in comment: "acceptance criteria written and submitted for PM review"
```

**Update operations**:

| Operation | Action | Constraint |
|-----------|--------|------------|
| Advance a step to `:review` | Replace `stage:step:active` with `stage:step:review` | Only AI or developer may do this |
| Mark a step `:passed` | Replace `stage:step:review` with `stage:step:passed` | **Human only — AI may not self-approve** |
| Mark a step `:failed` | Replace `stage:step:review` with `stage:step:failed` | Human only; add reason as comment |
| Mark a step `:skipped` | Add `stage:step:skipped`; record reason as comment | Human only; permanent — never remove |
| Mark a step `:blocked` | Replace active status with `stage:step:blocked`; record blocker in comment | Any agent; revert when resolved |
| Enter next step | Add `stage:step:active` for the new step | Previous step must be `:passed` or `:skipped` first |
| Add impact tag | Add `impacts:component` | Must trigger the required agent (see `pdlc_standards.md §1 — Impact Tags`) |
| Add relationship tag | Add `blocks:ID`, `blockedby:ID`, or `relatedto:ID` | `blocks:B` requires adding `blockedby:A` on B simultaneously |
| Update linked documentation | Update body URL | Must be reachable |
| Add comment | Append comment with timestamp | Required for: blocker reason, skipped reason, failed reason, any design decision |
| Reclassify work item type | Change type label and update body | Reclassification from Bug → Enhancement requires gate reset to `design:document:active` |

**Immutable audit trail rules** — these operations are forbidden:
- ❌ Remove a `stage:step:passed` tag
- ❌ Remove a `stage:step:skipped` tag
- ❌ Move a step from `:passed` back to `:active` (open a new ticket for rework instead)
- ❌ Remove an `impacts:` tag without `impact-assessment` agent confirmation
- ❌ Remove a relationship tag while the dependency is still unresolved

**Before any update, verify**:
1. The issue exists and is open (not cancelled).
2. The proposed tag transition is permitted (see lifecycle rules in `pdlc_standards.md §1`).
3. If advancing a phase gate: the final step of the previous phase is `:passed` or `:skipped`.

**Implementation Notes**:
- [ ] Every tag change must be accompanied by a comment stating: who made the change, what was changed, and why.
- [ ] If a `blocks:B` tag is added to this issue, immediately open `update_issue` against B to add `blockedby:[this issue ID]`.
- [ ] If an `impacts:` tag is added after `discover:impact:passed`, add a comment explaining why the impact was identified late and re-trigger the relevant agent.
- [ ] For reclassifications: reset the PDLC phase gate and notify stakeholders before continuing.
- [ ] Related to: `create_issue.md`, `read_issue.md`, `cancel_issue.md`, `pdlc_standards.md §1`
---
