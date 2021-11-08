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
from Authentication.auth_handler import is_seller, is_buyer
from Utils.item_handler import reserve_item, fetchFullItem

stripe.api_key = settings.STRIPE_SECRET_KEY


class CreateCheckoutSessionView(View):
    def post(self, request, *args, **kwargs):
        item = fetchFullItem(self.kwargs["pk"])
        YOUR_DOMAIN = "http://127.0.0.1:80"  # change in production
        reserve_item(item["ID"])
        checkout_session = stripe.checkout.Session.create(
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
            expires_at=(int(time.time()+3602))
        )
        print(time.time()+60)
        request.session["checking_out"] = True
        return redirect(checkout_session.url)


class SuccessView(TemplateView):
    template_name = "pages/success.html"

    # def post(self, request, *args, **kwargs):
    #     if "checking_out" in request.session:
    #         request.session.pop("checking_out")
    #         return render(request, template_name=self.template_name)
    #     else:
    #         return HttpResponse("Invalid Request")
    #
    # def get(self, request, *args, **kwargs):
    #     if "checking_out" in request.session:
    #         request.session.pop("checking_out")
    #         return render(request, template_name=self.template_name)
    #     else:
    #         return HttpResponse("Invalid Request")


class CancelView(TemplateView):
    template_name = "pages/cancel.html"

    def post(self, request, *args, **kwargs):
        if "checking_out" in request.session:
            request.session.pop("checking_out")
            return render(request, template_name=self.template_name)
        else:
            return HttpResponse("Invalid Request")

    def get(self, request, *args, **kwargs):
        if "checking_out" in request.session:
            request.session.pop("checking_out")
            return render(request, template_name=self.template_name)
        else:
            return HttpResponse("Invalid Request")





class StripeIntentView(View):
    def post(self, request, *args, **kwargs):
        try:
            req_json = json.loads(request.body)
            customer = stripe.Customer.create(email=req_json['email'])
            price = get_item_by_priceID(self.kwargs["pk"])
            intent = stripe.PaymentIntent.create(
                amount=price.price,
                currency='usd',
                customer=customer['id'],
                metadata={
                    "price_id": price.id
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
        product = stripe_Product.objects.get(name="MSI GF75 Thin")
        prices = Price.objects.filter(product=product)
        context = super(CustomPaymentView, self).get_context_data(**kwargs)
        context.update({
            "product": product,
            "prices": prices,
            "STRIPE_PUBLIC_KEY": settings.STRIPE_PUBLIC_KEY
        })
        return context


all_views = {}
