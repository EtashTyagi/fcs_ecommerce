# TODO: CHECK IF ITEMS ARE IN STOCK, SHOW NUMBER OF ITEMS IN STOCK
from django.db import connection

from Main.models import Product


def fetchCart(user):
    fetched_list = []
    for prod in Product.objects.raw(
            'SELECT 1 id, ID, title, image, price, quantity FROM (SELECT * FROM cart WHERE user_id = %s) as my_cart INNER JOIN products ON my_cart.product_id = products.ID;',
            [user.id]):
        fetched_list.append({
            'ID': str(prod.ID),
            'image': str(prod.image),
            'title': prod.title,
            'qty': 1,
            'price': str(prod.price)
        })
    return fetched_list


def is_in_cart(user, productID):
    for _ in Product.objects.raw(
            'SELECT 1 id, product_id FROM cart WHERE user_id=%s AND product_id=%s',
            [user.id, productID]):
        return True
    return False


def add_to_cart(user, productID):
    with connection.cursor() as cursor:
        cursor.execute("INSERT INTO cart VALUES (%s, %s, %s)", [user.id, productID, 1])


def remove_from_cart(user, productID):
    with connection.cursor() as cursor:
        cursor.execute("DELETE FROM cart where user_id=%s and product_id=%s;", [user.id, productID])

# TODO: Item Wise intake, do server side validation, separate code
def UpdateCart(itemID_and_qty):
    return None


def initiateTransaction(itemID_and_qty):
    UpdateCart(itemID_and_qty)
