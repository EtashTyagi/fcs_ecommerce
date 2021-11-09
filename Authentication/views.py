from django.http import HttpResponse
from django.shortcuts import render, redirect
from Authentication.auth_handler import *
from Utils.all_urls import all_urls
from .models import Unverified_User
from django.contrib import messages, auth

from datetime import datetime
import pyotp
import string
import random
import base64
from django.core.mail import send_mail

# Time after which OTP will expire
EXPIRY_TIME = 120  # seconds
random_string = ''.join(random.choices(string.ascii_uppercase + string.digits, k=10))

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
            args["message"] = "Please Verify Email"
            request.session.pop('redirect_from_signup')
        if 'login_to_continue_to' in request.session.keys():
            args["green"] = True
            args["message"] = "Log-in To Continue"
        return render(request, 'pages/login.html', args)
    elif request.method == "POST":
        response = authenticate_user(request)
        if not response[0]:
            args["red"] = True
            args["message"] = response[1]
            return render(request, 'pages/login.html', args)
        else:
            userid = response[2]
            request.session['otp_user_id'] = userid

            user = User.objects.get(id=userid)

            if is_buyer(user) or is_seller(user) or user.is_superuser:
                email = user.email
                keygen = generate_key()
                key = base64.b32encode(keygen.encode())
                OTP = pyotp.TOTP(key, interval=EXPIRY_TIME)  # do not take this out of this scope
                subject = 'OTP validation'
                message = 'Hey,\nBelow is the 6 digit otp:\n' + str(
                    OTP.now()) + '\n\nthis is a system generated mail. Do not reply'
                email_from = settings.EMAIL_HOST_USER
                recipient_list = [email]
                send_mail(subject, message, email_from, recipient_list)
                request.session['otp_key'] = keygen

                redirect_to = "/otp/"
                return redirect(redirect_to)
            else:
                auth.login(request, user)
                return redirect(all_urls["profile"])

    else:
        return HttpResponse("<h1>Error</h1><p>Bad Request</p>")


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
            args["message"] = response[1]
            return render(request, 'pages/signup.html', args)
        else:
            args["user"] = response[1]
            request.session['redirect_from_signup'] = True
            return redirect(all_urls["email_token"])
    else:
        return HttpResponse("<h1>Error</h1><p>Bad Request</p>")


def logout(request):
    request.session.pop('login_to_continue_to', None)
    logout_user(request)
    return redirect(all_urls["home"])


def email_token(request):
    return render(request, 'pages/token_send.html')


def email_verified(request):
    return render(request, 'pages/email_verified.html')


def verify(request, auth_token):
    try:
        profile_obj = Unverified_User.objects.filter(auth_token=auth_token).first()

        if profile_obj:
            profile_obj.delete()
            if is_buyer(profile_obj.user) or is_seller(profile_obj.user):
                return redirect(all_urls["login"])
            make_buyer(profile_obj.user)
            profile_obj.save()
            return redirect(all_urls["login"])
        else:
            return redirect('/error')
    except Exception as e:
        return redirect(all_urls["login"])


def error_page(request):
    return render(request, 'pages/error_page.html')


def generate_key():
    return str(datetime.date(datetime.now())) + random_string


def otp(request):
    if request.user.is_authenticated:
        return HttpResponse("<h1>Error</h1><p>Bad Request</p>")
    if request.method == "GET":
        if 'otp_user_id' in request.session.keys():
            user = User.objects.get(id=request.session['otp_user_id'])
            args = {"email": user.email}
            return render(request, "pages/otp.html", args)
        else:
            return HttpResponse("<h1>Error</h1><p>Bad Request</p>")

    elif request.method == "POST":
        keygen = request.session['otp_key']
        key = base64.b32encode(keygen.encode())
        request.session.pop('otp_key')
        OTP = pyotp.TOTP(key, interval=EXPIRY_TIME)  # TOTP Model
        if OTP.verify(request.POST["otp"]):
            user = User.objects.get(id=request.session['otp_user_id'])
            auth.login(request, user)
            request.session.pop('otp_user_id')
            # make user authenticated here
            if 'login_to_continue_to' in request.session:
                return redirect(request.session['login_to_continue_to'])
            else:
                return redirect(all_urls['home'])
        else:
            # show a response that otp is expired
            # return Response("OTP is wrong/expired", status=400)
            return HttpResponse(
                f"<h1>Error</h1><p> Otp was wrong or expired </p><p><a href='{all_urls['login']}'>Try again</a></p>")
    else:
        return HttpResponse("<h1>Error</h1><p>Bad Request</p>")


all_views = {
    "login": login,
    "signup": signup,
    "logout": logout,
    "email_token": email_token,
    "email_verified": email_verified,
    "verify_token": verify,
    "verification_error": error_page,
    "otp": otp,
}
