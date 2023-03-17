"""Main URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Write a renderer in views and include it in all_views dictionary with relevant info
"""
from django.urls import re_path
from django.contrib import admin
from django.urls import path, include

import authentication.views
from Main.views import all_views
from Utils.all_urls import all_urls

urlpatterns = [
    re_path(r'^admin/login/', authentication.views.login),
    re_path(r'admin/', admin.site.urls),
    path('', include('store.urls')),
    path('', include('authentication.urls')),
    path('', include('cart.urls')),
    path('', include('payment_gateway.urls')),
    path('', include('profile.urls')),
    path('', include('search.urls')),
    path('', include('sell.urls'))
]

for key in all_views.keys():
    urlpatterns.append(path(all_urls[key][1:], all_views[key], name=key))
