#!/usr/bin/env python
"""requirements2pdf

Create a single, formatted PDF from per-document canonical requirements JSON files.

- Reads locations from ai-agile/ai-agile.json (process.steps.* by name).
- Defaults:
  - Input dir: <ai-agile-root>/<GeneratedMaterials.folder>/canonical-requirements
  - Output:   <ai-agile-root>/<GeneratedMaterials.folder>/canonical-requirements.pdf
  - --include-references: false

This script intentionally treats SourceMaterial as read-only evidence.
"""

from __future__ import annotations

import argparse
import json
import os
from dataclasses import dataclass
from datetime import datetime
from pathlib import Path
from typing import Any


@dataclass(frozen=True)
class StepFolders:
    ai_agile_root: Path
    source_material: Path
    generated_materials: Path


def _load_json(path: Path) -> dict[str, Any]:
    with path.open("r", encoding="utf-8") as f:
        return json.load(f)


def resolve_folders(repo_root: Path) -> StepFolders:
    ai_agile_json = repo_root / "ai-agile" / "ai-agile.json"
    if not ai_agile_json.exists():
        raise FileNotFoundError(f"Missing config file: {ai_agile_json}")

    cfg = _load_json(ai_agile_json)

    # Prefer basePaths.aiAgileRoot when present, otherwise derive from repoRoot.
    base_paths = cfg.get("basePaths", {})
    ai_agile_root_raw = base_paths.get("aiAgileRoot")
    ai_agile_root = Path(ai_agile_root_raw) if ai_agile_root_raw else (repo_root / "ai-agile")

    process = cfg.get("process", {})
    steps = process.get("steps", {})

    def step_folder(step_name: str) -> Path:
        step = steps.get(step_name)
        if not isinstance(step, dict) or "folder" not in step:
            raise KeyError(f"Could not resolve process.steps.{step_name}.folder from {ai_agile_json}")
        return ai_agile_root / str(step["folder"])

    return StepFolders(
        ai_agile_root=ai_agile_root,
        source_material=step_folder("SourceMaterial"),
        generated_materials=step_folder("GeneratedMaterials"),
    )


def iter_requirement_files(input_dir: Path, glob_pattern: str) -> list[Path]:
    if not input_dir.exists():
        raise FileNotFoundError(f"Input directory not found: {input_dir}")
    files = sorted(p for p in input_dir.glob(glob_pattern) if p.is_file())
    if not files:
        raise FileNotFoundError(f"No files matched {glob_pattern!r} in {input_dir}")
    return files


def _safe_get(dct: dict[str, Any], path: list[str], default: Any = None) -> Any:
    cur: Any = dct
    for key in path:
        if not isinstance(cur, dict):
            return default
        cur = cur.get(key)
    return cur if cur is not None else default


def _as_list(value: Any) -> list[Any]:
    return value if isinstance(value, list) else []


def _escape_for_paragraph(text: str) -> str:
    # ReportLab Paragraph uses a minimal XML-ish markup.
    # Escape &, <, > to avoid rendering errors.
    return (
        text.replace("&", "&amp;")
        .replace("<", "&lt;")
        .replace(">", "&gt;")
    )


def _doc_title_from_json(doc: dict[str, Any], fallback: str) -> str:
    title = _safe_get(doc, ["sourceDocument", "title"], None)
    if isinstance(title, str) and title.strip():
        return title.strip()

    # Try to use relativePath basename.
    rel = _safe_get(doc, ["sourceDocument", "relativePath"], None)
    if isinstance(rel, str) and rel.strip():
        return Path(rel).name

    return fallback


def _format_source_metadata(doc: dict[str, Any]) -> str:
    parts: list[str] = []
    source_type = _safe_get(doc, ["sourceDocument", "sourceType"], None)
    if isinstance(source_type, str) and source_type:
        parts.append(f"Source type: {source_type}")

    rel = _safe_get(doc, ["sourceDocument", "relativePath"], None)
    if isinstance(rel, str) and rel:
        parts.append(f"Source: {rel}")

    conf = _safe_get(doc, ["sourceDocument", "confluence"], None)
    if isinstance(conf, dict):
        page_id = conf.get("pageId")
        space = conf.get("space")
        version = conf.get("version")
        url = conf.get("url")
        if page_id:
            parts.append(f"Confluence pageId: {page_id}")
        if space:
            parts.append(f"Confluence space: {space}")
        if version is not None:
            parts.append(f"Confluence version: {version}")
        if url:
            parts.append(f"Confluence URL: {url}")

    retrieved = _safe_get(doc, ["sourceDocument", "retrievedAt"], None)
    if isinstance(retrieved, str) and retrieved:
        parts.append(f"Retrieved at: {retrieved}")

    return "\n".join(parts)


def _group_requirements(requirements: list[dict[str, Any]]) -> dict[str, list[dict[str, Any]]]:
    groups: dict[str, list[dict[str, Any]]] = {
        "Business": [],
        "Functional": [],
        "Architecture": [],
        "NonFunctional": [],
        "Other": [],
    }

    for req in requirements:
        primary = _safe_get(req, ["classification", "primary"], "Other")
        if primary not in groups:
            primary = "Other"
        groups[primary].append(req)

    # Drop empty groups (except keep order stable in rendering)
    return groups


def _default_brd_sections_path() -> Path:
    return Path(__file__).resolve().parent / "brd_sections.json"


def _load_brd_sections(path: Path) -> dict[str, Any]:
    data = _load_json(path)
    if not isinstance(data, dict):
        raise ValueError(f"Invalid brd_sections.json (expected object): {path}")
    sections = data.get("sections")
    if not isinstance(sections, list) or not sections:
        raise ValueError(f"Invalid brd_sections.json (missing sections[]): {path}")
    return data


def _coerce_brd_section_id(
    section_id: Any,
    *,
    valid_ids: set[str],
    unassigned_id: str,
) -> str:
    if isinstance(section_id, str) and section_id in valid_ids:
        return section_id
    return unassigned_id


def _escape_join(lines: list[str]) -> str:
    return _escape_for_paragraph("\n".join(lines)).replace("\n", "<br/>")


def _format_story_summary(story: Any) -> str:
    if not isinstance(story, dict):
        return "—"
    as_a = story.get("asA")
    i_want = story.get("iWant")
    so_that = story.get("soThat")
    lines: list[str] = []
    if isinstance(as_a, str) and as_a.strip():
        lines.append(f"As a: {as_a.strip()}")
    if isinstance(i_want, str) and i_want.strip():
        lines.append(f"I want: {i_want.strip()}")
    if isinstance(so_that, str) and so_that.strip():
        lines.append(f"So that: {so_that.strip()}")
    return "\n".join(lines) if lines else "—"


def _format_bdd_summary(bdd: Any) -> str:
    if not isinstance(bdd, dict):
        return "—"
    feature = bdd.get("feature")
    scenario = bdd.get("scenario")
    steps = bdd.get("steps")

    lines: list[str] = []
    if isinstance(feature, str) and feature.strip():
        lines.append(f"Feature: {feature.strip()}")
    if isinstance(scenario, str) and scenario.strip():
        lines.append(f"Scenario: {scenario.strip()}")

    if isinstance(steps, list) and steps:
        step_lines: list[str] = []
        for step in steps:
            if not isinstance(step, dict):
                continue
            kw = step.get("keyword")
            txt = step.get("text")
            if isinstance(kw, str) and kw.strip() and isinstance(txt, str) and txt.strip():
                step_lines.append(f"{kw.strip()} {txt.strip()}")
        if step_lines:
            lines.append("Steps:")
            lines.extend(step_lines)

    return "\n".join(lines) if lines else "—"


def build_pdf(
    requirement_files: list[Path],
    output_pdf: Path,
    include_references: bool,
    include_open_questions: bool,
    title: str,
    brd_sections_path: Path | None,
) -> None:
    try:
        from reportlab.lib.pagesizes import LETTER
        from reportlab.lib import colors
        from reportlab.lib.styles import ParagraphStyle, getSampleStyleSheet
        from reportlab.lib.units import inch
        from reportlab.platypus import (
            PageBreak,
            Paragraph,
            SimpleDocTemplate,
            Spacer,
            Table,
            TableStyle,
        )
    except ModuleNotFoundError as e:
        raise SystemExit(
            "Missing dependency 'reportlab'. Install it with: pip install reportlab"
        ) from e

    output_pdf.parent.mkdir(parents=True, exist_ok=True)

    doc = SimpleDocTemplate(
        str(output_pdf),
        pagesize=LETTER,
        leftMargin=0.8 * inch,
        rightMargin=0.8 * inch,
        topMargin=0.8 * inch,
        bottomMargin=0.8 * inch,
        title=title,
        author="requirements2pdf",
    )

    styles = getSampleStyleSheet()
    h1 = styles["Heading1"]
    h2 = styles["Heading2"]
    h3 = styles["Heading3"]
    body = styles["BodyText"]

    small = ParagraphStyle(
        name="Small",
        parent=body,
        fontSize=9,
        leading=11,
        spaceBefore=4,
        spaceAfter=6,
    )

    req_header = ParagraphStyle(
        name="ReqHeader",
        parent=h3,
        spaceBefore=10,
        spaceAfter=4,
    )

    story_style = ParagraphStyle(
        name="Story",
        parent=small,
        leftIndent=14,
        spaceBefore=2,
        spaceAfter=6,
    )

    story_kw = ParagraphStyle(
        name="StoryKW",
        parent=small,
        leftIndent=28,
        spaceBefore=1,
        spaceAfter=2,
    )

    mini_label = ParagraphStyle(
        name="MiniLabel",
        parent=small,
        fontSize=8,
        leading=10,
        spaceBefore=0,
        spaceAfter=0,
    )

    mini_value = ParagraphStyle(
        name="MiniValue",
        parent=small,
        fontSize=8,
        leading=10,
        spaceBefore=0,
        spaceAfter=0,
    )

    elements: list[Any] = []

    # Title page
    elements.append(Paragraph(_escape_for_paragraph(title), h1))
    elements.append(Spacer(1, 0.2 * inch))
    elements.append(
        Paragraph(
            _escape_for_paragraph(
                f"Generated: {datetime.now().isoformat(timespec='seconds')}"
            ),
            small,
        )
    )
    elements.append(Spacer(1, 0.2 * inch))
    elements.append(
        Paragraph(
            _escape_for_paragraph(
                "This PDF is generated from canonical requirements JSON files. "
                "Statements are rendered as the primary source-of-truth summary for downstream analysis."
            ),
            small,
        )
    )
    elements.append(PageBreak())

    brd_cfg_path = brd_sections_path if brd_sections_path else _default_brd_sections_path()
    brd_cfg = _load_brd_sections(brd_cfg_path)
    sections_raw = brd_cfg.get("sections")
    sections: list[dict[str, Any]] = [s for s in sections_raw if isinstance(s, dict)] if isinstance(sections_raw, list) else []
    valid_section_ids = {str(s.get("id")) for s in sections if isinstance(s.get("id"), str)}
    unassigned_id = _safe_get(brd_cfg, ["assignmentPolicy", "unassignedSectionId"], "BRD-99")
    if not isinstance(unassigned_id, str) or unassigned_id not in valid_section_ids:
        unassigned_id = "BRD-99" if "BRD-99" in valid_section_ids else (next(iter(valid_section_ids)) if valid_section_ids else "BRD-99")

    # Build index: sectionId -> documentKey(relativePath) -> {title, meta, requirements[]}
    section_index: dict[str, dict[str, dict[str, Any]]] = {sid: {} for sid in valid_section_ids}
    open_questions_by_doc: list[tuple[str, str, list[str]]] = []

    for path in requirement_files:
        data = _load_json(path)
        doc_title = _doc_title_from_json(data, fallback=path.name)
        doc_rel = _safe_get(data, ["sourceDocument", "relativePath"], None)
        doc_key = str(doc_rel).strip() if isinstance(doc_rel, str) and doc_rel.strip() else path.name
        doc_meta = _format_source_metadata(data)

        if include_open_questions:
            oq = data.get("openQuestions")
            if isinstance(oq, list):
                qs = [q.strip() for q in oq if isinstance(q, str) and q.strip()]
                if qs:
                    open_questions_by_doc.append((doc_key, doc_title, qs))

        reqs_raw = _as_list(data.get("requirements"))
        reqs: list[dict[str, Any]] = [r for r in reqs_raw if isinstance(r, dict)]
        for req in reqs:
            sid = _coerce_brd_section_id(
                req.get("brdSectionId"),
                valid_ids=valid_section_ids,
                unassigned_id=unassigned_id,
            )

            bucket = section_index.setdefault(sid, {})
            doc_bucket = bucket.setdefault(
                doc_key,
                {
                    "title": doc_title,
                    "meta": doc_meta,
                    "relativePath": doc_key,
                    "requirements": [],
                },
            )
            doc_bucket["requirements"].append(req)

    def _section_render_hints(section: dict[str, Any]) -> tuple[bool, bool]:
        hints = section.get("renderingHints")
        include_refs = True
        include_quotes = True
        if isinstance(hints, dict):
            if hints.get("includeReferences") is False:
                include_refs = False
            if hints.get("includeQuotes") is False:
                include_quotes = False
        return include_refs, include_quotes

    def _render_story_bdd_minitable(req: dict[str, Any]) -> Table:
        story_text = _format_story_summary(req.get("story"))
        bdd_text = _format_bdd_summary(req.get("bdd"))

        table_data = [
            [
                Paragraph(_escape_for_paragraph("Story"), mini_label),
                Paragraph(_escape_join(story_text.splitlines()) if story_text != "—" else _escape_for_paragraph("—"), mini_value),
            ],
            [
                Paragraph(_escape_for_paragraph("BDD"), mini_label),
                Paragraph(_escape_join(bdd_text.splitlines()) if bdd_text != "—" else _escape_for_paragraph("—"), mini_value),
            ],
        ]

        tbl = Table(
            table_data,
            colWidths=[0.8 * inch, None],
        )
        tbl.setStyle(
            TableStyle(
                [
                    ("VALIGN", (0, 0), (-1, -1), "TOP"),
                    ("GRID", (0, 0), (-1, -1), 0.25, colors.lightgrey),
                    ("BACKGROUND", (0, 0), (0, -1), colors.whitesmoke),
                    ("LEFTPADDING", (0, 0), (-1, -1), 4),
                    ("RIGHTPADDING", (0, 0), (-1, -1), 4),
                    ("TOPPADDING", (0, 0), (-1, -1), 2),
                    ("BOTTOMPADDING", (0, 0), (-1, -1), 2),
                ]
            )
        )
        return tbl

    # Render sections in the order defined by brd_sections.json
    for section in sections:
        sid = section.get("id")
        if not isinstance(sid, str) or sid not in valid_section_ids:
            continue

        sec_number = section.get("number")
        sec_title = section.get("title")
        sec_heading = f"{sec_number}. {sec_title}" if sec_number and sec_title else (sec_title or sid)
        elements.append(Paragraph(_escape_for_paragraph(str(sec_heading)), h1))

        purpose = section.get("purpose")
        if isinstance(purpose, str) and purpose.strip():
            elements.append(Paragraph(_escape_for_paragraph(purpose.strip()), small))
            elements.append(Spacer(1, 0.08 * inch))

        include_refs_allowed, include_quotes_allowed = _section_render_hints(section)
        render_refs = bool(include_references) and include_refs_allowed

        docs_in_section = section_index.get(sid, {})
        if not docs_in_section:
            elements.append(Paragraph(_escape_for_paragraph("(No items)"), small))
            elements.append(PageBreak())
            continue

        for doc_key in sorted(docs_in_section.keys()):
            doc_bucket = docs_in_section[doc_key]
            doc_title = doc_bucket.get("title") or doc_key
            elements.append(Paragraph(_escape_for_paragraph(str(doc_title)), h2))
            elements.append(Spacer(1, 0.06 * inch))

            meta = doc_bucket.get("meta")
            if isinstance(meta, str) and meta.strip():
                elements.append(Paragraph(_escape_for_paragraph(meta).replace("\n", "<br/>"), small))
                elements.append(Spacer(1, 0.10 * inch))

            reqs = doc_bucket.get("requirements")
            req_list: list[dict[str, Any]] = [r for r in reqs if isinstance(r, dict)] if isinstance(reqs, list) else []
            req_list.sort(key=lambda r: str(r.get("id") or ""))

            for req in req_list:
                req_id = req.get("id", "")
                kind = req.get("kind", "")
                title_text = req.get("title")

                header_bits = [str(req_id).strip(), f"[{kind}]" if kind else ""]
                header = " ".join(b for b in header_bits if b)
                if isinstance(title_text, str) and title_text.strip():
                    header = f"{header} — {title_text.strip()}"
                if header.strip():
                    elements.append(Paragraph(_escape_for_paragraph(header), req_header))

                statement = req.get("statement")
                if isinstance(statement, str) and statement.strip():
                    elements.append(Paragraph(_escape_for_paragraph(statement.strip()), body))
                else:
                    # Fall back to story/bdd if statement missing
                    story = req.get("story")
                    bdd = req.get("bdd")
                    if isinstance(story, dict):
                        as_a = story.get("asA")
                        i_want = story.get("iWant")
                        so_that = story.get("soThat")
                        parts = []
                        if as_a and i_want:
                            parts.append(f"As {as_a}, I want {i_want}.")
                        if so_that:
                            parts.append(f"So that {so_that}.")
                        if parts:
                            elements.append(Paragraph(_escape_for_paragraph(" ".join(parts)), body))
                    if isinstance(bdd, dict):
                        feature = bdd.get("feature")
                        scenario = bdd.get("scenario")
                        if feature:
                            elements.append(Paragraph(_escape_for_paragraph(f"Feature: {feature}"), small))
                        if scenario:
                            elements.append(Paragraph(_escape_for_paragraph(f"Scenario: {scenario}"), small))

                # Mini table summary (smaller font) after each requirement.
                elements.append(Spacer(1, 0.04 * inch))
                elements.append(_render_story_bdd_minitable(req))
                elements.append(Spacer(1, 0.08 * inch))

                if render_refs:
                    refs = req.get("references")
                    if isinstance(refs, list) and refs:
                        elements.append(Paragraph(_escape_for_paragraph("References:"), small))
                        for ref in refs:
                            if not isinstance(ref, dict):
                                continue
                            rel = ref.get("relativePath")
                            locator = ref.get("locator")
                            quote = ref.get("quote")
                            note = ref.get("note")

                            loc_bits: list[str] = []
                            if isinstance(locator, dict):
                                if locator.get("confluenceLocalId"):
                                    loc_bits.append(f"local-id={locator.get('confluenceLocalId')}")
                                if locator.get("headingPath"):
                                    hp = locator.get("headingPath")
                                    if isinstance(hp, list):
                                        loc_bits.append("headingPath=" + " > ".join(str(x) for x in hp if x))
                                if locator.get("table"):
                                    tbl = locator.get("table")
                                    if isinstance(tbl, dict):
                                        tdesc = []
                                        if tbl.get("header"):
                                            tdesc.append(f"header={tbl.get('header')}")
                                        if tbl.get("row"):
                                            tdesc.append(f"row={tbl.get('row')}")
                                        if tbl.get("column"):
                                            tdesc.append(f"col={tbl.get('column')}")
                                        if tdesc:
                                            loc_bits.append("table(" + ", ".join(tdesc) + ")")
                                if locator.get("xpath"):
                                    loc_bits.append(f"xpath={locator.get('xpath')}")
                                if locator.get("textFingerprint"):
                                    loc_bits.append(f"fp={locator.get('textFingerprint')}")

                            ref_line = " - ".join(
                                b for b in [str(rel) if rel else "", "; ".join(loc_bits) if loc_bits else ""] if b
                            )
                            if ref_line:
                                elements.append(Paragraph(_escape_for_paragraph(ref_line), small))

                            if include_quotes_allowed and isinstance(quote, str) and quote.strip():
                                elements.append(Paragraph(_escape_for_paragraph("Quote: " + quote.strip()), small))
                            if isinstance(note, str) and note.strip():
                                elements.append(Paragraph(_escape_for_paragraph("Note: " + note.strip()), small))

                elements.append(Spacer(1, 0.08 * inch))

        elements.append(PageBreak())

    if include_open_questions and open_questions_by_doc:
        elements.append(Paragraph(_escape_for_paragraph("Open questions (by source document)"), h1))
        elements.append(Spacer(1, 0.1 * inch))
        for _, doc_title, qs in sorted(open_questions_by_doc, key=lambda x: x[0]):
            elements.append(Paragraph(_escape_for_paragraph(str(doc_title)), h2))
            for q in qs:
                elements.append(Paragraph(_escape_for_paragraph("• " + q), body))
            elements.append(Spacer(1, 0.12 * inch))

    doc.build(elements)


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Generate a single PDF from canonical requirements JSON files.",
    )

    parser.add_argument(
        "--repo-root",
        default=str(Path(__file__).resolve().parents[2]),
        help="Repository root (default: inferred from this script location)",
    )

    parser.add_argument(
        "--input-dir",
        default=None,
        help=(
            "Directory containing canonical requirements JSON files. "
            "Default: <ai-agile-root>/<GeneratedMaterials.folder>/canonical-requirements"
        ),
    )

    parser.add_argument(
        "--glob",
        default="*.requirements.json",
        help="Glob pattern to match input files (default: *.requirements.json)",
    )

    parser.add_argument(
        "--output",
        default=None,
        help=(
            "Output PDF path. Default: <ai-agile-root>/<GeneratedMaterials.folder>/canonical-requirements.pdf"
        ),
    )

    parser.add_argument(
        "--title",
        default="Canonical Requirements",
        help="PDF title (default: Canonical Requirements)",
    )

    parser.add_argument(
        "--include-references",
        action="store_true",
        default=False,
        help="Include references/quotes/locators in the PDF (default: false)",
    )

    parser.add_argument(
        "--include-open-questions",
        action="store_true",
        default=False,
        help="Include openQuestions sections (default: false)",
    )

    parser.add_argument(
        "--brd-sections",
        default=None,
        help=(
            "Path to brd_sections.json (default: dev-instructions/scripts/brd_sections.json next to this script)"
        ),
    )

    return parser.parse_args()


def main() -> None:
    args = parse_args()
    repo_root = Path(args.repo_root).resolve()

    folders = resolve_folders(repo_root)

    input_dir = (
        Path(args.input_dir).resolve()
        if args.input_dir
        else (folders.generated_materials / "canonical-requirements")
    )

    output_pdf = (
        Path(args.output).resolve()
        if args.output
        else (folders.generated_materials / "canonical-requirements.pdf")
    )

    files = iter_requirement_files(input_dir, args.glob)

    build_pdf(
        requirement_files=files,
        output_pdf=output_pdf,
        include_references=bool(args.include_references),
        include_open_questions=bool(args.include_open_questions),
        title=str(args.title),
        brd_sections_path=(Path(args.brd_sections).resolve() if args.brd_sections else None),
    )

    print(f"Wrote PDF: {output_pdf}")


if __name__ == "__main__":
    main()
