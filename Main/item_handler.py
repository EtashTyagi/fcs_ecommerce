# TODO: Number of available items, use in cart and while displaying on main tab
# IMPORTANT: PLEASE DO NOT USE FORMAT STRING IN RAW SQL QUERIES, IT WILL CAUSE SQL INJECTIONS:
# https://docs.djangoproject.com/en/3.2/topics/db/sql/
import json
import math
import random

from django.db import connection

from Main.models import Product, NewProductRequest

# Return None for invalid request
from Main.upload_handler import is_valid_file, upload_request_file

"""
    Params in request (method == GET)
        1. q -> search query
"""


def fetchItems(request, search_in=("title",), limit=float('inf')):
    # TODO params like sort by, name, etc...
    result_fetch = []
    q_string = ('%' + ("" if "q" not in request.GET else request.GET["q"][:-1]
    if len(request.GET["q"]) > 0 and request.GET["q"][-1] == '/' else request.GET["q"]) + '%').lower()
    sh_item = lambda product: {'ID': str(prod.ID),
                               'image': prod.image,
                               'title': prod.title,
                               'short_description': prod.short_description,
                               'price': str(prod.price),
                               'rating': str(int(random.random() * 11))}
    done_ids = set({})
    get_limits = lambda: 2147483647 if limit == float('inf') or limit is not int or limit < 0 else limit
    if "title" in search_in:
        for prod in Product.objects.raw(
                'SELECT 1 id, ID, title, image, short_description, price FROM products WHERE LOWER(title) LIKE %s limit %s',
                [q_string, get_limits() - len(result_fetch)]):
            result_fetch.append(sh_item(prod))
            done_ids.add(prod.ID)
    if "short_description" in search_in:
        for prod in Product.objects.raw(
                'SELECT 1 id, ID, title, image, short_description, price FROM products WHERE LOWER(short_description) LIKE %s limit %s',
                [q_string, get_limits() - len(result_fetch)]):
            if prod.ID not in done_ids:
                result_fetch.append(sh_item(prod))
                done_ids.add(prod.ID)
    if "description" in search_in:
        for prod in Product.objects.raw(
                'SELECT 1 id, ID, title, image, short_description, price FROM products WHERE LOWER(description) LIKE %s limit %s',
                [q_string, get_limits() - len(result_fetch)]):
            if prod.ID not in done_ids:
                result_fetch.append(sh_item(prod))
                done_ids.add(prod.ID)
    return result_fetch


# Return None for invalid request
def fetchFullItem(itemID):
    for prod in Product.objects.raw('SELECT 1 id, title, image, description, price FROM products WHERE products.ID=%s',
                                    [itemID]):
        return {
            'ID': str(itemID),
            'image': prod.image,
            'title': prod.title,
            'description': prod.description,
            'price': str(prod.price),
            'rating': str(int(random.random() * 11))
        }
    return None


def insert_new_item_request(request):
    if "pdf" in request.FILES and is_valid_file(request.FILES["pdf"]):
        seller_uid = request.user.id
        upload_request_file(request.FILES["pdf"], seller_uid)
        image = request.POST["image"]
        title = request.POST["title"]
        short_description = request.POST["short_description"]
        description = request.POST["description"]
        price = request.POST["price"]
        pdf_name = request.FILES["pdf"].name
        with connection.cursor() as cursor:
            cursor.execute("""INSERT INTO new_product_requests
            (seller_uid, image, title, short_description, description, price, pdf_name)
             VALUES (%s, %s, %s, %s, %s, %s, %s)""",
                           [seller_uid, image, title, short_description, description, price, pdf_name])


def fetch_new_item_requests():
    result_fetch = []
    for prod in NewProductRequest.objects.raw(
            'SELECT 1 id, req_id, title, image, short_description, description, price, seller_uid, pdf_name FROM new_product_requests'):
        result_fetch.append({
            'req_id': str(prod.req_id),
            'seller_uid': str(prod.seller_uid),
            'image': prod.image,
            'title': prod.title,
            'price': str(prod.price),
            'short_description': prod.short_description,
            'description': prod.description,
            'pdf_name': prod.pdf_name
        })
    return result_fetch


def accept_item(req_id):
    for prod in NewProductRequest.objects.raw(
            'SELECT 1 id, title, image, short_description, description, price FROM new_product_requests WHERE req_id=%s LIMIT 1',
            [req_id]):
        with connection.cursor() as cursor:
            cursor.execute("""INSERT INTO products
            (image, title, short_description, description, price)
             VALUES (%s, %s, %s, %s, %s)""",
                           [prod.image, prod.title, prod.short_description, prod.description, prod.price])
    with connection.cursor() as cursor:
        cursor.execute("""DELETE FROM new_product_requests WHERE req_id=%s""", [req_id])


def reject_item(req_id):
    with connection.cursor() as cursor:
        cursor.execute("""DELETE FROM new_product_requests WHERE req_id=%s""", [req_id])


def request_exists(req_id):
    for prod in NewProductRequest.objects.raw(
            'SELECT 1 id, req_id FROM new_product_requests WHERE req_id=%s', [req_id]):
        return True
    return False
