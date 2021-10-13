from django.db import models


class Product(models.Model):
    ID = models.IntegerField()
    title = models.CharField(max_length=25)
    short_description = models.CharField(max_length=200)
    description = models.CharField(max_length=5000)
    price = models.DecimalField(max_digits=13, decimal_places=2)
    image = models.CharField(max_length=1000)
