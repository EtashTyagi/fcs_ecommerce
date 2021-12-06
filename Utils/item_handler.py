# IMPORTANT: PLEASE DO NOT USE FORMAT STRING IN RAW SQL QUERIES, IT WILL CAUSE SQL INJECTIONS:
# https://docs.djangoproject.com/en/3.2/topics/db/sql/
from django.core.exceptions import ValidationError
from django.db import connection, DataError

from Utils.auth_handler import is_admin
from Utils.upload_handler import FileValidator, upload_prod_image_file, delete_prod_image_file
from payment_gateway.models import Transaction
from Main import settings
from store.models import Product
from sell.models import New_Product_Request
import stripe

# Return None for invalid request

"""
    Params in request (method == GET)
        1. q -> search query
        2. c -> category
"""


def fetchCategories():
    categories = []
    for prod in Product.objects.raw('SELECT DISTINCT(category),1 stripe_prod_id FROM store_product'):
        categories.append(prod.category.title())
    return categories


def fetchItems(request, search_in=("title",), limit=float('inf')):
    # TODO params like sort by, name, etc...
    result_fetch = []
    q_string = ('%' + ("" if "q" not in request.GET else request.GET["q"][:-1]
    if len(request.GET["q"]) > 0 and request.GET["q"][-1] == '/' else request.GET["q"]) + '%').lower()
    category = ("" if "c" not in request.GET else request.GET["c"][:-1]
    if len(request.GET["c"]) > 0 and request.GET["c"][-1] == '/' else request.GET["c"]).lower()
    sh_item = lambda product: {'ID': str(prod.stripe_prod_id),
                               'image': settings.STATIC_URL + prod.image_1,
                               'title': prod.title,
                               'short_description': prod.short_description,
                               'price': str(prod.price),
                               'seller_id': str(prod.seller_id)}
    done_ids = set({})
    get_limits = lambda: 2147483647 if limit == float('inf') or limit is not int or limit < 0 else limit
    if "title" in search_in:
        if category == "":
            for prod in Product.objects.raw(
                    """SELECT stripe_prod_id, title, image_1, short_description, price, seller_id 
                    FROM store_product WHERE LOWER(title) LIKE %s limit %s""",
                    [q_string, get_limits() - len(result_fetch)]):
                result_fetch.append(sh_item(prod))
                done_ids.add(prod.stripe_prod_id)
        else:
            for prod in Product.objects.raw(
                    """SELECT stripe_prod_id, title, image_1, short_description, price, seller_id 
                     FROM store_product WHERE LOWER(title) LIKE %s AND LOWER(category)=%s limit %s""",
                    [q_string, category, get_limits() - len(result_fetch)]):
                result_fetch.append(sh_item(prod))
                done_ids.add(prod.stripe_prod_id)
    if "short_description" in search_in:
        if category == "":
            for prod in Product.objects.raw(
                    """SELECT stripe_prod_id, title, image_1, short_description, price, seller_id 
                     FROM store_product WHERE LOWER(short_description) LIKE %s limit %s""",
                    [q_string, get_limits() - len(result_fetch)]):
                if prod.stripe_prod_id not in done_ids:
                    result_fetch.append(sh_item(prod))
                    done_ids.add(prod.stripe_prod_id)
        else:
            for prod in Product.objects.raw(
                    """SELECT stripe_prod_id, title, image_1, short_description, price, seller_id 
                     FROM store_product WHERE LOWER(short_description) LIKE %s AND LOWER(category)=%s limit %s""",
                    [q_string, category, get_limits() - len(result_fetch)]):
                if prod.stripe_prod_id not in done_ids:
                    result_fetch.append(sh_item(prod))
                    done_ids.add(prod.stripe_prod_id)
    if "description" in search_in:
        if category == "":
            for prod in Product.objects.raw(
                    """SELECT stripe_prod_id, title, image_1, short_description, price, seller_id 
                     FROM store_product WHERE LOWER(description) LIKE %s limit %s""",
                    [q_string, get_limits() - len(result_fetch)]):
                if prod.stripe_prod_id not in done_ids:
                    result_fetch.append(sh_item(prod))
                    done_ids.add(prod.stripe_prod_id)
        else:
            for prod in Product.objects.raw(
                    """SELECT stripe_prod_id, title, image_1, short_description, price, seller_id 
                     FROM store_product WHERE LOWER(description) LIKE %s AND LOWER(category)=%s  limit %s""",
                    [q_string, category, get_limits() - len(result_fetch)]):
                if prod.stripe_prod_id not in done_ids:
                    result_fetch.append(sh_item(prod))
                    done_ids.add(prod.stripe_prod_id)
    return result_fetch


# Return None for invalid request
def fetchFullItem(id):
    for prod in Product.objects.raw(
            """SELECT * FROM store_product WHERE stripe_prod_id=%s""",
            [id]):
        return __prod_to_dict(prod)
    return None


def insert_new_item_request(request):
    seller_id = request.user.id
    print(request.FILES)
    title = request.POST["title"]
    short_description = request.POST["short_description"]
    description = request.POST["description"]
    price = request.POST["price"]
    prod_type = request.POST["prod_type"].lower()

    try:
        temp_price = float(price)
        if temp_price <= 0:
            return [False, "Invalid Price"]
    except ValueError:
        return [False, "Invalid Price"]

    if description.lower().find("<script") != -1 or description.lower().find("</script>") != -1:
        return [False, "Script Tag Not Allowed!"]

    if "image_1" not in request.FILES or "image_2" not in request.FILES:
        return [False, "Images Not Supplied"]

    if New_Product_Request.objects.filter(seller_id=seller_id, title__iexact=title.lower()).exists():
        return [False, f"Item '{title.lower()}' already requested by you!"]

    if Product.objects.filter(seller_id=seller_id, title__iexact=title.lower()).exists():
        return [False, f"Item '{title.lower()}' already listed by you!"]

    prev = fetch_item_request_for_user(request.user)
    if len(prev) > 9:
        return [False, "Delete requests or wait for approval"]

    image_1 = request.FILES["image_1"]
    image_2 = request.FILES["image_2"]
    image_3 = request.FILES["image_3"] if "image_3" in request.FILES else None
    image_4 = request.FILES["image_4"] if "image_4" in request.FILES else None
    image_5 = request.FILES["image_5"] if "image_5" in request.FILES else None

    validator = FileValidator(max_size=1024 * 1024, content_types=("image/png", "image/jpg", "image/gif"))
    try:
        validator(image_1)
        fp_1 = upload_prod_image_file(image_1, title)
        validator(image_2)
        fp_2 = upload_prod_image_file(image_2, title)
        fp_3 = None
        fp_4 = None
        fp_5 = None
        if image_3:
            validator(image_3)
            fp_3 = upload_prod_image_file(image_3, title)
        if image_4:
            validator(image_4)
            fp_4 = upload_prod_image_file(image_4, title)
        if image_5:
            validator(image_5)
            fp_5 = upload_prod_image_file(image_5, title)

        try:
            with connection.cursor() as cursor:
                cursor.execute(
                    """INSERT INTO sell_new_product_request(seller_id, title, short_description, description, price, category, 
                    image_1, image_2, image_3, image_4, image_5, message) 
                    VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)""",
                    [seller_id, title, short_description, description, price, prod_type, fp_1, fp_2, fp_3,
                     fp_4, fp_5, "Processing"])
        except DataError:
            try:
                delete_prod_image_file(fp_1)
                delete_prod_image_file(fp_2)
            except OSError:
                pass
                try:
                    if image_3:
                        delete_prod_image_file(fp_3)
                except OSError:
                    pass
                try:
                    if image_4:
                        delete_prod_image_file(fp_4)
                except OSError:
                    pass
                try:
                    if image_5:
                        delete_prod_image_file(fp_5)
                except OSError:
                    pass
            return [False, "Invalid Input"]
    except ValidationError as e:
        return [False, e.message]

    return [True, "Request Sent"]


def fetch_new_item_requests_using(user):
    result_fetch = []
    if is_admin(user) and not user.is_superuser:
        for prod in New_Product_Request.objects.raw(
                """SELECT  * FROM sell_new_product_request  WHERE LOWER(message)=%s AND seller_id!=%s""",
                ["processing", user.id]):
            result_fetch.append(__prod_req_to_dict(prod))
    elif user.is_superuser:
        for prod in New_Product_Request.objects.raw(
                """SELECT  * FROM sell_new_product_request WHERE LOWER(message)=%s""",
                ["processing"]):
            result_fetch.append(__prod_req_to_dict(prod))
    return result_fetch


def accept_item(id):
    for prod in New_Product_Request.objects.raw(
            'SELECT * FROM sell_new_product_request WHERE id=%s LIMIT 1',
            [id]):
        stripe.api_key = settings.STRIPE_SECRET_KEY
        stripe_prod = stripe.Product.create(name=str(prod.title) + "[" + str(prod.id) + "]",
                                            description=prod.short_description)
        stripe_price = stripe.Price.create(unit_amount=int(float(prod.price) * 100.0),
                                           currency="inr",
                                           product=stripe_prod["id"], )
        with connection.cursor() as cursor:
            cursor.execute("""INSERT INTO store_product
            (seller_id, title, short_description, description, price, category, image_1, image_2, image_3, image_4, 
            image_5, available_quantity, stripe_prod_id, stripe_price_id)
             VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, 0, %s, %s)""",
                           [prod.seller_id, prod.title, prod.short_description,
                            prod.description, prod.price, prod.category, prod.image_1, prod.image_2,
                            prod.image_3, prod.image_4, prod.image_5, stripe_prod["id"], stripe_price["id"]])
    with connection.cursor() as cursor:
        cursor.execute("""DELETE FROM sell_new_product_request WHERE id=%s""", [id])


def reject_item(item_id, message):
    with connection.cursor() as cursor:
        cursor.execute("""UPDATE sell_new_product_request SET message=%s  WHERE id=%s""", [message, item_id])
    return True


def delete_product(item_id, user):
    prod = Product.objects.get(stripe_prod_id=item_id, seller_id=user.id)
    try:
        delete_prod_image_file(prod.image_1)
        delete_prod_image_file(prod.image_2)
    except OSError:
        pass
    try:
        if prod.image_3 is not None:
            delete_prod_image_file(prod.image_3)
    except OSError:
        pass
    try:
        if prod.image_4 is not None:
            delete_prod_image_file(prod.image_4)
    except OSError:
        pass
    try:
        if prod.image_5 is not None:
            delete_prod_image_file(prod.image_5)
    except OSError:
        pass

    with connection.cursor() as cursor:
        cursor.execute(
            """DELETE FROM store_product WHERE stripe_prod_id=%s AND seller_id=%s AND available_quantity=0""",
            [item_id, user.id])
    return True


def update_inventory(to_add, user, item_id):
    to_add = int(to_add) if str(to_add).isdecimal() else 0
    if 0 < to_add < 100:
        with connection.cursor() as cursor:
            cursor.execute(
                """UPDATE store_product SET available_quantity=available_quantity+%s  
                WHERE stripe_prod_id=%s AND seller_id=%s""",
                [to_add, item_id, user.id])
        return True
    else:
        return False


def delete_request_item(req_id, user):
    prod = New_Product_Request.objects.get(id=req_id, seller_id=user.id)
    try:
        delete_prod_image_file(prod.image_1)
        delete_prod_image_file(prod.image_2)
    except OSError:
        pass
    try:
        if prod.image_3 is not None:
            delete_prod_image_file(prod.image_3)
    except OSError:
        pass
    try:
        if prod.image_4 is not None:
            delete_prod_image_file(prod.image_4)
    except OSError:
        pass
    try:
        if prod.image_5 is not None:
            delete_prod_image_file(prod.image_5)
    except OSError:
        pass

    with connection.cursor() as cursor:
        cursor.execute("""DELETE FROM sell_new_product_request WHERE id=%s AND seller_id=%s""", [req_id, user.id])
    return True


def prod_request_exists(item_id):
    for prod in New_Product_Request.objects.raw(
            'SELECT id FROM sell_new_product_request WHERE id=%s', [item_id]):
        return True
    return False


def fetch_item_request_for_user(user):
    result_fetch = []
    for prod in New_Product_Request.objects.raw(
            """SELECT * FROM sell_new_product_request WHERE seller_id=%s""",
            [user.id]):
        result_fetch.append(__prod_req_to_dict(prod))
    return result_fetch


def fetch_seller_listed_items(user):
    items = []
    for prod in Product.objects.raw(
            """SELECT * FROM store_product WHERE seller_id=%s""",
            [user.id]):
        items.append(__prod_to_dict(prod))
    return items


def fetch_seller_sales(seller):
    purchases = []
    for prod in Transaction.objects.raw(
            'SELECT stripe_transaction_id, seller_id, buyer_id, item_id, price, status '
            'FROM payment_gateway_transaction WHERE seller_id=%s',
            [seller.id]):
        purchases.append({"Sno": prod.stripe_transaction_id,
                          "Seller": prod.seller_id,
                          "Buyer": prod.buyer_id,
                          "Item": prod.item_id,
                          "Price": prod.price,
                          "status": prod.status})
    return purchases


def fetch_buyer_purchases(buyer):
    purchases = []
    for prod in Transaction.objects.raw(
            'SELECT stripe_transaction_id, seller_id, buyer_id, item_id, price, status '
            'FROM payment_gateway_transaction WHERE buyer_id=%s',
            [buyer.id]):
        purchases.append({"Sno": prod.stripe_transaction_id,
                          "Seller": prod.seller_id,
                          "Buyer": prod.buyer_id,
                          "Item": prod.item_id,
                          "Price": prod.price,
                          "status": prod.status})
    return purchases


def reserve_item(id):
    for prod in Product.objects.raw(
            """SELECT stripe_prod_id FROM store_product WHERE stripe_prod_id=%s""",
            [id]):
        with connection.cursor() as cursor:
            if prod.available_quantity > 0:
                cursor.execute(
                    """UPDATE store_product SET available_quantity=available_quantity-1  WHERE stripe_prod_id=%s""",
                    [id])
                return True
    return False


def failed_un_reserve(id):
    for prod in Product.objects.raw(
            """SELECT stripe_prod_id FROM store_product WHERE stripe_prod_id=%s""",
            [id]):
        with connection.cursor() as cursor:
            cursor.execute(
                """UPDATE store_product SET available_quantity=available_quantity+1  WHERE stripe_prod_id=%s""",
                [id])
            return True
    return False


def __prod_req_to_dict(prod):
    return {
        'req_id': str(prod.id),
        'seller_id': str(prod.seller_id),
        'category': str(prod.category),
        'image_1': settings.STATIC_URL + prod.image_1,
        'image_2': settings.STATIC_URL + prod.image_2,
        'image_3': settings.STATIC_URL + prod.image_3 if prod.image_3 is not None else None,
        'image_4': settings.STATIC_URL + prod.image_4 if prod.image_4 is not None else None,
        'image_5': settings.STATIC_URL + prod.image_5 if prod.image_5 is not None else None,
        'title': prod.title,
        'price': str(prod.price),
        'short_description': prod.short_description,
        'description': prod.description,
        'message': prod.message
    }


def __prod_to_dict(prod):
    return {
        'ID': str(prod.stripe_prod_id),
        'image_1': settings.STATIC_URL + prod.image_1,
        'image_2': settings.STATIC_URL + prod.image_2,
        'image_3': settings.STATIC_URL + prod.image_3 if prod.image_3 is not None else None,
        'image_4': settings.STATIC_URL + prod.image_4 if prod.image_4 is not None else None,
        'image_5': settings.STATIC_URL + prod.image_5 if prod.image_5 is not None else None,
        'title': prod.title,
        'description': prod.description,
        'price': prod.price,
        'price_id': str(prod.stripe_price_id),
        'seller_id': str(prod.seller_id),
        'inventory': str(prod.available_quantity)
    }
