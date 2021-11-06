from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from django.db.models import fields
from .models import Account


# Register your models here.

# following class helps in making password non editable
class AccountAdmin(UserAdmin):
    list_display = ('email', 'first_name', 'last_name', 'last_login', 'date_joined', 'is_active')
    list_display_links = ('email', 'first_name', 'last_name')

    readonly_fields = ('last_login', 'date_joined')
    ordering = ('-date_joined',)  # -sign for decreasing order

    filter_horizontal = ()
    list_filter = ()
    fieldsets = ()  # makes password read only


admin.site.register(Account, AccountAdmin)
