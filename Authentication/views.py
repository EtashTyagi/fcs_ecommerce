from django.http import HttpResponse
from django.shortcuts import render, redirect
from Authentication.auth_handler import *
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


def login(request):
    args = {"green": False, "red": False}
    if request.user.is_authenticated:
        return redirect(all_urls["home"])

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
            redirect_to = all_urls["home"]
            if 'login_to_continue_to' in request.session.keys():
                redirect_to = request.session['login_to_continue_to']
            return redirect(redirect_to)
    else:
        return HttpResponse("<h1>Error</h1><p>Bad Request</p>")


# TODO: VERIFY EMAIL?
def signup(request):
    request.session.pop('login_to_continue_to', None)
    args = {"failed": False, "message": ""}
    if request.user.is_authenticated:
        return redirect(all_urls["home"])
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
        return redirect(all_urls["login"])
    else:
        return HttpResponse("<h1>Error</h1><p>Bad Request</p>")


def logout(request):
    request.session.pop('login_to_continue_to', None)
    logout_user(request)
    return redirect(all_urls["home"])


all_views = {
    "login": login,
    "signup": signup,
    "logout": logout
}
