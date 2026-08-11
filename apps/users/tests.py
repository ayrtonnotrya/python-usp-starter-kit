from django.test import TestCase


class UserModelTests(TestCase):
    def test_custom_user_model_exists(self) -> None:
        from django.contrib.auth import get_user_model

        User = get_user_model()
        self.assertEqual(User._meta.label, 'users.User')
