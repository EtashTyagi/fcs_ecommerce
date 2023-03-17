# IMPORTANT: PLEASE DO NOT USE FORMAT STRING IN RAW SQL QUERIES, IT WILL CAUSE SQL INJECTIONS
# https://docs.djangoproject.com/en/3.2/topics/db/sql/
from datetime import datetime

from django.contrib.auth import logout
from django.contrib.auth.models import Group, User
from django.core.exceptions import ValidationError
from django.db import connection

from Main import settings
from sell.models import Seller_Request
from Utils.upload_handler import FileValidator, upload_request_pdf_file, delete_request_pdf_file

import uuid
from authentication.models import Unverified_User, Common_Passwords
from django.core.mail import send_mail


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
        auth_token = str(uuid.uuid4())
        unverified_user = Unverified_User.objects.create(user=created, auth_token=auth_token)
        unverified_user.save()
        send_mail_after_registration(email, auth_token)
        return [True, created]


# -----------------------------------------------------------------------------------------------------------


def send_mail_after_registration(email, token):
    subject = 'Please Verify Your Account'
    message = f"""Hey,\npaste the link in your browser or click on it to verify your account 
                    https://shop.etashtyagi.tk/verify/{token} \nthis is a system generated mail. Do not reply"""
    email_from = settings.EMAIL_HOST_USER
    recipient_list = [email]
    send_mail(subject, message, email_from, recipient_list)


def is_seller(user):
    return user.is_authenticated and user.groups.filter(name='seller').exists()


def is_buyer(user):
    return user.is_authenticated and user.groups.filter(name='buyer').exists()


def is_admin(user):
    if user.is_authenticated and (user.is_superuser or user.groups.filter(name='admin').exists()):
        return True
    return False


def make_seller(user):
    try:
        group = Group.objects.get(name="buyer")
        user.groups.remove(group)
    except Exception as ignore:
        print(ignore)
    group = Group.objects.get(name="seller")
    user.groups.add(group)


def make_buyer(user):
    try:
        group = Group.objects.get(name="seller")
        user.groups.remove(group)
    except Exception as ignore:
        print(ignore)
    group = Group.objects.get(name="buyer")
    user.groups.add(group)


def authenticate_user(request):
    username = request.POST["username"]
    password = request.POST["password"]

    try:
        user_identified = User.objects.get(username=username)
        if user_identified.check_password(password):
            user_identified.is_active = False
            return [True, None, user_identified.id]
        else:
            return [False, "Wrong Credentials"]

    except Exception as e:
        print(e)
        return [False, "Wrong Credentials"]


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
    return [isAlpha, None if isAlpha else "Name Can't have letters"]


def validate_email(email):
    name_domain = email.split("@")
    match = len(name_domain) == 2 and '.' in name_domain[1]
    if not match:
        return [False, "Invalid Email-ID"]
    try:
        User.objects.get(email=email)
        return [False, "Email Already Registered"]
    except Exception as ignore:
        return [True, None]


def validate_password(password, password_conf):
    if password != password_conf:
        return [False, "Passwords Don't Match"]
    elif len(password) < 8:
        return [False, "Password Too Small"]
    elif len(password) > 32:
        return [False, "Password Too Long"]
    elif Common_Passwords.objects.filter(password=password).exists():
        return [False, "Password Too Common"]

    return [True, None]


def validate_phone(phone_number):
    valid = len(str(phone_number)) == 10 and str(phone_number).isnumeric()
    return [valid, None if valid else "Invalid Phone Number"]


def add_phone_number(user_id, phone_number):
    with connection.cursor() as cursor:
        cursor.execute("INSERT INTO authentication_phone_number(user_id, phone_number) VALUES (%s, %s)",
                       [user_id, phone_number])


def get_phone_number(user):
    with connection.cursor() as cursor:
        cursor.execute("SELECT * FROM authentication_phone_number WHERE user_id=%s", [user.id])
        result_set = cursor.fetchall()
        for row in result_set:
            return row[1]


def update_phone_number(user, new_phone_number):
    validation = validate_phone(new_phone_number)
    if validation[0]:
        with connection.cursor() as cursor:
            cursor.execute("UPDATE authentication_phone_number SET phone_number=%s WHERE user_id=%s", [new_phone_number,
                                                                                                       user.id])
    return validation


def logout_user(request):
    if request.user.is_authenticated:
        logout(request)
        return True
    else:
        return False


def make_seller_request(request):
    if request.method == "POST" and not is_seller(request.user):
        processing = False
        for req in Seller_Request.objects.raw(
                'SELECT id FROM sell_seller_request WHERE buyer_id=%s AND LOWER(message)=%s',
                [request.user.id, "processing"]):
            processing = True
            break

        if processing:
            return [False, "Request Is Being Processed By Admin!"]
        elif "pdf" in request.FILES:
            file = request.FILES["pdf"]
            validator = FileValidator(max_size=1024 * 1024, content_types=("application/pdf",))
            try:
                validator(file)
                try:
                    upload_request_pdf_file(file, user_id=request.user.id)
                    if Seller_Request.objects.filter(buyer_id=request.user.id).exists():
                        with connection.cursor() as cursor:
                            cursor.execute("""UPDATE sell_seller_request SET message=%s WHERE buyer_id=%s""",
                                           ["Processing", str(request.user.id)])
                    else:
                        with connection.cursor() as cursor:
                            cursor.execute("""INSERT INTO sell_seller_request(buyer_id, message) VALUES (%s, %s)""",
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
    if user.is_authenticated and is_buyer(user):
        for req in Seller_Request.objects.raw(
                'SELECT id, buyer_id, message FROM sell_seller_request WHERE buyer_id=%s', [user.id]):
            return req.message
        return "You Are Not A Verified Seller."
    return "Bad Request"


def get_all_seller_requests_using(user):
    pending = []
    if user.is_superuser:
        for req in Seller_Request.objects.raw(
                'SELECT id, buyer_id, message FROM sell_seller_request WHERE LOWER(message)=%s', ["processing"]):
            pending.append({
                "req_id": str(req.id),
                "buyer_id": str(req.buyer_id),
                "message": req.message
            })
    elif is_admin(user):
        for req in Seller_Request.objects.raw(
                'SELECT id, buyer_id, message FROM sell_seller_request WHERE LOWER(message)=%s AND buyer_id!=%s',
                ["processing", user.id]):
            pending.append({
                "req_id": str(req.id),
                "buyer_id": str(req.buyer_id),
                "message": req.message
            })
    return pending


def accept_seller_request(req_id):
    for req in Seller_Request.objects.raw(
            'SELECT id, buyer_id, message FROM sell_seller_request WHERE id=%s', [req_id]):
        make_seller(User.objects.get(id=req.buyer_id))
        try:
            delete_request_pdf_file(req.buyer_id)
        except Exception as ignore:
            print(ignore)
        break
    with connection.cursor() as cursor:
        cursor.execute("""DELETE FROM sell_seller_request WHERE id=%s""", [req_id])


def reject_seller_request(req_id, message):
    for req in Seller_Request.objects.raw(
            'SELECT id, buyer_id, message FROM sell_seller_request WHERE id=%s', [req_id]):
        try:
            delete_request_pdf_file(req.buyer_id)
        except Exception as ignore:
            print(ignore)
        break
    with connection.cursor() as cursor:
        cursor.execute("""UPDATE sell_seller_request SET message=%s WHERE id=%s""", [message, req_id])


def seller_request_exists(req_id):
    for req in Seller_Request.objects.raw(
            'SELECT id FROM sell_seller_request WHERE id=%s', [req_id]):
        return True
    return False


# Time after which OTP will expire
EXPIRY_TIME = 120  # seconds


def generate_key(random_string):
    return str(datetime.date(datetime.now())) + random_string
