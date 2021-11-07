# IMPORTANT: PLEASE DO NOT USE FORMAT STRING IN RAW SQL QUERIES, IT WILL CAUSE SQL INJECTIONS
# https://docs.djangoproject.com/en/3.2/topics/db/sql/
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.models import User, Group
from django.db import connection

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
