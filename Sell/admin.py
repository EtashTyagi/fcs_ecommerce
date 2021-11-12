from django.contrib import admin
from .models import *


class New_Product_RequestAdmin(admin.ModelAdmin):
    pass


class Seller_RequestAdmin(admin.ModelAdmin):
    pass


admin.site.register(New_Product_Request, New_Product_RequestAdmin)
admin.site.register(Seller_Request, Seller_RequestAdmin)
