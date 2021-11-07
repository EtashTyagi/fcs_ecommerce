# TODO: CHECK IF ITEMS ARE IN STOCK, SHOW NUMBER OF ITEMS IN STOCK
from django.db import connection

from Store.models import Product


def fetchCart(user):
    for prod in Product.objects.raw(
            'SELECT id, title, image_1, price FROM (SELECT * FROM cart WHERE user_id = %s) as my_cart INNER JOIN store_product ON my_cart.product_id = store_product.id;',
            [user.id]):
        return {
            'ID': str(prod.id),
            'image': str(prod.image_1),
            'title': prod.title,
            'price': str(prod.price)
        }
    return None



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


def cart_is_full(user):
    for _ in Product.objects.raw(
            'SELECT 1 id, product_id FROM cart WHERE user_id=%s',
            [user.id]):
        return True
    return False
