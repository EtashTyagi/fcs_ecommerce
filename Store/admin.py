from django.contrib import admin
from .models import Product
from django.contrib import admin


# Register your models here.

class ProductAdmin(admin.ModelAdmin):
    pass


admin.site.register(Product, ProductAdmin)
