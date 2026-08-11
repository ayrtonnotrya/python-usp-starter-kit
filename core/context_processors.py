from django.conf import settings


def enable_local_login(request) -> dict[str, bool]:
    """Expose the ENABLE_LOCAL_LOGIN flag to templates.

    Allows the login template to conditionally hide the local
    (username/password) form when only the Senha Única USP is desired.
    """
    return {'enable_local_login': settings.ENABLE_LOCAL_LOGIN}
