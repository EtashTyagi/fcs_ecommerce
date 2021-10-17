from django.contrib import admin
from django.http import HttpResponse
from django.shortcuts import render, redirect

from Main.cart_handler import fetchCart, is_in_cart, add_to_cart, remove_from_cart
from Main.fetch_items import *
from Main.auth_handler import *

""" Define All HTML Views To Render Here in all_views list with appropriate name"""

""" View Format (Follow Strictly !!!!):
        0. Handle invalid requests (eg in item.)
        1. Handle tasks dependent on auth of user (only authed user can do some tasks)
        2. Handle permissions (only seller can sell)
        3. Handle GET request
        4. Handle POST request
        5. Else return HttpResponse("<h1>Error</h1><p>Bad Request</p>")
        6. When combined (POST and must be authed), handle auth inside the request type block !!
        7. After change to database using POST 'ALWAYS' redirect !!!
"""


def home(request):
    request.session.pop('login_to_continue_to', None)
    if request.method == "GET":
        args = {"items": fetchItems(request)}
        return render(request, 'home.html', args)
    else:
        return HttpResponse("<h1>Error</h1><p>Bad Request</p>")


def cart(request):
    request.session.pop('login_to_continue_to', None)
    args = {"items": fetchCart(request.user)}
    if not request.user.is_authenticated:
        request.session['login_to_continue_to'] = "/cart"
        return redirect('/login/')
    elif request.method == "GET":
        return render(request, 'cart.html', args)
    elif request.method == "POST":
        if "remove_from_cart" in request.POST:
            removal = request.POST["remove_from_cart"]
            if removal.isdigit() and is_in_cart(request.user, int(removal)):
                remove_from_cart(request.user, int(removal))
                return redirect('/cart/')
            else:
                return HttpResponse("<h1>Error</h1><p>Bad Request</p>")
        else:
            return HttpResponse("<h1>Error</h1><p>Bad Request</p>")
    else:
        return HttpResponse("<h1>Error</h1><p>Bad Request</p>")


# FIXME: This is redundant?
def discounts(request):
    request.session.pop('login_to_continue_to', None)
    if request.method == "GET":
        return render(request, 'discounts.html')
    else:
        return HttpResponse("<h1>Error</h1><p>Bad Request</p>")


def login(request):
    args = {"green": False, "red": False}
    if request.user.is_authenticated:
        return redirect('/')
    elif request.method == "GET":
        if 'redirect_from_signup' in request.session.keys():
            args["green"] = True
            args["message"] = "Sign-up Successful"
            request.session.pop('redirect_from_signup')
        if 'login_to_continue_to' in request.session.keys():
            args["green"] = True
            args["message"] = "Log-in To Continue"
        return render(request, 'login.html', args)
    elif request.method == "POST":
        response = authenticate_user(request)
        if not response[0]:
            args["red"] = True
            args["message"] = "Wrong Credentials"
            return render(request, 'login.html', args)
        else:
            redirect_to = "/"
            if 'login_to_continue_to' in request.session.keys():
                redirect_to = request.session['login_to_continue_to']
            return redirect(redirect_to)
    else:
        return HttpResponse("<h1>Error</h1><p>Bad Request</p>")


# TODO : SELLER PERMISSION
def sell(request):
    request.session.pop('login_to_continue_to', None)
    if not request.user.is_authenticated:
        request.session['login_to_continue_to'] = "/sell"
        return redirect('/login/')
    elif request.method == "GET":
        return render(request, 'sell.html')
    elif request.method == "POST":
        return request("<h1>Error</h1><p>Not Implemented</p>")
    else:
        return HttpResponse("<h1>Error</h1><p>Bad Request</p>")


# TODO: VERIFY EMAIL?
def signup(request):
    request.session.pop('login_to_continue_to', None)
    args = {"failed": False, "message": ""}
    if request.user.is_authenticated:
        return redirect('/')
    elif request.method == "GET":
        return render(request, 'signup.html', args)
    elif request.method == "POST":
        response = create_user(request)
        if not response[0]:
            args["failed"] = True
            args["message"] = response[1]
            return render(request, 'signup.html', args)
        else:
            args["user"] = response[1]
            request.session['redirect_from_signup'] = True
            return redirect('/login/')
    else:
        return HttpResponse("<h1>Error</h1><p>Bad Request</p>")


def item(request):
    request.session.pop('login_to_continue_to', None)
    args = {"item": fetchFullItem(request.GET["id"][:-1] if request.GET["id"][-1] == '/' else request.GET["id"])}
    args["in_cart"] = is_in_cart(request.user, args["item"]["ID"]) if request.user.is_authenticated and args[
        "item"] is not None else False
    if args["item"] == -1:
        return HttpResponse("<h1>Error</h1><p>Item Does Not Exist</p>")
    elif request.method == "GET":
        return render(request, 'main_item_page.html', args)
    elif request.method == "POST":
        if request.POST["type"] == "add_to_cart":
            product_id = args["item"]["ID"]
            if not request.user.is_authenticated:
                request.session['login_to_continue_to'] = f'/item/?id={product_id}'
                return redirect('/login/')
            elif not args["in_cart"]:
                add_to_cart(request.user, product_id)
                return redirect(f'/item/?id={product_id}/')
        else:
            return HttpResponse("<h1>Error</h1><p>Bad Request</p>")
    else:
        return HttpResponse("<h1>Error</h1><p>Bad Request</p>")


# FIXME: Extremely important, validate if can checkout (stock, positive items, ....), maybe change method
def checkout(request):
    request.session.pop('login_to_continue_to', None)
    if request.method == "GET":
        return render(request, 'checkout.html')
    else:
        return request


def profile(request):
    request.session.pop('login_to_continue_to', None)
    if request.user.is_authenticated:
        return HttpResponse(
            f"<h1>Profile</h1><h2>User ID:</h2><p>{request.user.id}</p><h2>Username:</h2><p>{request.user.username}</p>")
    else:
        request.session['login_to_continue_to'] = '/profile'
        return redirect('/login/')


def logout(request):
    request.session.pop('login_to_continue_to', None)
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
    "checkout": {"url": "cart/checkout/", "view": checkout},
    "profile": {"url": "profile/", "view": profile},
    "logout": {"url": "logout/", "view": logout}
}
