from django.contrib.auth.models import User


def create_user(request):
    username = request.POST["username"]
    first_name = request.POST["first_name"]
    last_name = request.POST["last_name"]
    email = request.POST["email"]
    password = request.POST["password"]
    conf_password = request.POST["conf_password"]
    phone = request.POST["phone"]
    # Security Handle Here, return [True, user] if created [False, error statement] if error
    # User.objects.create_user()
    return [False, "Create User Not Implemented"]


def authenticate_user(request):
    username = request.POST["username"]
    password = request.POST["password"]
    # Security Handle Here, return [True, user] if success [False, error statement] if un success
    return [False, "Auth Not Implemented"]
