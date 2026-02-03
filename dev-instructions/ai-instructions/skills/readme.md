# Skills Folder Usage Guide

## Purpose
The `skills` folder is the central repository for reusable, persona-driven GenAI prompt engineering skills. Each skill defines a focused capability, best practice, or reusable prompt pattern that can be referenced by other standards, templates, or personas in this repository.

## How to Use This Folder

1. **Reference Skills**: When writing or updating standards, prompt templates, or persona definitions, reference relevant skills from this folder to ensure consistency and reusability.
2. **Add New Skills**: When a new, reusable prompt engineering technique or best practice is identified, create a new skill file using the template below.
3. **Update Skills**: If a skill evolves, update its file and increment the version or date if applicable. Ensure all references are updated if the skill's name or scope changes.
4. **Naming Convention**: Use clear, descriptive filenames (e.g., `clarifying_questions.md`, `chain_of_thought.md`).
5. **Documentation**: Each skill file must follow the template below for clarity and standardization.

## Skill Definition Template

---
**Skill Name**: _[Concise, descriptive title]_  
**Version**: _[e.g., 1.0, or date: YYYY-MM-DD]_  
**Persona(s)**: _[List of personas this skill applies to, e.g., Developer, PM, QA, etc.]_  
**Description**:  
_A brief summary of what this skill enables or improves in prompt engineering._

**Usage Example**:
```prompt
[Insert a sample prompt or usage scenario that demonstrates the skill.]
```

**Implementation Notes**:
- [ ] _List any special considerations, dependencies, or related skills._
- [ ] _Change control: if applying this skill would require creating/editing files or running write/execute actions, first propose the exact file changes and ask for explicit approval before proceeding._

---

## Example Skill File

---
**Skill Name**: Clarifying Questions  
**Version**: 1.0 (2026-01-27)  
**Persona(s)**: Developer, PM  
**Description**:  
Encourages the AI to ask clarifying questions when requirements are ambiguous, reducing errors and rework.

**Usage Example**:
```prompt
If any part of the user request is unclear or ambiguous, ask a clarifying question before proceeding.
```

**Implementation Notes**:
- [ ] Related to: active listening, requirements gathering
- [ ] Change control: propose file changes and ask approval before editing.

---
