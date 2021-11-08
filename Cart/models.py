from django.db import models


class Transaction(models.Model):
    seller_id = models.IntegerField(default=None, blank=True, null=True)
    item_id = models.BigIntegerField(default=None, blank=True, null=True)
    buyer_id = models.IntegerField(default=None, blank=True, null=True)
    price = models.DecimalField(max_digits=13, decimal_places=2)
    stripe_transaction_id = models.CharField(max_length=100, primary_key=True)
    status = models.CharField(max_length=200)

    def __str__(self):
        return self.id
