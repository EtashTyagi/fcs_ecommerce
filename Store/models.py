from django.conf import settings
from django.db import models
User = settings.AUTH_USER_MODEL


class Product(models.Model):
    stripe_prod_id = models.CharField(max_length=100, primary_key=True)
    stripe_price_id = models.CharField(max_length=100)
    seller = models.ForeignKey(User, on_delete=models.CASCADE)
    title = models.CharField(max_length=25)
    short_description = models.CharField(max_length=200)
    description = models.CharField(max_length=5000)
    price = models.DecimalField(max_digits=13, decimal_places=2)
    image_1 = models.CharField(max_length=1000)
    image_2 = models.CharField(max_length=1000)
    image_3 = models.CharField(max_length=1000, blank=True, null=True)
    image_4 = models.CharField(max_length=1000, blank=True, null=True)
    image_5 = models.CharField(max_length=1000, blank=True, null=True)
    available_quantity = models.IntegerField()
    category = models.CharField(max_length=15)

    def __str__(self):
        return self.title
