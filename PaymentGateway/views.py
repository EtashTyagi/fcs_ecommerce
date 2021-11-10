import json
import time

import stripe

from django.conf import settings
from django.core.mail import send_mail
from django.http import HttpResponse, JsonResponse
from django.shortcuts import redirect, render
from django.views import View
from django.views.decorators.csrf import csrf_exempt
from django.views.generic import TemplateView
from Authentication.auth_handler import is_seller, is_buyer, is_admin
from Authentication.views import generate_key
from Cart.cart_handler import insert_new_transaction, succeed_transaction, fail_transaction
from Store.models import Product
from Utils.all_urls import all_urls
from Utils.item_handler import reserve_item, fetchFullItem

from datetime import datetime
import pyotp
import string
import random
import base64
from django.core.mail import send_mail

# Time after which OTP will expire
EXPIRY_TIME = 120  # seconds

stripe.api_key = settings.STRIPE_SECRET_KEY


class CreateCheckoutSessionView(View):
    def post(self, request, *args, **kwargs):
        request.session["payment_item_id"] = self.kwargs["pk"]
        user = request.user
        if user.is_authenticated and (is_buyer(user) or is_seller(user) or is_admin(user)):
            email = user.email
            keygen = generate_key(''.join(random.choices(string.ascii_uppercase + string.digits, k=10))) + user.email
            key = base64.b32encode(keygen.encode())
            OTP = pyotp.TOTP(key, interval=EXPIRY_TIME)  # do not take this out of this scope
            subject = 'OTP validation'
            message = 'Hey,\nBelow is the 6 digit otp:\n' + str(
                OTP.now()) + '\n\nthis is a system generated mail. Do not reply'
            email_from = settings.EMAIL_HOST_USER
            recipient_list = [email]
            send_mail(subject, message, email_from, recipient_list)
            request.session['otp_key_payment'] = keygen
            request.session['otp_user_id_payment'] = user.id

            redirect_to = "/otp/payment"
            return redirect(redirect_to)
        else:
            return HttpResponse("<h1>Error</h1><p>Permission Denied</p>")

    def get(self, request, *args, **kwargs):
        if "otp_payment_success" in request.session.keys() and "payment_item_id" in request.session:
            request.session.pop("otp_payment_success")
            item = fetchFullItem(request.session["payment_item_id"])
            request.session.pop("payment_item_id")
            YOUR_DOMAIN = "http://127.0.0.1:80"  # change in production
            if not request.user.is_authenticated:
                return redirect(all_urls["login"])
            elif not (is_buyer(request.user) or is_seller(request.user) or is_admin(request.user)):
                return HttpResponse("<h1>Error</h1><p>Account Not Verified</p>")
            elif reserve_item(item["ID"]):
                checkout_session = stripe.checkout.Session.create(
                    customer_email=request.user.email,
                    payment_method_types=['card'],
                    line_items=[
                        {
                            'price': item["price_id"],
                            'quantity': 1,
                        },
                    ],
                    mode='payment',
                    success_url=YOUR_DOMAIN + '/success/',
                    cancel_url=YOUR_DOMAIN + '/cancel/',
                    expires_at=(int(time.time() + 3602)),
                    shipping_address_collection={"allowed_countries": ["IN"]}
                )
                insert_new_transaction(item["seller_id"],
                                       item["ID"], request.user.id,
                                       item["price"], checkout_session["id"])
                request.session["checking_out"] = checkout_session["id"]
                return redirect(checkout_session.url)
            else:
                return HttpResponse("<h1>Error</h1><p>Out Of Stock</p>")
        else:
            return HttpResponse("<h1>Error</h1><p>Bad Request</p>")


class SuccessView(TemplateView):
    template_name = "pages/success.html"

    def post(self, request, *args, **kwargs):
        if "checking_out" in request.session:
            succeed_transaction(request.session["checking_out"])
            request.session.pop("checking_out")
            return render(request, template_name=self.template_name)
        else:
            return HttpResponse("Invalid Request")

    def get(self, request, *args, **kwargs):
        if "checking_out" in request.session:
            succeed_transaction(request.session["checking_out"])
            request.session.pop("checking_out")
            return render(request, template_name=self.template_name)
        else:
            return HttpResponse("Invalid Request")


class CancelView(TemplateView):
    template_name = "pages/cancel.html"

    def post(self, request, *args, **kwargs):
        if "checking_out" in request.session:
            fail_transaction(request.session["checking_out"])
            request.session.pop("checking_out")
            return render(request, template_name=self.template_name)
        else:
            return HttpResponse("Invalid Request")

    def get(self, request, *args, **kwargs):
        if "checking_out" in request.session:
            fail_transaction(request.session["checking_out"])
            request.session.pop("checking_out")
            return render(request, template_name=self.template_name)
        else:
            return HttpResponse("Invalid Request")


class StripeIntentView(View):
    def post(self, request, *args, **kwargs):
        try:
            req_json = json.loads(request.body)
            customer = stripe.Customer.create(email=req_json['email'])
            product = Product.objects.get(stripe_price_id=self.kwargs["pk"])
            intent = stripe.PaymentIntent.create(
                amount=product.price,
                currency='inr',
                customer=customer['id'],
                metadata={
                    "price_id": product.stripe_price_id
                }
            )
            return JsonResponse({
                'clientSecret': intent['client_secret']
            })
        except Exception as e:
            return JsonResponse({'error': str(e)})


class CustomPaymentView(TemplateView):
    template_name = "pages/custom_payment.html"

    def get_context_data(self, **kwargs):
        product = Product.objects.get(stripe_prod_id=1)
        prices = Product.objects.get(stripe_price_id=1)
        context = super(CustomPaymentView, self).get_context_data(**kwargs)
        context.update({
            "product": product,
            "prices": prices,
            "STRIPE_PUBLIC_KEY": settings.STRIPE_PUBLIC_KEY
        })
        return context


all_views = {}
