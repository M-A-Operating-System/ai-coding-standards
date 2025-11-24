# PYTHON INSTRUCTIONS (The "How")
Version: 2.0.0
Parent: /master_instructions.md

## Relationship to Standards
This file provides the Python-specific implementation ("How") for the global master instructions defined in `/master_instructions.md` ("What"). It serves as the entry point for all Python-related code generation tasks.

## Purpose
Provide Python-specific implementation details for the Global Standards.

## Reference Map
| Standard | Python Implementation File |
| :--- | :--- |
| **Coding Style** | `coding_standards.md` |
| **Testing** | `testing_implementation.md` |
| **Security** | `security_implementation.md` |
| **CI/CD** | `ci_cd_implementation.md` |
| **Documentation** | `documentation_implementation.md` |
| **Examples** | `examples.md` |
| **Forbidden** | `forbidden_patterns.md` |

## Python Persona
- **Version**: Python 3.12+
- **Paradigm**: AsyncIO (FastAPI/Starlette ecosystem)
- **Typing**: Strict (mypy strict mode)
- **Config**: Pydantic v2 BaseSettings

## Quick Start for Agents
When asked to write Python code:
1.  Read `/master_instructions.md` for the plan.
2.  Read `languages/python/coding_standards.md` for style.
3.  Read `languages/python/examples.md` for templates.
4.  Check `languages/python/forbidden_patterns.md` before finalizing.
