"""Main URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Write a renderer in views and include it in all_views dictionary with relevant info
"""
from django.contrib import admin
from django.urls import path, include

from Main.views import all_views
from Utils.all_urls import all_urls

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', include('Store.urls')),
    path('', include('Authentication.urls')),
    path('', include('Cart.urls')),
    path('', include('PaymentGateway.urls')),
    path('', include('Profile.urls')),
    path('', include('Search.urls')),
    path('', include('Sell.urls'))
]

for key in all_views.keys():
    urlpatterns.append(path(all_urls[key][1:], all_views[key]))
