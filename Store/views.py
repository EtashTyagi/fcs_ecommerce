from django.http import HttpResponse
from django.shortcuts import render, redirect
from Cart.cart_handler import is_in_cart, add_to_cart
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
# TODO: Track number of requests for a session, timeout if > N reqs/sec


def store(request):
    request.session.pop('login_to_continue_to', None)
    if request.method == "GET":
        args = {"items": fetchItems(request, search_in=["title", "short_description", "description"]),
                "q": ("" if "q" not in request.GET or len(request.GET["q"]) == 0 else request.GET["q"][:-1]
                if request.GET["q"][-1] == '/' else request.GET["q"])}
        return render(request, 'pages/store.html', args)
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
                request.session['login_to_continue_to'] = all_urls["item"] + f'?id={product_id}/'
                return redirect(all_urls["login"])
            elif not args["in_cart"]:
                add_to_cart(request.user, product_id)
                return redirect(all_urls["item"] + f'?id={product_id}/')
            else:
                return HttpResponse("<h1>Error</h1><p>Item Already In Cart</p>")
        else:
            return HttpResponse("<h1>Error</h1><p>Bad Request</p>")
    else:
        return HttpResponse("<h1>Error</h1><p>Bad Request</p>")


all_views = {
    "store": store,
    "item": item
}
