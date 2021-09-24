"""Main URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Write a renderer in views and include it in all_views dictionary with relevant info
"""
from django.urls import path
from . import views

urlpatterns = [path(views.all_views[key]["url"], views.all_views[key]["view"]) for key in views.all_views.keys()]
