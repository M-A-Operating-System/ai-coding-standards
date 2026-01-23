# Function & Class Documentation
Every Python function and class must have a docstring that documents its purpose, all input parameters (with types and descriptions), and return values.

# Input Parameter Documentation
All input variables and arguments must be clearly documented for type, expected values, and rationale.

# Inline Comments
Inline comments should be used to clarify non-obvious logic or rationale.
# Python Documentation Standards
Implementation of: /documentation_standards.md

## Relationship to Standards
This file provides the Python-specific implementation ("How") for the documentation requirements defined in `/documentation_standards.md` ("What").

## Docstrings
- **Style**: Google Style.
- **Format**:
  ```python
  def fetch_data(user_id: int) -> dict:
      """Fetches user data from the remote API.

      Args:
          user_id: The unique identifier of the user.

      Returns:
          A dictionary containing user details.

      Raises:
          UserNotFoundError: If the user does not exist.
      """
  ```

## Tools
- **Generation**: `mkdocs` with `mkdocs-material` and `mkdocstrings`.
- **API Docs**: FastAPI automatic OpenAPI generation (`/docs`).
