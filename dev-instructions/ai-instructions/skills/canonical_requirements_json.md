---
**Skill Name**: Canonical Requirements JSON (Statement-only + Simple Traceability)
**Version**: 1.2 (2026-02-04)
**Persona(s)**: Product Manager, Developer, Quality Engineer
**Description**:
Create canonical business, functional, architecture, and non-functional statements in a single JSON structure.

This simplified skill is **statement-only**:
- Always capture content as a neutral `statement`.
- Do **not** generate `story` or `bdd` in Phase 1.

Phase 1 output prioritizes **completeness + accuracy + traceability** of the source content.

The output must be *complete and accurate* against each original document and must trace every captured statement back to its source location.

**Usage Example**:
```prompt
Act as an expert Gen-AI engineer.
Use ai-agile/ai-agile.json to locate the SourceMaterial and GeneratedMaterials folders (by step name).
For each file under SourceMaterial:
1) Extract every individual requirement/factual statement into a canonical JSON requirements file.
2) Re-read the document top-to-bottom and ensure completeness and accuracy.
3) Assign REQ0000001-style IDs and add precise source references (file + location).
Do not deduplicate or resolve conflicts in this phase.
```

**Implementation Notes**:
- [ ] Change control (required): if applying this skill would require creating/editing files or running write/execute actions, first propose the exact file changes (full paths under `GeneratedMaterials`) and ask for explicit approval before proceeding. Do not run scripts/commands/snippets without explicit approval.
- [ ] **Configuration (required)**: Resolve all input/output locations from `ai-agile/ai-agile.json` using `process.steps` by name (e.g., `SourceMaterial`, `GeneratedMaterials`). Do not hardcode absolute paths.
- [ ] **Read-only SourceMaterials (hard rule)**: NEVER update, overwrite, rename, move, delete, or otherwise touch any file under the folder configured as `process.steps.SourceMaterial.folder` (including any configured subfolders like `process.steps.SourceMaterial.subfolders.confluence`). Treat SourceMaterials as immutable, read-only evidence.
- [ ] **Source of truth**: references must point to original files under `SourceMaterial` (per config), not to any generated derivatives.
- [ ] Phase 1 scope is **completeness and accuracy only**. Do not call out duplicates, conflicts, or attempt normalization.
- [ ] Every captured statement must have at least one source reference with a precise locator using **document path + character offsets** (see Step 4).
- [ ] Related to: requirements_gathering, acceptance_criteria_gherkin, documentation_quality
---

## Contract (non-negotiables)

### Inputs
- **Single-document mode**: Exactly one source document under `SourceMaterial` (as resolved via `ai-agile/ai-agile.json` by `process.steps` name).
- **Batch mode (DEFAULT)**: One or more source documents under `SourceMaterial`, processed as a set.
  - Default batch scope: **all documents under the folder configured as `process.steps.SourceMaterial.folder`**, scanned recursively.
  - Default include patterns (documents): `**/*.xhtml`, `**/*.md`.
  - Default exclude patterns (operational/config/credentials): `**/.env`, `**/*.config`, `**/confluence.config`.
  - If the user provides include/exclude rules, apply them deterministically and record the final resolved set in the batch manifest.
- Source documents are immutable evidence. Never write to, rename, move, or delete anything under `SourceMaterial`.
- BRD section definitions in `dev-instructions/scripts/brd_sections.json` (read-only). This file is required to assign a mandatory `brdSectionId` to every requirement.

### Outputs
- Exactly one canonical requirements JSON file per source document.
- Outputs MUST be written under `GeneratedMaterials` (as resolved via `ai-agile/ai-agile.json`), never under `SourceMaterial`.
- Optional (recommended for batch): a batch manifest JSON file under the same output folder summarizing inputs/outputs and counts.

### Permissions
- **Write actions** include: creating/editing any file (JSON, MD, etc.).
- **Execute actions** include: running any command, script, snippet, validator, formatter, or interpreter (PowerShell/Python/Node/etc.).
- Before any write or execute action: propose exact file changes and ask for explicit approval.

### Failure modes (stop and ask)
- `ai-agile/ai-agile.json` is missing or cannot be parsed.
- `process.steps.SourceMaterial` or `process.steps.GeneratedMaterials` cannot be resolved by name.
- The selected source file does not exist under the configured `SourceMaterial` folder.
- `dev-instructions/scripts/brd_sections.json` is missing or cannot be parsed.
- You cannot provide a precise locator using **character offsets** (Step 4).

## Process (Phase 1 = completeness + accuracy)

### Step 1 — Batch selection & output manifest (batch mode)
Batch mode is the default unless the user explicitly requests single-document mode.

If running in batch mode:
1. Resolve `SourceMaterial` and `GeneratedMaterials` from `ai-agile/ai-agile.json` by `process.steps` name.
2. Enumerate the input set deterministically.
   - Default: recursively scan all files under `process.steps.SourceMaterial.folder`, then apply the default include/exclude patterns.
   - Sort deterministically by `sourceDocument.relativePath` (lexicographic ascending).
3. Derive deterministic output paths for each input document.
   - Output root (recommended): `GeneratedMaterials/canonical-requirements/`
   - Path mapping rule (collision-safe): mirror the source subfolder structure under `SourceMaterial`.
     - Example input: `confluence/Page.xhtml`
     - Example output: `GeneratedMaterials/canonical-requirements/confluence/Page.requirements.json`
4. Produce an **Output Manifest** (list of every output file path to be created/edited), and ask for approval once for the full batch.
   - Optional file output (recommended): `GeneratedMaterials/canonical-requirements/_manifest.json`

### Step 2 — Permission gate (required)
Before taking any write or execute action:
1. Propose the exact outputs you will create/edit (full relative paths under `GeneratedMaterials`).
2. If running in batch mode, include the Output Manifest and state how many source docs and output files are included.
3. Ask for explicit approval.
4. Do not run scripts/commands/snippets unless explicitly approved.

### Step 3 — Inputs and outputs
- **Input**: One source document file under `SourceMaterial` (as defined in `ai-agile/ai-agile.json`; read-only; never modify it). In batch mode, iterate this step once per selected document, in deterministic file order.
- **Output**: One JSON file (or JSON object) containing the complete inventory of requirements/statements extracted from *that* document.
  - Write outputs only under `GeneratedMaterials` (as defined in `ai-agile/ai-agile.json`) — never under `SourceMaterial`.

### Step 4 — Simple traceability via character offsets (required)
To keep traceability simple and schema-valid, every captured statement MUST include at least one `references[]` entry that points to:
- The source file path (via `references[].relativePath`). Treat the full project-relative source path as `SourceMaterial/<relativePath>`.
- A character offset range in the source file.

**Encoding rule (schema-safe):** the schema does not provide a dedicated `charOffset` field, so store character offsets in `references[].locator.xpath` using this exact format:

`charOffset:v1:start=<0-based integer>;end=<0-based integer>`

Offset rules:
- Offsets are computed against the **raw file text** as read (including whitespace and newlines). Do not normalize.
- `start` is inclusive.
- `end` is exclusive.
- The substring `sourceText[start:end]` MUST equal `references[].quote` exactly.

If you cannot reliably compute offsets (e.g., the content is not available as plain text), stop and ask.

### Step 5 — Load BRD sections (required)
Before extracting requirements:
1. Read and parse `dev-instructions/scripts/brd_sections.json`.
2. Treat it as authoritative for section IDs and section matching policy.
3. If it is missing/unparseable, stop and ask (because `brdSectionId` is mandatory per schema).

#### BRD section assignment policy (deterministic)
For each requirement you create, assign exactly one `brdSectionId` as follows:
- Evaluate `sections[]` in file order.
- Each section contains one or more `match[]` rules. A rule may specify:
  - `any`: at least one condition must match
  - `all`: every condition must match
- Conditions are evaluated against the in-progress requirement object (e.g., `requirement.kind`, `requirement.classification.primary`, `requirement.classification.tags`, `requirement.statement`).
- Use the policy in `assignmentPolicy`:
  - If `firstMatchWins` is true, select the first section whose match evaluates true.
  - If no sections match, use `assignmentPolicy.unassignedSectionId`.

This step ensures the canonical requirements JSON is BRD-ready (each requirement is grouped under the best-fit BRD heading).

### Step 6 — Per-document requirement inventory (no dedupe)
For the selected source document:
1. Read the entire document.
2. Identify **every** atomic statement that constrains design/implementation/testing (requirements, facts, definitions, assumptions, constraints).
3. Create one canonical `Requirement` record per statement (even if redundant).
4. Assign IDs sequentially using `REQ0000001`, `REQ0000002`, … (deterministic ordering; see “ID rules”).
5. Assign `brdSectionId` for each requirement using the BRD section matching rules (Step 5).

#### Source scanning order (recommended)
Scan the source in a deterministic order so results are repeatable:
1. Document header and metadata (e.g., Confluence export metadata).
2. Headings and paragraphs.
3. Lists (bulleted/numbered) item-by-item.
4. Tables, row-by-row, left-to-right.
5. Embedded macros (e.g., `excerpt`, `excerpt-include`, `drawio`, `toc`, `children`) in document order.

#### Statement quality rules (Phase 1)
- Prefer `statement` as the primary representation for Phase 1 completeness.
- Write each `statement` as a self-contained, neutral paragraph that explicitly names the subject and scope (avoid ambiguous pronouns like “this/it/they” unless the referent is explicit).
- Do not invent actors, system behavior, test steps, or acceptance criteria. If the source is ambiguous or incomplete, capture the ambiguity in `openQuestions[]`.
- Do not generate `story` or `bdd` in Phase 1 for this skill.

#### Kind selection heuristics (recommended)
- Select the appropriate `kind` enum value defined in `dev-instructions/scripts/requirement_schema.json` based on what the source text is doing:
  - Normative obligations (“must/shall/required/expected to”)
  - Hard limits or prohibitions (“only”, “never”, scope exclusions)
  - Explicit definitions (“X is …”, “means …”)
  - Stated assumptions (“assumes …”, “we assume …”)
  - Descriptive statements that still constrain design/testing (e.g., “the system includes …”, “the model has N layers …”)

### Step 7 — Completeness pass (top-to-bottom factual capture)
Re-read from top to bottom and confirm:
- Every heading section that contains constraints, assumptions, rules, definitions, data model requirements, integration requirements, audit/logging requirements, security requirements, and roadmap commitments has been captured.
- Every table row that encodes requirements (e.g., “must”, “shall”, “requires”, “needs”, “expected”, “assumes”) is captured.
- Every captured statement is traceable back to the original document with a precise location.

#### Confluence macros, diagrams, and navigation (Phase 1)
- Capture macros/diagrams as `Fact` only when they materially impact interpretation (e.g., the document explicitly includes a TOC, lists related documents, embeds a diagram that is referenced by surrounding text, or includes an excerpt/excerpt-include that contributes substantive content).
- Do not invent semantics of a diagram beyond what the surrounding text/caption explicitly states. If needed, record only that the diagram exists and what it is described as representing.

#### Excerpt / excerpt-include handling (Confluence)
- If the export includes the excerpt body inline (e.g., an `excerpt` macro with content), capture the statements from that inline content as part of this document.
- If the export contains an `excerpt-include` that points to another page and does not include substantive inline content, do **not** pull requirements from the target page into this document’s JSON. Capture only a `Fact` that the include exists (and the target page title/id if present in the link), and let the target page be captured in its own per-document JSON.

### Step 8 — Accuracy validation (against the source)
- Ensure each `Requirement.statement` is faithful to the source meaning.
- Always include a verbatim `references[].quote` for traceability (it must match the offset range exactly).
- Do not infer or invent missing requirements; add an `openQuestions[]` entry instead.

### Step 9 — Output validation (schema + invariants)
Before considering Phase 1 complete:
- Validate the JSON against `dev-instructions/scripts/requirement_schema.json`.
- If tooling execution is not permitted, do a manual schema check focusing on required fields, `additionalProperties: false`, locator requirements (`references[].locator.anyOf`), and the mandatory `brdSectionId`.

#### Batch validation (recommended for batch mode)
After generating all per-document JSON files:
- Batch completeness gate: every selected source document has exactly one output JSON file.
- Batch traceability gate: apply the Traceability gate (Quality gates) across at least 3 documents.
- Batch reporting (optional): generate/update `_manifest.json` with per-document counts (`requirements.length`, `openQuestions.length`) and any noted extraction limitations.

#### Quality gates (manual, test-like)
- Completeness gate:
  - Every substantive heading has at least one captured entry.
  - Every table has been scanned row-by-row.
- Traceability gate:
  - Spot-check at least 5 requirements: each has a `references[].relativePath`, a `locator.xpath` using `charOffset:v1:...`, and a `quote` that matches the referenced substring exactly.

### Definition of done (Phase 1)
- 100% of requirement/factual statements in the source are represented as `requirements[]` entries.
- 100% of `requirements[]` have at least one `references[]` entry.
- All `references[]` point to `SourceMaterial` with a precise locator.
- No files under `SourceMaterial` (as defined in `ai-agile/ai-agile.json`) were created, modified, moved, or deleted.

### Non-goals (explicit)
- Detecting duplicates, resolving conflicts, consolidating requirements across documents.
- Creating a unified cross-document taxonomy.
- Inferring “implied” requirements not present in the source.

## Canonical JSON model

### Determinism and output naming
- Output paths MUST be deterministic. For batch mode, mirror the source file’s subfolder structure under `SourceMaterial` beneath `GeneratedMaterials/canonical-requirements/`, and append `.requirements.json`.
  - Example: `SourceMaterial/confluence/Page.xhtml` → `GeneratedMaterials/canonical-requirements/confluence/Page.requirements.json`
- IDs MUST be assigned deterministically in document order. If new requirements are inserted later due to a completeness pass, renumber deterministically to preserve top-to-bottom ordering.
- Use a consistent, controlled vocabulary for `classification.tags` within a document (prefer short nouns; avoid near-duplicates like `Lineage` vs `DataLineage`).
- `brdSectionId` MUST be set on every requirement using `dev-instructions/scripts/brd_sections.json` (Step 5).

### ID rules
- `Requirement.id` must match `REQ0000001` style: prefix `REQ` + 7 digits.
- IDs must be unique *within the JSON file*.
- Ordering guidance: assign IDs in the order statements appear in the document (top-to-bottom, left-to-right for tables).

### Requirement representation rules
This simplified skill is **statement-only**:
- Every `Requirement` MUST include a `statement`.
- Do not emit `story` or `bdd` in Phase 1.

### Source reference rules (critical)
Every `Requirement.references[]` entry must:
- Reference the original source file under `SourceMaterial` (per `ai-agile/ai-agile.json`)
- Include a precise locator using `locator.xpath` with `charOffset:v1:start=...;end=...`
- Include a `quote` that matches the substring at that exact range

#### Locator determinism rule
- `locator.xpath` MUST use the `charOffset:v1:start=...;end=...` format.
- Offsets MUST be computed against the raw file text as read (including whitespace/newlines).
- `references[].quote` MUST equal the exact substring `sourceText[start:end]`.

## Canonical JSON Schema (human-readable)

The canonical requirements JSON format is formally defined by the JSON Schema in `dev-instructions/scripts/requirement_schema.json`. This section describes the fields at a high level; do not treat the examples of values below as exhaustive or authoritative.

### Top-level
- `schemaVersion` (string): version of this canonical format, e.g. `"1.0"`.
- `sourceDocument` (object): identifies the document being captured.
  - `sourceRoot` (string): location name from `ai-agile/ai-agile.json` (see schema for constraints; Phase 1 uses `"SourceMaterial"`).
  - `relativePath` (string): path relative to the `sourceRoot` folder.
  - `sourceType` (string): see schema for allowed values.
  - `title` (string, optional)
  - `retrievedAt` (string, optional)
  - `confluence` (object, optional): `pageId`, `space`, `version`, `url`.
- `requirements` (array of `Requirement`): the complete inventory.
- `openQuestions` (array of string, optional): questions raised due to ambiguity.

### Requirement
- `id` (string): `REQ0000001` style.
- `kind` (string): requirement classification kind (see schema for allowed values).
- `classification` (object):
  - `primary` (string): primary requirement category (see schema for allowed values).
  - `tags` (array of string, optional)
- `brdSectionId` (string): Mandatory BRD section ID used for deterministic long-form document grouping (e.g., `"BRD-05"`). Must be one of the IDs in `dev-instructions/scripts/brd_sections.json`.
- `title` (string, optional)
- `statement` (string, optional): plain requirement statement.
- `statement` (string, optional): plain requirement statement. (This skill emits statement-only in Phase 1.)
- `rationale` (string, optional)
- `acceptanceCriteria` (array of string, optional)
- `references` (array of `Reference`): must be non-empty.

### Reference
- `sourceRoot` (string): location name from `ai-agile/ai-agile.json` (Phase 1 must be `"SourceMaterial"`).
- `relativePath` (string): path relative to the `sourceRoot` folder.
- `locator` (object): at least one locator field must be present.
  - For this simplified skill, always use `xpath` with `charOffset:v1:start=...;end=...`.
- `quote` (string, optional): verbatim excerpt.
- `note` (string, optional)

## JSON validation schema (Draft 2020-12)

Validate the canonical requirements JSON using the JSON Schema stored at:

- `dev-instructions/scripts/requirement_schema.json`

Treat that schema file as the single source of truth. Do not duplicate hardcoded enums/constraints in this skill document.

## Minimal example (valid)

```json
{
  "schemaVersion": "1.0",
  "sourceDocument": {
    "sourceRoot": "SourceMaterial",
    "relativePath": "confluence/<document>.xhtml",
    "sourceType": "confluence-xhtml"
  },
  "requirements": [
    {
      "id": "REQ0000001",
      "kind": "Requirement",
      "classification": { "primary": "Functional", "tags": ["Routing"] },
      "brdSectionId": "BRD-06",
      "statement": "Data quality issues must be routed to the right team for efficient resolution.",
      "references": [
        {
          "sourceRoot": "SourceMaterial",
          "relativePath": "confluence/<document>.xhtml",
          "locator": { "xpath": "charOffset:v1:start=<start>;end=<end>" },
          "quote": "<verbatim excerpt>"
        }
      ]
    }
  ]
}
```

## Additional examples (recommended patterns)

### Example A — Statement-only (sole-input, no story/BDD)
```json
{
  "id": "REQ0000007",
  "kind": "Requirement",
  "classification": { "primary": "Architecture", "tags": ["Orchestration", "Audit"] },
  "brdSectionId": "BRD-08",
  "statement": "All data governance metadata changes are facilitated through the orchestration capability, which is responsible for conflict resolution, audit trails, and metadata change management, and which performs create/update/delete actions in the metadata repository.",
  "references": [
    {
      "sourceRoot": "SourceMaterial",
      "relativePath": "confluence/<document>.xhtml",
      "locator": { "xpath": "charOffset:v1:start=<start>;end=<end>" },
      "quote": "All data governance metadata changes should be facilitated through the orchestration framework..."
    }
  ]
}
```

### Example B — Table-derived statement with deterministic coordinates
```json
{
  "id": "REQ0000012",
  "kind": "Definition",
  "classification": { "primary": "Architecture", "tags": ["ArchitectureModel", "Layers"] },
  "brdSectionId": "BRD-04",
  "statement": "The architecture model includes Layer 6 (Data Governance Oversight), described as executive accountability and regulatory compliance governance.",
  "references": [
    {
      "sourceRoot": "SourceMaterial",
      "relativePath": "confluence/<document>.xhtml",
      "locator": { "xpath": "charOffset:v1:start=<start>;end=<end>" },
      "quote": "Layer 6 ... Executive accountability and regulatory compliance governance"
    }
  ]
}
```

### Example C — Diagram/macro fact without interpretation
```json
{
  "id": "REQ0000020",
  "kind": "Fact",
  "classification": { "primary": "Architecture", "tags": ["Diagram"] },
  "brdSectionId": "BRD-09",
  "statement": "The document embeds a draw.io diagram in the architecture model section.",
  "references": [
    {
      "sourceRoot": "SourceMaterial",
      "relativePath": "confluence/<document>.xhtml",
      "locator": { "xpath": "charOffset:v1:start=<start>;end=<end>" },
      "quote": "<ac:structured-macro ac:name=\"drawio\" ...>"
    }
  ]
}
```
