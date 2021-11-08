from django.contrib import admin
from django.urls import path
from .views import (
    CreateCheckoutSessionView,
    SuccessView,
    CancelView,
    StripeIntentView,
    CustomPaymentView
)

urlpatterns = [
    path('/cancel/', CancelView.as_view(), name='cancel'),
    path('/success/', SuccessView.as_view(), name='success'),
    path('/create-checkout-session/<pk>/',
         CreateCheckoutSessionView.as_view(), name='create-checkout-session'),
    path('/create-payment-intent/<pk>/',
         StripeIntentView.as_view(), name='create-payment-intent'),
    path('/custom-payment/', CustomPaymentView.as_view(), name='custom-payment')
]