# TODO: Number of available items, use in cart and while displaying on main tab
# IMPORTANT: PLEASE DO NOT USE FORMAT STRING IN RAW SQL QUERIES, IT WILL CAUSE SQL INJECTIONS:
# https://docs.djangoproject.com/en/3.2/topics/db/sql/
import random

from django.core.exceptions import ValidationError
from django.db import connection

from Store.models import Product
from Sell.models import NewProductRequest

# Return None for invalid request
from Utils.upload_handler import upload_prod_image_file, FileValidator

"""
    Params in request (method == GET)
        1. q -> search query
        2. c -> category
"""


def fetchCategories():
    categories = []
    for prod in Product.objects.raw('SELECT DISTINCT(category), 1 id FROM store_product'):
        categories.append(prod.category.title())
    return categories


def fetchItems(request, search_in=("title",), limit=float('inf')):
    # TODO params like sort by, name, etc...
    result_fetch = []
    q_string = ('%' + ("" if "q" not in request.GET else request.GET["q"][:-1]
    if len(request.GET["q"]) > 0 and request.GET["q"][-1] == '/' else request.GET["q"]) + '%').lower()
    category = ('%' + ("" if "c" not in request.GET else request.GET["c"][:-1]
    if len(request.GET["c"]) > 0 and request.GET["c"][-1] == '/' else request.GET["c"]) + '%').lower()
    sh_item = lambda product: {'ID': str(prod.id),
                               'image': prod.image_1,
                               'title': prod.title,
                               'short_description': prod.short_description,
                               'price': str(prod.price),
                               'seller_id': str(prod.seller_uid)}
    done_ids = set({})
    get_limits = lambda: 2147483647 if limit == float('inf') or limit is not int or limit < 0 else limit
    if "title" in search_in:
        for prod in Product.objects.raw(
                'SELECT id, title, image_1, short_description, price, category, seller_uid FROM store_product WHERE LOWER(title) LIKE %s AND LOWER(category) LIKE %s limit %s',
                [q_string, category, get_limits() - len(result_fetch)]):
            result_fetch.append(sh_item(prod))
            done_ids.add(prod.id)
    if "short_description" in search_in:
        for prod in Product.objects.raw(
                'SELECT id, title, image_1, short_description, price, category FROM store_product WHERE LOWER(short_description) LIKE %s AND LOWER(category) LIKE %s limit %s',
                [q_string, category, get_limits() - len(result_fetch)]):
            if prod.id not in done_ids:
                result_fetch.append(sh_item(prod))
                done_ids.add(prod.id)
    if "description" in search_in:
        for prod in Product.objects.raw(
                'SELECT id, title, image_1, short_description, price, category, seller_uid FROM store_product WHERE LOWER(description) LIKE %s AND LOWER(category) LIKE %s  limit %s',
                [q_string, category, get_limits() - len(result_fetch)]):
            if prod.id not in done_ids:
                result_fetch.append(sh_item(prod))
                done_ids.add(prod.id)
    return result_fetch


# Return None for invalid request
def fetchFullItem(itemID):
    for prod in Product.objects.raw(
            'SELECT id, title, image_1, image_2, image_3, image_4, image_5, description, price, seller_uid FROM store_product WHERE store_product.id=%s',
            [itemID]):
        return {
            'ID': str(itemID),
            'image_1': prod.image_1,
            'image_2': prod.image_2,
            'image_3': prod.image_3,
            'image_4': prod.image_4,
            'image_5': prod.image_5,
            'title': prod.title,
            'description': prod.description,
            'price': str(prod.price),
            'seller_id': str(prod.seller_uid)
        }
    return None


def insert_new_item_request(request):
    seller_uid = request.user.id
    title = request.POST["title"]
    short_description = request.POST["short_description"]
    description = request.POST["description"]
    price = request.POST["price"]

    image_1 = request.POST["image_1"]
    image_2 = request.POST["image_2"]
    image_3 = request.POST["image_3"] if "image_3" in request.POST else None
    image_4 = request.POST["image_4"] if "image_4" in request.POST else None
    image_5 = request.POST["image_5"] if "image_5" in request.POST else None

    prod_type = request.POST["prod_type"].lower()
    with connection.cursor() as cursor:
        cursor.execute("""INSERT INTO sell_newproductrequest
        (seller_uid, title, short_description, description, price, category, image_1, image_2, image_3, image_4, image_5)
         VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)""",
                       [seller_uid, title, short_description, description, price, prod_type, image_1, image_2, image_3, image_4, image_5])

    return [True, "Request Sent"]



def fetch_new_item_requests():
    result_fetch = []
    for prod in NewProductRequest.objects.raw(
            'SELECT  id, seller_uid, title, short_description, description, price, category, image_1, image_2, image_3, image_4, image_5 FROM sell_newproductrequest'):
        result_fetch.append({
            'req_id': str(prod.id),
            'seller_uid': str(prod.seller_uid),
            'category': str(prod.category),
            'image_1': prod.image_1,
            'image_2': prod.image_2,
            'image_3': prod.image_3,
            'image_4': prod.image_4,
            'image_5': prod.image_5,
            'title': prod.title,
            'price': str(prod.price),
            'short_description': prod.short_description,
            'description': prod.description
        })
    return result_fetch


def accept_item(id):
    for prod in NewProductRequest.objects.raw(
            'SELECT id, seller_uid, title, short_description, description, price, category, image_1, image_2, image_3, image_4, image_5 FROM sell_newproductrequest WHERE id=%s LIMIT 1',
            [id]):
        with connection.cursor() as cursor:
            cursor.execute("""INSERT INTO store_product
            (seller_uid, title, short_description, description, price, category, image_1, image_2, image_3, image_4, image_5, available_quantity)
             VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, 0)""",
                           [prod.seller_uid, prod.title, prod.short_description,
                            prod.description, prod.price, prod.category, prod.image_1, prod.image_2,
                            prod.image_3, prod.image_4, prod.image_5])
    with connection.cursor() as cursor:
        cursor.execute("""DELETE FROM sell_newproductrequest WHERE id=%s""", [id])


def reject_item(id):
    with connection.cursor() as cursor:
        cursor.execute("""DELETE FROM sell_newproductrequest WHERE id=%s""", [id])
    return True


def request_exists(id):
    for prod in NewProductRequest.objects.raw(
            'SELECT 1 id, id FROM sell_newproductrequest WHERE id=%s', [id]):
        return True
    return False
