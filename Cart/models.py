from django.db import models
from django.conf import settings
from store.models import Product

User = settings.AUTH_USER_MODEL


class Cart(models.Model):
    user = models.ForeignKey(User, on_delete=models.SET_NULL, null=True)
    item = models.ForeignKey(Product, on_delete=models.SET_NULL, null=True)

    def __str__(self):
        return "user=" + str(self.user) + "; item=" + str(self.item)



