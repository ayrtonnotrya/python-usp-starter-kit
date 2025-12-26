# Django Guidelines for USP Projects

Standards for building Django applications within the USP ecosystem.

## Project Structure
- Follow the **Twelve-Factor App** methodology.
- Apps should be located in an `apps/` directory if the project grows large.
- Keep `settings.py` modular (base, local, production).

## Authentication & Authorization
- Use `senhaunica-socialite-python` for authentication.
- Map USP "vínculos" (Aluno, Docente, Servidor) to Django Groups or custom Permissions.
- Use the **Login-as** (impersonate) feature for debugging in non-production environments.

## Admin Customization
- Use a clean, modern theme for the Django Admin (e.g., Django Suit or custom CSS).
- Ensure all models have searchable and filterable fields in Admin.

## Best Practices
- Use `SlugField` for SEO-friendly URLs.
- Always implement `get_absolute_url()` in models.
- Avoid logic in templates; use Custom Template Tags/Filters if necessary.
