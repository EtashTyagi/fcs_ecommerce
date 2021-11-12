"""Main URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Write a renderer in views and include it in all_views dictionary with relevant info
"""
from django.urls import path
from profile.views import all_views
from Utils.all_urls import all_urls

urlpatterns = [path(all_urls[key][1:], all_views[key]) for key in all_views.keys()]
