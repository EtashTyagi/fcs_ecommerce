from django.contrib import admin
from .models import NewProductRequest


class ProductAdmin(admin.ModelAdmin):
    pass

admin.site.register(NewProductRequest, ProductAdmin)
