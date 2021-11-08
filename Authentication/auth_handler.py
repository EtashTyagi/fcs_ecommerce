# IMPORTANT: PLEASE DO NOT USE FORMAT STRING IN RAW SQL QUERIES, IT WILL CAUSE SQL INJECTIONS
# https://docs.djangoproject.com/en/3.2/topics/db/sql/
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.models import User, Group
from django.core.exceptions import ValidationError
from django.db import connection

from Main import settings
from Sell.models import SellerRequest
from Utils.upload_handler import FileValidator, upload_request_pdf_file, delete_request_pdf_file

common_passwords = ["password", "12345678"]  # store in sql maybe?


def create_user(request):
    username = request.POST["username"]
    first_name = request.POST["first_name"]
    last_name = request.POST["last_name"]
    email = request.POST["email"]
    password = request.POST["password"]
    conf_password = request.POST["conf_password"]
    phone = request.POST["phone"]

    validation = validate_signup(username, first_name, last_name, email, password, conf_password, phone)
    if not validation[0]:
        return validation
    else:
        created = User.objects.create_user(username, email, password)
        created.first_name = first_name
        created.last_name = last_name
        created.save()
        add_phone_number(created.id, phone)
        make_buyer(created)
        return [True, created]


def is_seller(user):
    return user.groups.filter(name='seller').exists()


def is_buyer(user):
    return user.groups.filter(name='buyer').exists()


def make_seller(user):
    group = Group.objects.get(name="buyer")
    user.groups.remove(group)
    group = Group.objects.get(name="seller")
    user.groups.add(group)


def make_buyer(user):
    group = Group.objects.get(name="buyer")
    user.groups.add(group)


def authenticate_user(request):
    username = request.POST["username"]
    password = request.POST["password"]

    user = authenticate(username=username, password=password)

    if user is None:
        return [False, "Invalid Credentials"]
    else:
        login(request, user)
        return [True, None]


def username_exists(username):
    if User.objects.filter(username=username).exists():
        return True
    else:
        return False


def validate_signup(username, first_name, last_name, email, password, conf_password, phone):
    if username_exists(username):
        return [False, "Username Already Exists"]

    cache = validate_name(first_name)
    if not cache[0]:
        return cache

    cache = validate_name(last_name)
    if not cache[0]:
        return cache

    cache = validate_email(email)
    if not cache[0]:
        return cache

    cache = validate_password(password, conf_password)
    if not cache[0]:
        return cache

    cache = validate_phone(phone)
    if not cache[0]:
        return cache

    return [True, None]


def validate_name(name):
    isAlpha = name.isalpha()
    return [isAlpha, None if isAlpha else "Username Taken"]


def validate_email(email):
    name_domain = email.split("@")
    match = len(name_domain) == 2 and '.' in name_domain[1]
    return [match, None if match else "Invalid Email-ID"]


def validate_password(password, password_conf):
    if password != password_conf:
        return [False, "Passwords Don't Match"]
    elif len(password) < 8:
        return [False, "Password Too Small"]
    elif len(password) > 32:
        return [False, "Password Too Long"]
    elif password in common_passwords:
        return [False, "Password Too Common"]

    return [True, None]


def validate_phone(phone_number):
    return [len(str(phone_number)) == 10, None if len(str(phone_number)) == 10 else "Invalid Phone Number"]


def add_phone_number(user_id, phone_number):
    with connection.cursor() as cursor:
        cursor.execute("INSERT INTO phone_numbers VALUES (%s, %s)", [user_id, phone_number])


def logout_user(request):
    if request.user.is_authenticated:
        logout(request)
        return True
    else:
        return False


def make_seller_request(request):
    if request.method == "POST" and is_buyer(request.user):
        print(request.FILES)
        processing = False
        for req in SellerRequest.objects.raw(
                'SELECT id FROM sell_sellerrequest WHERE buyer_id=%s AND LOWER(message)=%s', [request.user.id, "processing"]):
            processing = True

        if processing:
            return [False, "Request Is Being Processed By Admin!"]
        elif "pdf" in request.FILES:
            file = request.FILES["pdf"]
            validator = FileValidator(max_size=1024 * 1024, content_types=("application/pdf",))
            try:
                validator(file)
                try:
                    upload_request_pdf_file(file, user_id=request.user.id)
                    with connection.cursor() as cursor:
                        cursor.execute("""INSERT INTO sell_sellerrequest
                        (buyer_id, message)
                         VALUES (%s, %s)""",
                                       [str(request.user.id), "Processing"])
                except OSError:
                    return [False, "Too Many Requests"]
                return [True, "Success"]
            except ValidationError as e:
                return [False, e.message]
        else:
            return [False, "Invalid Request"]
    else:
        return [False, "Invalid Request"]


def get_seller_request_status(user):
    for req in SellerRequest.objects.raw(
            'SELECT id, buyer_id, message FROM sell_sellerrequest WHERE buyer_id=%s', [user.id]):
        return req.message
    return "You Are Not A Verified Seller."


def get_all_seller_requests():
    pending = []
    for req in SellerRequest.objects.raw(
            'SELECT id, buyer_id, message FROM sell_sellerrequest WHERE LOWER(message)=%s', ["processing"]):
        pending.append({
            "req_id": str(req.id),
            "buyer_id": str(req.buyer_id),
            "message": req.message
        })
    return pending


def accept_seller_request(req_id):
    for req in SellerRequest.objects.raw(
            'SELECT id, buyer_id, message FROM sell_sellerrequest WHERE id=%s', [req_id]):
        make_seller(User.objects.get(id=req.buyer_id))
        delete_request_pdf_file(req.buyer_id)
        break
    with connection.cursor() as cursor:
        cursor.execute("""DELETE FROM sell_sellerrequest WHERE id=%s""", [req_id])


def reject_seller_request(req_id, message):
    for req in SellerRequest.objects.raw(
            'SELECT id, buyer_id, message FROM sell_sellerrequest WHERE id=%s', [req_id]):
        delete_request_pdf_file(req.buyer_id)
        break
    with connection.cursor() as cursor:
        cursor.execute("""UPDATE sell_sellerrequest SET message=%s WHERE id=%s""", [message, req_id])


def seller_request_exists(req_id):
    for req in SellerRequest.objects.raw(
            'SELECT id FROM sell_sellerrequest WHERE id=%s', [req_id]):
        return True
    return False
