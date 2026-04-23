# Claude Guidelines
This document provides guidelines for agents.

## All
The following applies to all projects.
### General
- Always make sure to understand the underlying problem before coming up with a solution.
- The user's proposed approach may be misguided or may indicate that they are not solving the correct problem, ask questions to clarify.
- Use `tmp/` (not `/tmp`) for intermediate files and artifacts.
### Programming
- Prefer composition over inheritance.
- Prefer early returns to avoid nesting.
- Avoid over-abstraction and over excessive function decomposition when logic is sequential and context dependent.
- Avoid using dependencies whenever possible.
### Code Style
- Comments should be use sparingly, and they should explain the "why", not the "what".
- Add comments to explain something that is missing or omitted that the reader might expect.

## Python
The following only apply when working in Python project (or with Python files).
### Programming
- Use `@dataclass` for simple data containers.
### Package Management
- Use `uv` for package management.
- Always use the Python from `.venv`, create the `.venv` if it does not exist with `uv venv`. If it's a new project, use `uv init`.
- If unsure about how to use `uv`, consult the [documentation](https://docs.astral.sh/uv/reference/cli/).
### Documentation
- Always document public functions and classes with docstrings (parameters, returns, exceptions).
- Keep documentation clear and concise.
### Code Style
- Follow PEP8 style.
- Always use type hints.
- Avoid the use of `Any` as a type hint.
- Use `uvx ruff check` in the project's root directory for linting.
- Use `uvx mypy` to verify type hints.
### Testing
- Use `pytest` as the testing framework.
- Always add unit tests for code added.
