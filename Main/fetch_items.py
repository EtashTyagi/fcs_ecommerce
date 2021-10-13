# TODO: Number of available items, use in cart and while displaying on main tab
import json
import math
import random
from Main.models import Product


# Return -1 for invalid request
def fetchItems(request):
    # TODO params like sort by, name, etc...
    result_fetch = []
    for prod in Product.objects.raw('SELECT 1 id, ID, title, image, short_description, price FROM products'):
        result_fetch.append(json.dumps(
            {
                'ID': str(prod.ID),
                'image': prod.image,
                'title': prod.title,
                'short_description': prod.short_description,
                'price': str(prod.price),
                'rating': str(int(random.random() * 11))
            }))

    print(result_fetch)
    return result_fetch


# Return -1 for invalid request
def fetchFullItem(itemID):
    query_str = f'SELECT 1 id, title, image, description, price FROM products WHERE products.ID={itemID}'
    print(query_str)
    for prod in Product.objects.raw(query_str):
        return json.dumps({
            'ID': str(itemID),
            'image': prod.image,
            'title': prod.title,
            'description': prod.description,
            'price': str(prod.price),
            'rating': str(int(random.random() * 11))
        })
    return -1



def fetchCart(userID):
    # TODO Auth Comply
    fetched_list = []
    for i in range(0, 4):
        fetched_list.append(json.dumps({
            'ID': random.random() * 10,
            'image': f'https://picsum.photos/300/200/?random={i}',
            'title': str(makeid(math.floor(random.random() * 8) + 3)),
            'qty': f'{math.ceil(random.random() * 10):d}',
            'price': f'{(random.random() * 10):.2f}'
        }))
    return fetched_list


# TODO: Item Wise intake, do server side validation, separate code
def UpdateCart(itemID_and_qty):
    return None


def initiateTransaction(itemID_and_qty):
    UpdateCart(itemID_and_qty)


def makeid(length):
    result = ''
    characters = 'abcdefghijklmnopqrstuvwxyz'
    charactersLength = len(characters)
    for i in range(0, length):
        result += characters[math.floor(random.random() * charactersLength)]
        if random.random() > 0.85:
            result += ' '
    return result[0].upper() + result[1:]
