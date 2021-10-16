# TODO: Number of available items, use in cart and while displaying on main tab
# IMPORTANT: PLEASE DO NOT USE FORMAT STRING IN RAW SQL QUERIES, IT WILL CAUSE SQL INJECTIONS https://docs.djangoproject.com/en/3.2/topics/db/sql/
import json
import math
import random
from Main.models import Product


# Return -1 for invalid request
def fetchItems(request):
    # TODO params like sort by, name, etc...
    result_fetch = []
    for prod in Product.objects.raw('SELECT 1 id, ID, title, image, short_description, price FROM products'):
        result_fetch.append({
                'ID': str(prod.ID),
                'image': prod.image,
                'title': prod.title,
                'short_description': prod.short_description,
                'price': str(prod.price),
                'rating': str(int(random.random() * 11))
            })
    return result_fetch


# Return -1 for invalid request
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
    return -1


def makeid(length):
    result = ''
    characters = 'abcdefghijklmnopqrstuvwxyz'
    charactersLength = len(characters)
    for i in range(0, length):
        result += characters[math.floor(random.random() * charactersLength)]
        if random.random() > 0.85:
            result += ' '
    return result[0].upper() + result[1:]
