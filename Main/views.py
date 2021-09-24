from django.contrib import admin
from django.shortcuts import render

""" Define All HTML Views To Render Here in all_views list with appropriate name"""


def home(request):
    return render(request, 'home.html')


def cart(request):
    return render(request, 'cart.html')


def discounts(request):
    return render(request, 'discounts.html')


def login(request):
    return render(request, 'login.html')


def sell(request):
    return render(request, 'sell.html')


all_views = {
    "admin": {"url": "admin/", "view": admin.site.urls},
    "cart": {"url": "cart/", "view": cart},
    "discounts": {"url": "discounts/", "view": discounts},
    "home": {"url": "", "view": home},
    "login": {"url": "login/", "view": login},
    "signup": {"url": "signup/", "view": login},
    "sell": {"url": "sell/", "view": sell}
}
