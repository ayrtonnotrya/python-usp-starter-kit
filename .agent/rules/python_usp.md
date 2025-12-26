# Python USP Starter Kit - General Rules

This file defines the core standards for the Python USP Starter Kit, ensuring consistency, security, and performance.

## Tech Stack
- **Languages**: Python 3.14+ (Slim Bookworm)
- **Framework**: Django (Latest stable)
- **Database**: PostgreSQL (Primary), Sybase/MSSQL (Replicado via SQLAlchemy 2.0)
- **Cache/Queue**: Redis + Celery
- **Auth**: Senha Única USP (OAuth 1.0a)
- **Tools**: Poetry, Docker, Ruff, MyPy, Pytest

## The Golden Rule (SSDLC)
> [!IMPORTANT]
> **No raw SQL** is allowed unless wrapped in `sqlalchemy.text()` with explicit **bind parameters**. Always prioritize ORM (Django ORM for local, SQLAlchemy for Replicado).

## Architecture & Layering
- **Business Logic**: Must reside in `services/` (e.g., `apps/users/services.py`).
- **Views**: Should be thin, delegating to services.
- **Models**: Unified naming convention (PascalCase).
- **Typing**: Strict type hinting is mandatory. Pass `mypy --strict`.

## Security
- **Hardened Containers**: Never run as root. Use `appuser`.
- **Secrets**: Use `.env` (managed by `python-decouple` or `environ`). Never hardcode secrets.
- **CSRF/SSL**: Always enabled in production.

## Code Quality
- **Linting**: Ruff (fast, replaces Flake8/Isort).
- **Formatting**: Black-style formatting via Ruff.
- **Testing**: Pytest for unit/integration. Goal: 80%+ coverage.
