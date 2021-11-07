from django.contrib import admin
from django.http import HttpResponse
from django.http import JsonResponse
from django.shortcuts import render, redirect

from Cart.cart_handler import fetchCart, is_in_cart, add_to_cart, remove_from_cart
from Utils.all_urls import all_urls
from Utils.item_handler import *
from Authentication.auth_handler import *

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


def profile(request):
    request.session.pop('login_to_continue_to', None)
    if request.method == "GET":
        usr_id = request.user.id
        if "id" in request.GET:
            usr_id = request.GET["id"][-1] if len(request.GET["id"]) > 0 and request.GET["id"][-1] == '/' else request.GET["id"]

        if request.user.is_authenticated:
            user = User.objects.get(id=usr_id)
            if user:
                args = {"group": None, "id": user.id, "email": user.email, "owner": user.id == request.user.id,
                        "username": user.username}
                if user.is_superuser:
                    args["group"] = "admin"
                elif is_seller(user):
                    args["group"] = "seller"
                elif is_buyer(user):
                    args["group"] = "buyer"
                else:
                    args["group"] = ""
                return render(request, 'pages/main_profile.html', args)
            else:
                return HttpResponse("<h1>Error</h1><p>User Not Found!</p>")
        else:
            request.session['login_to_continue_to'] = all_urls["profile"]
            return redirect(all_urls["login"])
    else:
        return HttpResponse("<h1>Error</h1><p>Bad Request</p>")


def admin_response_to_new_item_request_GUI(request):
    if request.user.is_authenticated and request.user.is_superuser:
        if request.method == "GET":
            req_items = fetch_new_item_requests()
            args = {"requests": req_items, "keys": list(req_items[0].keys()) if len(req_items) != 0 else []}
            return render(request, 'pages/admin_response_to_new_item_request.html', args)
        elif request.method == "POST":
            print(request.POST)
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


def admin_response_to_update_item_request_GUI(request):
    if request.user.is_authenticated and request.user.is_superuser:
        if request.method == "GET":
            req_items = fetch_new_item_requests()
            args = {"requests": req_items, "keys": list(req_items[0].keys()) if len(req_items) != 0 else []}
            return render(request, 'pages/admin_response_to_new_item_request.html', args)
        elif request.method == "POST":
            print(request.POST)
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

all_views = {
    "profile": profile,
    "admin_response_to_new_item_request": admin_response_to_new_item_request_GUI
}
