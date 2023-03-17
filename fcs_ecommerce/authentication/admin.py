from django.contrib import admin
from .models import *


class Unverified_UserAdmin(admin.ModelAdmin):
    pass


class Common_PasswordsAdmin(admin.ModelAdmin):
    pass


class Phone_NumberAdmin(admin.ModelAdmin):
    pass


admin.site.register(Unverified_User, Unverified_UserAdmin)
admin.site.register(Common_Passwords, Common_PasswordsAdmin)
admin.site.register(Phone_Number, Phone_NumberAdmin)
