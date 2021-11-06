from django.shortcuts import render


def home(request):
    return render(request, 'pages/home.html')

all_views = {"home": home}