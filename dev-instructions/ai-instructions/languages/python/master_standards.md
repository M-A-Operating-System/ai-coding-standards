# PYTHON INSTRUCTIONS (The "How")
Version: 2.0.0
Parent: /master_standards.md

## Relationship to Standards
This file provides the Python-specific implementation ("How") for the global master standards defined in `/master_standards.md` ("What"). It serves as the entry point for all Python-related code generation tasks.

## Purpose
Provide Python-specific implementation details for the Global Standards.

## Reference Map
| Standard | Python Implementation File |
| :--- | :--- |
| **Coding Style** | `coding_standards.md` |
| **Testing** | `testing_standards.md` |
| **Security** | `security_standards.md` |
| **CI/CD** | `ops_standards.md` |
| **Documentation** | `documentation_standards.md` |
| **API** | `api_standards.md` |
| **Examples** | `example_standards.md` |
| **Forbidden** | `forbidden_standards.md` |

## Python Persona
- **Version**: Python 3.12+
- **Paradigm**: AsyncIO (FastAPI/Starlette ecosystem)
- **Typing**: Strict (mypy strict mode)
- **Config**: Pydantic v2 BaseSettings

## Quick Start for Agents

When asked to write Python code:

1. Read `/master_standards.md` for the plan.
2. Read `languages/python/coding_standards.md` for style.
3. Read `languages/python/example_standards.md` for templates.
4. Check `languages/python/forbidden_standards.md` before finalizing.
