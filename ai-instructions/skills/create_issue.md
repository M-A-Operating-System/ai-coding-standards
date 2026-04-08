---
**Skill Name**: Create Issue  
**Version**: 1.0 (2026-04-03)  
**Persona(s)**: Product Manager, Developer, DevOps Engineer, Cloud Engineer  
**Description**:  
Create a well-formed work item in the project's issue tracker (GitHub Issues, Jira, or Azure Boards) with all mandatory fields populated and the correct initial PDLC tags applied.

**Usage Example**:
```prompt
Act as the Product Manager persona.
Use create_issue to open a new Enhancement ticket for:
  Title: [title]
  Problem: [problem statement]
  Goal: [user goal]
  Work item type: Enhancement | Bug | Spike | Chore
```

**Mandatory Fields** (all must be set before the issue is considered open):

| Field | Enhancement | Bug | Spike | Chore |
|-------|------------|-----|-------|-------|
| Title (imperative, ≤72 chars) | ✅ | ✅ | ✅ | ✅ |
| Work item type label | ✅ | ✅ | ✅ | ✅ |
| Problem statement | ✅ | ✅ | ✅ | — |
| Linked product documentation page | ✅ | ✅ | — | — |
| Initial PDLC tag | `discover:ticket:active` | `discover:ticket:active` | `discover:ticket:active` | `discover:ticket:active` |
| Time-box (hours or days) | — | — | ✅ | — |
| Question to answer | — | — | ✅ | — |

**Title format**: Use an imperative verb phrase — "Add X", "Fix Y", "Investigate Z", "Update W". Never use passive voice or present tense ("Adding…", "X is broken").

**Body template**:
```markdown
## Problem
[What is broken or missing, and for whom]

## Goal
[What outcome the user or system needs]

## Scope
[What is in and out of bounds — leave blank if unknown at creation time]

## Linked documentation
[URL or path to product documentation page — required for Enhancement and Bug]

## Work item type
[Enhancement | Bug | Spike | Chore]
```

**Implementation Notes**:
- [ ] Apply the `discover:ticket:active` tag immediately on creation.
- [ ] For Bugs: link to the specific product documentation section that describes the expected behavior.
- [ ] For Spikes: set a hard time-box in the title or description (e.g. "Spike (2d): …").
- [ ] For Chores: confirm the change will not alter any public API, data schema, or documented behavior before opening.
- [ ] Never create an issue for a change that is already in progress without a ticket — create the ticket first, then backdate the context in the body.
- [ ] Related to: `read_issue.md`, `update_issue.md`, `pdlc_standards.md §1`
---
