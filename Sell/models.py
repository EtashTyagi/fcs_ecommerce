from django.db import models
import django.contrib.auth


class NewProductRequest(models.Model):
    seller_uid = models.IntegerField()
    title = models.CharField(max_length=25)
    short_description = models.CharField(max_length=200)
    description = models.CharField(max_length=5000)
    price = models.DecimalField(max_digits=13, decimal_places=2)
    image_1 = models.CharField(max_length=1000)
    image_2 = models.CharField(max_length=1000)
    image_3 = models.CharField(max_length=1000, blank=True, null=True)
    image_4 = models.CharField(max_length=1000, blank=True, null=True)
    image_5 = models.CharField(max_length=1000, blank=True, null=True)
    category = models.CharField(max_length=100)
    message = models.CharField(max_length=2000)

    def __str__(self):
        return self.title


class SellerRequest(models.Model):
    buyer_id = models.IntegerField()
    message = models.CharField(max_length=2000)

    def __str__(self):
        return self.buyer_id