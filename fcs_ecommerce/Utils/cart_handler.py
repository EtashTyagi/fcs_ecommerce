from django.db import connection

from Main import settings
from cart.models import Cart
from payment_gateway.models import Transaction
from store.models import Product


def fetchCart(user):
    items = []
    for prod in Product.objects.raw(
            """SELECT stripe_prod_id, title, image_1, price, available_quantity FROM 
            (SELECT * FROM cart_cart WHERE user_id = %s) as my_cart 
            INNER JOIN store_product ON my_cart.item_id = store_product.stripe_prod_id;""",
            [user.id]):
        items.append({
            'ID': str(prod.stripe_prod_id),
            'image': settings.STATIC_URL + str(prod.image_1),
            'title': prod.title,
            'price': str(prod.price),
            'available_quantity': str(prod.available_quantity)
        })
    return items


def is_in_cart(user, productID):
    for _ in Cart.objects.raw(
            'SELECT * FROM cart_cart WHERE user_id=%s AND item_id=%s',
            [user.id, productID]):
        return True
    return False


def add_to_cart(user, productID):
    with connection.cursor() as cursor:
        cursor.execute("INSERT INTO cart_cart(item_id, user_id) VALUES (%s, %s)", [productID, user.id])


def remove_from_cart(user, productID):
    _remove_from_cart(user.id, productID)


def _remove_from_cart(userID, productID):
    with connection.cursor() as cursor:
        cursor.execute("DELETE FROM cart_cart where user_id=%s and item_id=%s;", [userID, productID])


def cart_is_full(user):
    cnt = 0
    for _ in Product.objects.raw(
            'SELECT 1 stripe_prod_id  FROM cart_cart WHERE user_id=%s',
            [user.id]):
        cnt += 1
        if cnt == 10:
            return True
    return False


def insert_new_transaction(seller_id, item_id, buyer_id, price, stripe_transaction_id):
    with connection.cursor() as cursor:
        cursor.execute("""INSERT INTO payment_gateway_transaction(seller_id, item_id, buyer_id, price, 
        stripe_transaction_id, status) VALUES (%s, %s, %s, %s, %s, %s)""",
                       [seller_id, item_id, buyer_id, price, stripe_transaction_id, "Pending"])


def fail_transaction(stripe_transaction_id):
    with connection.cursor() as cursor:
        cursor.execute("""UPDATE payment_gateway_transaction SET status=%s WHERE stripe_transaction_id=%s """,
                       ["Failed", stripe_transaction_id])


def succeed_transaction(stripe_transaction_id):
    with connection.cursor() as cursor:
        cursor.execute("""UPDATE payment_gateway_transaction SET status=%s WHERE stripe_transaction_id=%s """,
                       ["Successful", stripe_transaction_id])
    for prod in Transaction.objects.raw(
            """SELECT stripe_transaction_id, buyer_id, item_id 
            FROM payment_gateway_transaction WHERE stripe_transaction_id=%s""",
            [stripe_transaction_id]):
        _remove_from_cart(prod.buyer_id, prod.item_id)
