# TODO: Number of available items, use in cart and while displaying on main tab
import json
import math
import random


def fetchItems(request):
    # Api Call To Server And More Params like sort by...
    result_fetch = []
    for i in range(0, 50):
        result_fetch.append(json.dumps(
            {
                'ID': random.random() * 10,
                'image': f'https://picsum.photos/300/200/?random={i}',
                'title': str(makeid(math.floor(random.random() * 8) + 3)),
                'short_desc': makeid(math.floor(random.random() * 100) + 100),
                'price': f'{(random.random()*10):.2f}',
                'rating': str(int(random.random() * 11))
            }))
    print(result_fetch)
    return result_fetch


def fetchFullItem(itemID):
    return json.dumps({
        'ID': str(random.random() * 10),
        'image': f'https://picsum.photos/300/200/?random={itemID}',
        'title': str(makeid(math.floor(random.random() * 8) + 3)),
        'price': f'{(random.random()*10):.2f}',
        'rating': str(int(random.random() * 11)),
        'description': 'The really long description. '*125
    })


def fetchCart(userID):
    # TODO Auth Comply
    fetched_list = []
    for i in range(0, 4):
        fetched_list.append(json.dumps({
                'ID': random.random() * 10,
                'image': f'https://picsum.photos/300/200/?random={i}',
                'title': str(makeid(math.floor(random.random() * 8) + 3)),
                'qty': f'{math.ceil(random.random()*10):d}',
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
