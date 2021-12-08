from django.http import HttpResponse
from django.shortcuts import render, redirect

from Utils.auth_handler import is_seller, make_seller_request, get_seller_request_status
from Utils.all_urls import all_urls
from Utils.item_handler import *

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


def sell(request):
    request.session.pop('login_to_continue_to', None)
    args = {"success": False, "message": "", "allowed": is_seller(request.user)}
    if not request.user.is_authenticated:
        request.session['login_to_continue_to'] = all_urls["sell"]
        return redirect(all_urls["login"])
    elif is_seller(request.user):
        if request.method == "GET":
            return render(request, 'pages/sell.html', args)
        else:
            return HttpResponse("<h1>Error</h1><p>Bad Request</p>")
    else:
        if request.method == "GET":
            args["message"] = get_seller_request_status(request.user)
            return render(request, 'pages/sell.html', args)
        elif request.method == "POST" and "seller_request" in request.POST:
            res = make_seller_request(request)
            args["success"] = res[0]
            args["message"] = res[1]
            return render(request, 'pages/sell.html', args)
        else:
            return HttpResponse("<h1>Error</h1><p>Bad Request</p>")


def sell_new(request):
    request.session.pop('login_to_continue_to', None)
    args = {"success": False, "message": "", "allowed": is_seller(request.user)}
    if not request.user.is_authenticated:
        request.session['login_to_continue_to'] = all_urls["sell"]
        return redirect(all_urls["login"])
    elif is_seller(request.user):
        if request.method == "GET":
            return render(request, 'pages/sell_newitem.html', args)
        elif request.method == "POST":
            if "product_request" in request.POST:
                res = insert_new_item_request(request)
                args["success"] = res[0]
                args["message"] = res[1]
                return render(request, 'pages/sell_newitem.html', args)
        else:
            return HttpResponse("<h1>Error</h1><p>Bad Request</p>")
    else:
        return redirect(all_urls["sell"])


def sell_pending(request):
    request.session.pop('login_to_continue_to', None)
    args = {"success": False, "message": "", "allowed": is_seller(request.user)}
    if not request.user.is_authenticated:
        request.session['login_to_continue_to'] = all_urls["sell"]
        return redirect(all_urls["login"])
    elif is_seller(request.user):
        if request.method == "GET":
            args["requests"] = fetch_item_request_for_user(request.user)
            return render(request, 'pages/sell_pendingrejected.html', args)
        elif request.method == "POST":
            if "delete_request" in request.POST:
                delete_request_item(request.POST["delete_request"], request.user)
                args["requests"] = fetch_item_request_for_user(request.user)
                return render(request, 'pages/sell_pendingrejected.html', args)
            else:
                args["requests"] = fetch_item_request_for_user(request.user)
                return render(request, 'pages/sell_pendingrejected.html', args)
        else:
            return HttpResponse("<h1>Error</h1><p>Bad Request</p>")
    else:
        return redirect(all_urls["sell"])


def sell_listed(request):
    request.session.pop('login_to_continue_to', None)
    args = {"success": False, "message": "", "allowed": is_seller(request.user)}
    if not request.user.is_authenticated:
        request.session['login_to_continue_to'] = all_urls["sell"]
        return redirect(all_urls["login"])
    elif is_seller(request.user):
        if request.method == "GET":
            args["requests"] = fetch_seller_listed_items(request.user)
            return render(request, 'pages/sell_listed.html', args)
        elif request.method == "POST":
            if "delete_request" in request.POST:
                delete_product(request.POST["delete_request"], request.user)
                args["requests"] = fetch_seller_listed_items(request.user)
                return render(request, 'pages/sell_listed.html', args)
            elif "update_request" in request.POST:
                item_id = request.POST["update_request"]
                to_add = int(request.POST[f"add_{item_id}"])
                if to_add > 0:
                    update_inventory(to_add, request.user, item_id)
                    args["requests"] = fetch_seller_listed_items(request.user)
                    return render(request, 'pages/sell_listed.html', args)
                else:
                    return HttpResponse("<h1>Error</h1><p>Bad Request</p>")
            else:
                return HttpResponse("<h1>Error</h1><p>Bad Request</p>")
        else:
            return HttpResponse("<h1>Error</h1><p>Bad Request</p>")
    else:
        return redirect(all_urls["sell"])


def sell_sold(request):
    request.session.pop('login_to_continue_to', None)
    args = {"success": False, "message": "", "allowed": is_seller(request.user)}
    if not request.user.is_authenticated:
        request.session['login_to_continue_to'] = all_urls["sell"]
        return redirect(all_urls["login"])
    elif is_seller(request.user):
        args["sales"] = fetch_seller_sales(request.user)
        return render(request, 'pages/sell_sales.html', args)
    else:
        return redirect(all_urls["sell"])


all_views = {
    "sell": sell,
    "sell_new": sell_new,
    "sell_pending_rejected": sell_pending,
    "sell_listed": sell_listed,
    "sell_sold": sell_sold
}
