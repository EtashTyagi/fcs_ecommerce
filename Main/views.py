from django.shortcuts import render


def home(request):
    request.session.pop('login_to_continue_to', None)
    return render(request, 'pages/home.html')

all_views = {"home": home}