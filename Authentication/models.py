from django.conf import settings
from django.db import models
User = settings.AUTH_USER_MODEL


class Unverified_User(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    auth_token = models.CharField(max_length=100)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.user.username


class Common_Passwords(models.Model):
    password = models.CharField(primary_key=True, max_length=32)

    def __str__(self):
        return self.password


class Phone_Number(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    phone_number = models.CharField(max_length=10)

    def __str__(self):
        return self.user.username
