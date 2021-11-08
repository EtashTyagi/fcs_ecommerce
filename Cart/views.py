from django.http import HttpResponse
from django.shortcuts import render, redirect

from Authentication.auth_handler import is_seller, is_buyer
from Cart.cart_handler import fetchCart, is_in_cart, remove_from_cart
from Utils.all_urls import all_urls

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


def cart(request):
    request.session.pop('login_to_continue_to', None)
    if not request.user.is_authenticated:
        request.session['login_to_continue_to'] = all_urls["cart"]
        return redirect(all_urls["login"])
    elif (not is_seller(request.user)) and (not is_buyer(request.user)):
        return HttpResponse("<h1>Error</h1><p>Account Not Verified</p>")
    elif request.method == "GET":
        args = {"items": fetchCart(request.user), "tot_price": 0}
        for item in args["items"]:
            args["tot_price"] += float(item["price"])
        return render(request, 'pages/cart.html', args)
    elif request.method == "POST":
        if "remove_from_cart" in request.POST:
            removal = request.POST["remove_from_cart"]
            if is_in_cart(request.user, removal):
                remove_from_cart(request.user, removal)
                return redirect(all_urls["cart"])
            else:
                return HttpResponse("<h1>Error</h1><p>Bad Request</p>")
        else:
            return HttpResponse("<h1>Error</h1><p>Bad Request</p>")
    else:
        return HttpResponse("<h1>Error</h1><p>Bad Request</p>")


all_views = {
    "cart": cart
}
