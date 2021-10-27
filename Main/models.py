from django.db import models


class Product(models.Model):
    ID = models.IntegerField()
    title = models.CharField(max_length=25)
    short_description = models.CharField(max_length=200)
    description = models.CharField(max_length=5000)
    price = models.DecimalField(max_digits=13, decimal_places=2)
    image = models.CharField(max_length=1000)
    quantity = models.IntegerField()  # For item stock and cart qty

    def __str__(self):
        return self.title


class NewProductRequest(models.Model):
    seller_uid = models.IntegerField()
    ID = models.IntegerField()
    title = models.CharField(max_length=25)
    short_description = models.CharField(max_length=200)
    description = models.CharField(max_length=5000)
    price = models.DecimalField(max_digits=13, decimal_places=2)
    image = models.CharField(max_length=1000)
    quantity = models.IntegerField()  # For item stock and cart qty
    pdf_name = models.CharField(max_length=256)
