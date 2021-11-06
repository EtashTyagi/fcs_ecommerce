from django.http import HttpResponse
from django.shortcuts import render, redirect

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

# TODO : SELLER PERMISSION
def sell(request):
    request.session.pop('login_to_continue_to', None)
    args = {"success": False}
    if not request.user.is_authenticated:
        request.session['login_to_continue_to'] = all_urls["sell"]
        return redirect(all_urls["login"])
    elif request.method == "GET":
        return render(request, 'pages/sell.html', args)
    elif request.method == "POST":
        insert_new_item_request(request)
        args["success"] = True
        return render(request, 'pages/sell.html', args)
    else:
        return HttpResponse("<h1>Error</h1><p>Bad Request</p>")


all_views = {
    "sell": sell
}
