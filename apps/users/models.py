from django.contrib.auth.models import AbstractUser


class User(AbstractUser):
    """Custom user model for the USP Starter Kit.

    Starting a project with a custom user model is a Django best practice:
    it allows future fields (e.g. numero_usp) to be added without the
    painful migration required to swap the default user model later.
    """
