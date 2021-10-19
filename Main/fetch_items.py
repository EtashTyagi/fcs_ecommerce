# TODO: Number of available items, use in cart and while displaying on main tab
# IMPORTANT: PLEASE DO NOT USE FORMAT STRING IN RAW SQL QUERIES, IT WILL CAUSE SQL INJECTIONS:
# https://docs.djangoproject.com/en/3.2/topics/db/sql/
import json
import math
import random
from Main.models import Product

# Return None for invalid request
"""
    Params in request (method == GET)
        1. q -> search query
"""


def fetchItems(request):
    # TODO params like sort by, name, etc...
    result_fetch = []
    q_string = ('%' + ("" if "q" not in request.GET else request.GET["q"][:-1]
    if request.GET["q"][-1] == '/' else request.GET["q"]) + '%').lower()
    sh_item = lambda product: {'ID': str(prod.ID),
                               'image': prod.image,
                               'title': prod.title,
                               'short_description': prod.short_description,
                               'price': str(prod.price),
                               'rating': str(int(random.random() * 11))}
    done_ids = set({})
    for prod in Product.objects.raw(
            'SELECT 1 id, ID, title, image, short_description, price FROM products WHERE LOWER(title) LIKE %s', [q_string]):
        result_fetch.append(sh_item(prod))
        done_ids.add(prod.ID)

    for prod in Product.objects.raw(
            'SELECT 1 id, ID, title, image, short_description, price FROM products WHERE LOWER(short_description) LIKE %s', [q_string]):
        if prod.ID not in done_ids:
            result_fetch.append(sh_item(prod))
            done_ids.add(prod.ID)

    for prod in Product.objects.raw(
            'SELECT 1 id, ID, title, image, short_description, price FROM products WHERE LOWER(description) LIKE %s', [q_string]):
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


def makeid(length):
    result = ''
    characters = 'abcdefghijklmnopqrstuvwxyz'
    charactersLength = len(characters)
    for i in range(0, length):
        result += characters[math.floor(random.random() * charactersLength)]
        if random.random() > 0.85:
            result += ' '
    return result[0].upper() + result[1:]
