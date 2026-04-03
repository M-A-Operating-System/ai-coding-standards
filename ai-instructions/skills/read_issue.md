---
**Skill Name**: Read Issue  
**Version**: 1.0 (2026-04-03)  
**Persona(s)**: All personas  
**Description**:  
Retrieve and parse a work item from the issue tracker, extract the fields needed to continue PDLC work, and surface any missing or invalid metadata that must be resolved before proceeding.

**Usage Example**:
```prompt
Read issue [ISSUE-ID] and return:
1) Current PDLC phase and active step tag
2) Work item type
3) Summary of problem statement and goal
4) Any missing mandatory fields
5) Blocker flags (blockedby tags, failed steps)
```

**Fields to extract and validate**:

| Field | Where to find it | Valid if… |
|-------|-----------------|-----------|
| Work item type | Label / type field | One of: Enhancement, Bug, Spike, Chore |
| Current phase | Most recent `stage:step:active` tag | Matches a known PDLC stage |
| Completed steps | All `stage:step:passed` and `stage:step:skipped` tags | No gaps in sequence |
| Blocked steps | Any `stage:step:blocked` tag | Blocker reason recorded in a comment |
| Relationship tags | `blocks:*`, `blockedby:*`, `relatedto:*` labels | Reciprocal pairs exist (see `pdlc_standards.md §1`) |
| Impact tags | `impacts:*` labels | At least one present if past `discover:impact:passed` |
| Linked documentation | URL in issue body | Reachable and matches work item type requirements |
| Design sign-off | `sign-off:approved:passed` tag | Present before any implement step is active |

**Output format**:
```
## Issue [ISSUE-ID] — [Title]

**Type**: [Enhancement | Bug | Spike | Chore]
**Current step**: [stage:step:active or "none — all steps complete"]
**Phase gate status**: [gate tag that must be passed to unlock next phase, and its status]

### Completed steps
[list of stage:step:passed and stage:step:skipped]

### Active blockers
[list of stage:step:blocked with stated reason, or "none"]

### Relationship tags
[list of blocks:/blockedby:/relatedto: tags, or "none"]

### Impact tags
[list of impacts: tags, or "none — impact step not yet passed"]

### Missing mandatory fields
[list of fields not present that are required for this work item type, or "none"]

### Recommended next action
[single sentence stating exactly what must happen next]
```

**Implementation Notes**:
- [ ] If `design:canonical:passed` is absent and an `implement:*` tag is active, flag a gate violation immediately.
- [ ] If any `blockedby:X` tag is present, check whether X has reached `release:close:passed` — if yes, report it as cleared to unblock.
- [ ] If reciprocal relationship tags are missing (A `blocks:B` but B has no `blockedby:A`), flag the asymmetry.
- [ ] Do not assume a step is complete just because the next step is active — always verify the `:passed` tag exists.
- [ ] Related to: `create_issue.md`, `update_issue.md`, `cancel_issue.md`, `pdlc_standards.md §1`
---
