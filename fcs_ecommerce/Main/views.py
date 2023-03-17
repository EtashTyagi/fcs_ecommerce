from django.http import Http404
from django.shortcuts import render


def home(request):
    request.session.pop('login_to_continue_to', None)
    if len(request.POST) > 0 or len(request.GET) > 0 or request.method == "POST":
        return Http404("Wrong Request")
    return render(request, 'pages/home.html')


all_views = {"home": home}
