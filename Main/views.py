from django.contrib import admin
from django.http import HttpResponse
from django.shortcuts import render, redirect

from Main.cart_handler import fetchCart, is_in_cart, add_to_cart
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

    if request.user.is_authenticated:
        args = {"items": fetchCart(request.user)}
        return render(request, 'cart.html', args)
    else:
        request.session['login_to_continue'] = True
        return redirect('/login/')


def discounts(request):
    if request.method == "POST":
        return HttpResponse("404 - not found")

    return render(request, 'discounts.html')


def login(request):
    args = {"green": False, "red": False}
    if request.user.is_authenticated:
        return redirect('/')

    if request.method == "POST":
        response = authenticate_user(request)
        if not response[0]:
            args["red"] = True
            args["message"] = "Wrong Credentials"
        else:
            return redirect('/')
    if 'redirect_from_signup' in request.session.keys():
        args["green"] = True
        args["message"] = "Sign-up Successful"
        request.session.pop('redirect_from_signup')
    if 'login_to_continue' in request.session.keys():
        args["green"] = True
        args["message"] = "Log-in To Continue"
        request.session.pop('login_to_continue')

    return render(request, 'login.html', args)


def sell(request):
    if request.method == "POST":
        return HttpResponse("404 - not found")

    return render(request, 'sell.html')


def signup(request):
    args = {"failed": False}
    if request.user.is_authenticated:
        return redirect('/')

    if request.method == "POST":
        response = create_user(request)
        if not response[0]:
            args["failed"] = True
            args["message"] = response[1]
            return render(request, 'signup.html', args)
        else:
            args["user"] = response[1]
            request.session['redirect_from_signup'] = True
            return redirect('/login/')

    return render(request, 'signup.html', args)


def item(request):
    if request.method == "POST":
        if request.POST["type"] == "add_to_cart":
            product_id = request.GET["id"][:-1] if request.GET["id"][-1] == '/' else request.GET["id"]
            if not is_in_cart(request.user, product_id):
                add_to_cart(request.user, product_id)

    args = {"item": fetchFullItem(request.GET["id"][:-1] if request.GET["id"][-1] == '/' else request.GET["id"])}
    args["in_cart"] = is_in_cart(request.user, args["item"]["ID"]) if request.user.is_authenticated else False
    return render(request, 'main_item_page.html', args)


# TODO: Extremely important, validate if can checkout (stock, positive items, ....)
def checkout(request):
    return render(request, 'checkout.html')


def profile(request):
    if request.user.is_authenticated:
        return HttpResponse("Profile")
    else:
        request.session['login_to_continue'] = True
        return redirect('/login/')


def logout(request):
    logout_user(request)
    return redirect("/")


all_views = {
    "admin": {"url": "admin/", "view": admin.site.urls},
    "cart": {"url": "cart/", "view": cart},
    "discounts": {"url": "discounts/", "view": discounts},
    "home": {"url": "", "view": home},
    "login": {"url": "login/", "view": login},
    "signup": {"url": "signup/", "view": signup},
    "sell": {"url": "sell/", "view": sell},
    "item": {"url": "item/", "view": item},
    "checkout": {"url": "checkout/", "view": checkout},
    "profile": {"url": "profile/", "view": profile},
    "logout": {"url": "logout/", "view": logout}
}
