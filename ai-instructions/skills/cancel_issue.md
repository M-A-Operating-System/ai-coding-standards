---
**Skill Name**: Cancel Issue  
**Version**: 1.0 (2026-04-03)  
**Persona(s)**: All personas  
**Description**:  
Close a work item as cancelled. Issues are never deleted — the record is permanently preserved as an audit trail. Cancellation sets the current active step to `:failed`, locks the ticket, unblocks any downstream issues, and records a mandatory reason comment.

**Usage Example**:
```prompt
Cancel issue [ISSUE-ID].
  Reason: requirements scope transferred to ISSUE-456; this spike is no longer needed.
  Authorised by: [PM Name]
```

**Before cancelling — confirm all of the following**:

| Check | Required answer |
|-------|----------------|
| Is the work still needed but scope changed? | If yes → open a new ticket instead; do not cancel |
| Has a human explicitly authorised the cancellation? | Must be yes; AI may not self-cancel |
| Is a cancellation reason recorded? | Must be yes; recorded as a comment on the issue |
| Is there a successor or superseding ticket? | If yes → record `relatedto:NEW-ID` before closing |

**Cancellation procedure** (execute in order):

1. **Stop any active step**: replace `stage:step:active` or `stage:step:review` with `stage:step:failed`. Record reason in a comment.
2. **All previous `:passed` and `:skipped` tags remain unchanged** — do not remove any of them.
3. **Add label `cancelled`** to the issue.
4. **Unblock downstream**: for every `blocks:X` tag on this issue:
   - Update issue X: remove `blockedby:[THIS-ID]` and revert the blocked step from `:blocked` back to `:active`.
   - Add a comment on X: "blockedby:[THIS-ID] resolved — [THIS-ID] was cancelled on [date]; resuming."
5. **Close the issue** with state `closed` / `won't fix` / `cancelled` per your tracker.
6. **If a successor ticket exists**: add `relatedto:SUCCESSOR-ID` to this issue's tags before closing.

**What must NOT change after cancellation**:

| Element | Rule |
|---------|------|
| All `stage:step:passed` tags | Permanent — never remove |
| All `stage:step:skipped` tags | Permanent — never remove |
| All `impacts:` tags | Permanent — audit evidence |
| All `blocks:` / `relatedto:` tags | Permanent on the closed ticket |
| Cancellation comment | Permanent — must not be edited or deleted |

**Reclassification vs cancellation** — prefer reclassification when:
- The underlying need exists but the scope has changed → open a new, correctly typed ticket and add `relatedto:OLD-ID` / `relatedto:NEW-ID` on each.
- Only the work item *type* has changed → use `update_issue` to reclassify, do not cancel.

**Implementation Notes**:
- [ ] AI may not self-authorise a cancellation. The comment must record a human authoriser.
- [ ] If the issue has no `blocks:X` tags, steps 4 is a no-op — still check before closing.
- [ ] If the issue is a Bug linked to a production incident, do not cancel without explicit sign-off from the QA or DevOps persona.
- [ ] Related to: `create_issue.md`, `read_issue.md`, `update_issue.md`, `pdlc_standards.md §1`
---
