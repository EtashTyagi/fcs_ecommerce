from Utils.auth_handler import *
from django.http import HttpResponse, Http404
from django.shortcuts import render, redirect

from Utils.all_urls import all_urls
from Utils.item_handler import *
from Utils.upload_handler import download_request_pdf_file

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


def profile(request):
    request.session.pop('login_to_continue_to', None)
    if request.method == "GET":
        usr_id = request.user.id
        if "id" in request.GET:
            usr_id = request.GET["id"][-1] if len(request.GET["id"]) > 0 and request.GET["id"][-1] == '/' else \
                request.GET["id"]

        if request.user.is_authenticated:
            try:
                user = User.objects.get(id=usr_id)
                if user and (len(request.GET) == 0 or (len(request.GET) == 1 and "id" in request.GET)):
                    args = {"group": None, "id": user.id, "email": user.email, "owner": user.id == request.user.id,
                            "username": user.username, "first_name": user.first_name, "last_name": user.last_name,
                            "phone_number": get_phone_number(user)}
                    if is_admin(user):
                        args["group"] = "admin"
                    elif is_seller(user):
                        args["group"] = "seller"
                    elif is_buyer(user):
                        args["group"] = "buyer"
                    else:
                        args["group"] = ""
                    return render(request, 'pages/main_profile.html', args)
                else:
                    return Http404("<h1>Error</h1><p>Bad Request!</p>")
            except Exception as e:
                return Http404("<h1>Error</h1><p>User Not Found!</p>")
        else:
            request.session['login_to_continue_to'] = all_urls["profile"]
            return redirect(all_urls["login"])
    elif request.method == "POST" and "modify_profile" in request.POST:
        result = update_phone_number(request.user, request.POST["phone"])
        if result[0]:
            return redirect(all_urls["profile"])
        else:
            return HttpResponse(f"<h1>Error</h1><p>Invalid Mobile Number!</p><p><a href='{redirect(all_urls['profile'])}'>go back</a></p>")
    else:
        return HttpResponse("<h1>Error</h1><p>Bad Request</p>")


def admin_response_to_new_item_request_GUI(request):
    if request.user.is_authenticated and is_admin(request.user):
        if request.method == "GET":
            req_items = fetch_new_item_requests_using(request.user)
            args = {"requests": req_items, "keys": list(req_items[0].keys()) if len(req_items) != 0 else []}
            return render(request, 'pages/admin_response_to_new_item_request.html', args)
        elif request.method == "POST":
            if "response_accept" in request.POST == "response_decline" in request.POST:
                return HttpResponse("<h1>Error</h1><p>Bad Request</p>")
            elif "response_accept" in request.POST and prod_request_exists(request.POST["response_accept"]):
                accept_item(request.POST["response_accept"])
            elif "response_decline" in request.POST and prod_request_exists(request.POST["response_decline"]):
                reject_item(request.POST["response_decline"],
                            request.POST["message"] if "message" in request.POST else "")
            else:
                return HttpResponse("<h1>Error</h1><p>Bad Request</p>")
            req_items = fetch_new_item_requests_using(request.user)
            args = {"requests": req_items, "keys": list(req_items[0].keys()) if len(req_items) != 0 else []}
            return render(request, 'pages/admin_response_to_new_item_request.html', args)
        else:
            return HttpResponse("<h1>Error</h1><p>Bad Request</p>")
    else:
        return HttpResponse("<h1>Error</h1><p>Bad Request</p>")


def admin_response_to_seller_request_GUI(request):
    if request.user.is_authenticated and is_admin(request.user):
        if request.method == "GET":
            req_items = get_all_seller_requests_using(request.user)
            args = {"requests": req_items, "keys": list(req_items[0].keys()) if len(req_items) != 0 else []}
            return render(request, 'pages/admin_response_to_seller_request.html', args)
        elif request.method == "POST":
            if "download" in request.POST:
                return download_request_pdf_file(request.POST["download"])
            if "response_accept" in request.POST == "response_decline" in request.POST:
                return HttpResponse("<h1>Error</h1><p>Bad Request</p>")
            elif "response_accept" in request.POST and seller_request_exists(request.POST["response_accept"]):
                accept_seller_request(request.POST["response_accept"])
            elif "response_decline" in request.POST and seller_request_exists(request.POST["response_decline"]):
                reject_seller_request(request.POST["response_decline"],
                                      request.POST["message"] if "message" in request.POST else "")
            else:
                return HttpResponse("<h1>Error</h1><p>Bad Request</p>")
            req_items = get_all_seller_requests_using(request.user)
            args = {"requests": req_items, "keys": list(req_items[0].keys()) if len(req_items) != 0 else []}
            return render(request, 'pages/admin_response_to_seller_request.html', args)
        else:
            return HttpResponse("<h1>Error</h1><p>Bad Request</p>")
    else:
        return HttpResponse("<h1>Error</h1><p>Bad Request</p>")


def purchases(request):
    if request.user.is_authenticated and (
            is_buyer(request.user) or is_seller(request.user) or is_admin(request.user)):
        args = {"purchases": fetch_buyer_purchases(request.user)}
        return render(request, "pages/buyer_purchases.html", args)
    else:
        return HttpResponse("<h1>Error</h1><p>Bad Request</p>")


all_views = {
    "profile": profile,
    "admin_response_to_new_item_request": admin_response_to_new_item_request_GUI,
    "admin_response_to_seller_request": admin_response_to_seller_request_GUI,
    "purchases": purchases
}
