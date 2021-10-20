from django.contrib import admin
from django.http import HttpResponse
from django.http import JsonResponse
from django.shortcuts import render, redirect

from Main.cart_handler import fetchCart, is_in_cart, add_to_cart, remove_from_cart
from Main.item_handler import *
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


# TODO: Track number of requests for a session, timeout if > N reqs/sec

def home(request):
    request.session.pop('login_to_continue_to', None)
    if request.method == "GET":
        args = {"items": fetchItems(request, search_in=["title", "short_description", "description"]),
                "q": ("" if "q" not in request.GET or len(request.GET["q"]) == 0 else request.GET["q"][:-1]
                if request.GET["q"][-1] == '/' else request.GET["q"])}
        return render(request, 'pages/home.html', args)
    else:
        return HttpResponse("<h1>Error</h1><p>Bad Request</p>")


# SEARCH HANDLER
def search(request):
    MAX_RES = 10
    if request.method == "GET":
        payload = fetchItems(request, search_in=["title"], limit=MAX_RES)
        return JsonResponse({'status': 200, 'data': payload[0:min(MAX_RES, len(payload))]})
    else:
        return HttpResponse("<h1>Error</h1><p>Bad Request, only GET allowed!</p>")


def cart(request):
    request.session.pop('login_to_continue_to', None)
    args = {"items": fetchCart(request.user)}
    if not request.user.is_authenticated:
        request.session['login_to_continue_to'] = all_views["cart"]["url"]
        return redirect(all_views["login"]["url"])
    elif request.method == "GET":
        return render(request, 'pages/cart.html', args)
    elif request.method == "POST":
        if "remove_from_cart" in request.POST:
            removal = request.POST["remove_from_cart"]
            if removal.isdigit() and is_in_cart(request.user, int(removal)):
                remove_from_cart(request.user, int(removal))
                return redirect(all_views["cart"]["url"])
            else:
                return HttpResponse("<h1>Error</h1><p>Bad Request</p>")
        else:
            return HttpResponse("<h1>Error</h1><p>Bad Request</p>")
    else:
        return HttpResponse("<h1>Error</h1><p>Bad Request</p>")


# FIXME: This is redundant?
def discounts(request):
    if request.method == "GET":
        return render(request, 'pages/discounts.html')
    else:
        return HttpResponse("<h1>Error</h1><p>Bad Request</p>")


def login(request):
    args = {"green": False, "red": False}
    if request.user.is_authenticated:
        return redirect(all_views["home"]["url"])

    elif request.method == "GET":
        if 'redirect_from_signup' in request.session.keys():
            args["green"] = True
            args["message"] = "Sign-up Successful"
            request.session.pop('redirect_from_signup')
        if 'login_to_continue_to' in request.session.keys():
            args["green"] = True
            args["message"] = "Log-in To Continue"
        return render(request, 'pages/login.html', args)
    elif request.method == "POST":
        response = authenticate_user(request)
        if not response[0]:
            args["red"] = True
            args["message"] = "Wrong Credentials"
            return render(request, 'pages/login.html', args)
        else:
            redirect_to = all_views["home"]["url"]
            if 'login_to_continue_to' in request.session.keys():
                redirect_to = request.session['login_to_continue_to']
            return redirect(redirect_to)
    else:
        return HttpResponse("<h1>Error</h1><p>Bad Request</p>")


# TODO : SELLER PERMISSION
def sell(request):
    request.session.pop('login_to_continue_to', None)
    args = {"success": False}
    if not request.user.is_authenticated:
        request.session['login_to_continue_to'] = all_views["sell"]["url"]
        return redirect(all_views["login"]["url"])
    elif request.method == "GET":
        return render(request, 'pages/sell.html', args)
    elif request.method == "POST":
        insert_new_item_request(request)
        args["success"] = True
        return render(request, 'pages/sell.html', args)
    else:
        return HttpResponse("<h1>Error</h1><p>Bad Request</p>")


# TODO: VERIFY EMAIL?
def signup(request):
    request.session.pop('login_to_continue_to', None)
    args = {"failed": False, "message": ""}
    if request.user.is_authenticated:
        return redirect(all_views["home"]["url"])
    elif request.method == "GET":
        return render(request, 'pages/signup.html', args)
    elif request.method == "POST":
        response = create_user(request)
        if not response[0]:
            args["failed"] = True
            return render(request, 'pages/signup.html', args)
        else:
            args["user"] = response[1]
        request.session['redirect_from_signup'] = True
        return redirect(all_views["login"]["url"])
    else:
        return HttpResponse("<h1>Error</h1><p>Bad Request</p>")


def item(request):
    request.session.pop('login_to_continue_to', None)
    args = {"item": fetchFullItem(
        request.GET["id"][:-1] if len(request.GET) > 0 and request.GET["id"][-1] == '/' else request.GET["id"])}

    args["in_cart"] = is_in_cart(request.user, args["item"]["ID"]) if request.user.is_authenticated and args[
        "item"] is not None else False
    if args["item"] == -1:
        return HttpResponse("<h1>Error</h1><p>Item Does Not Exist</p>")
    elif request.method == "GET":
        return render(request, 'pages/main_item_page.html', args)
    elif request.method == "POST":
        if request.POST["type"] == "add_to_cart":
            product_id = args["item"]["ID"]
            if not request.user.is_authenticated:
                request.session['login_to_continue_to'] = all_views["item"]["url"]+f'?id={product_id}/'
                return redirect(all_views["login"]["url"])
            elif not args["in_cart"]:
                add_to_cart(request.user, product_id)
                return redirect(all_views["item"]["url"]+f'?id={product_id}/')
            else:
                return HttpResponse("<h1>Error</h1><p>Item Already In Cart</p>")
        else:
            return HttpResponse("<h1>Error</h1><p>Bad Request</p>")
    else:
        return HttpResponse("<h1>Error</h1><p>Bad Request</p>")


# FIXME: Extremely important, validate if can checkout (stock, positive items, ....), maybe change method
def checkout(request):
    request.session.pop('login_to_continue_to', None)
    if request.method == "GET":
        return render(request, 'pages/checkout.html')
    else:
        return request


# TODO: Extremely important, validate if can checkout (stock, positive items, ....)
def checkout(request):
    return render(request, 'pages/checkout.html')


def profile(request):
    request.session.pop('login_to_continue_to', None)
    if request.user.is_authenticated:
        if request.user.is_superuser:
            # TODO: Change
            return redirect(all_views["admin_response_to_new_item_request"]["url"])
        else:
            return HttpResponse(
                f"<h1>Profile</h1><h2>User ID:</h2><p>{request.user.id}</p><h2>Username:</h2><p>{request.user.username}</p>"
            )
    else:
        request.session['login_to_continue_to'] = all_views["login"]["profile"]
        return redirect(all_views["login"]["url"])


def admin_response_to_new_item_request_GUI(request):
    if request.user.is_authenticated and request.user.is_superuser:
        if request.method == "GET":
            req_items = fetch_new_item_requests()
            args = {"requests": req_items, "keys": list(req_items[0].keys()) if len(req_items) != 0 else []}
            return render(request, 'pages/admin_response_to_new_item_request.html', args)
        elif request.method == "POST":
            if "response_accept" in request.POST == "response_decline" in request.POST:
                return HttpResponse("<h1>Error</h1><p>Bad Request</p>")
            elif "response_accept" in request.POST and request_exists(request.POST["response_accept"]):
                accept_item(request.POST["response_accept"])
            elif "response_decline" in request.POST and request_exists(request.POST["response_decline"]):
                reject_item(request.POST["response_decline"])
            else:
                return HttpResponse("<h1>Error</h1><p>Bad Request</p>")
            req_items = fetch_new_item_requests()
            args = {"requests": req_items, "keys": list(req_items[0].keys()) if len(req_items) != 0 else []}
            return render(request, 'pages/admin_response_to_new_item_request.html', args)
        else:
            return HttpResponse("<h1>Error</h1><p>Bad Request</p>")
    else:
        return HttpResponse("<h1>Error</h1><p>Bad Request</p>")


def logout(request):
    request.session.pop('login_to_continue_to', None)
    logout_user(request)
    return redirect(all_views["home"]["url"])


all_views = {
    "admin": {"url": "/admin/", "view": admin.site.urls},
    "cart": {"url": "/cart/", "view": cart},
    "discounts": {"url": "/discounts/", "view": discounts},
    "home": {"url": "/", "view": home},
    "login": {"url": "/login/", "view": login},
    "signup": {"url": "/signup/", "view": signup},
    "sell": {"url": "/sell/", "view": sell},
    "item": {"url": "/item/", "view": item},
    "checkout": {"url": "/checkout/", "view": checkout},
    "profile": {"url": "/profile/", "view": profile},
    "logout": {"url": "/logout/", "view": logout},
    "search": {"url": "/search/", "view": search},
    "admin_response_to_new_item_request": {"url": "/item_handler/", "view": admin_response_to_new_item_request_GUI}
}
