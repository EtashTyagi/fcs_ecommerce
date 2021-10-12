from django.contrib import admin
from django.http import HttpResponse
from django.shortcuts import render
from Main.fetch_items import *
from Main.auth_handler import *

""" Define All HTML Views To Render Here in all_views list with appropriate name"""


def home(request):
    if request.method == "POST":
        return HttpResponse("404 - not found")

    args = {"items": fetchItems(request)}
    return render(request, 'home.html', args)


def cart(request):
    if request.method == "POST":
        return HttpResponse("404 - not found")

    args = {"items": fetchCart(request.user)}
    return render(request, 'cart.html', args)


def discounts(request):
    if request.method == "POST":
        return HttpResponse("404 - not found")

    return render(request, 'discounts.html')


def login(request):
    if request.method == "POST":
        response = authenticate_user(request)
        if not response[0]:
            return HttpResponse(f"<h1>Unable To Authenticate</h1> <p>{response[1]}</p>")
        else:
            # Do stuff
            None

    return render(request, 'login.html')


def sell(request):
    if request.method == "POST":
        return HttpResponse("404 - not found")

    return render(request, 'sell.html')


def signup(request):
    if request.method == "POST":
        response = create_user(request)
        if not response[0]:
            return HttpResponse(f"<h1>Unable To Create User</h1> <p>{response[1]}</p>")
        else:
            # Do stuff
            None

    return render(request, 'signup.html')


def item(request):
    if request.method == "POST":
        return HttpResponse("404 - not found")

    args = {"item": fetchFullItem(request.GET["id"])}
    return render(request, 'main_item_page.html', args)


def checkout(request):
    return render(request, 'checkout.html')


all_views = {
    "admin": {"url": "admin/", "view": admin.site.urls},
    "cart": {"url": "cart/", "view": cart},
    "discounts": {"url": "discounts/", "view": discounts},
    "home": {"url": "", "view": home},
    "login": {"url": "login/", "view": login},
    "signup": {"url": "signup/", "view": signup},
    "sell": {"url": "sell/", "view": sell},
    "item": {"url": "item/", "view": item},
    "checkout": {"url": "checkout/", "view": checkout}
}
