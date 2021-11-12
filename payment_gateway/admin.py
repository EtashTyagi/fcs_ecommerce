from django.contrib import admin
from .models import *


class TransactionAdmin(admin.ModelAdmin):
    pass


admin.site.register(Transaction, TransactionAdmin)
