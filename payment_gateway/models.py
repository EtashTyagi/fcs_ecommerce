from django.db import models
from django.conf import settings
from store.models import Product

User = settings.AUTH_USER_MODEL


class Transaction(models.Model):
    seller = models.ForeignKey(User, on_delete=models.SET_NULL,
                               null=True, related_name='%(class)s_seller', blank=True,
                               default=None)
    item = models.ForeignKey(Product, on_delete=models.SET_NULL,
                             null=True, blank=True, default=None)
    buyer = models.ForeignKey(User, on_delete=models.SET_NULL,
                              null=True, related_name='%(class)s_buyer', blank=True,
                              default=None)
    price = models.DecimalField(max_digits=13, decimal_places=2)
    stripe_transaction_id = models.CharField(max_length=100, primary_key=True)
    status = models.CharField(max_length=20)

    def __str__(self):
        return self.stripe_transaction_id
