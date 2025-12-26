# Database & SQLAlchemy/Replicado Rules

Guidelines for specialized data access in the USP environment.

## Hybrid ORM Usage
- **Django ORM**: Use for all application-specific data (Users, Profiles, Local records).
- **SQLAlchemy 2.0**: Use for querying the **Replicado** (Sybase/MSSQL).

## Replicado Connection
- Use the `SQLALCHEMY_DATABASE_URI` configurated in `.env`.
- Ensure connections are pooled and disposed of correctly.
- Use `REPLICADO_SYBASE=True` for legacy Sybase compatibility.

## SQL Performance
- Always use index-optimized queries for the Replicado.
- Avoid fetching thousands of records at once; use pagination or server-side filtering.
- Use `sqlalchemy.text()` for complex queries that don't fit the SQLAlchemy Expression Language.

## Data Mapping
- Keep Replicado models in a separate module (e.g., `replicado_models.py`).
- Use Type Hinting for all data returned from SQLAlchemy queries.
