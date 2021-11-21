from django.http import HttpResponse
from django.http import JsonResponse
from Utils.item_handler import *

""" Define All HTML Views To Render Here in all_views list with appropriate name"""
""" View Format (Follow Strictly !!!!):
        0. Handle invalid requests (eg in item.)
        1. Handle tasks dependent on auth of user (only authed user can do some tasks)
        2. Handle permissions (only seller can sell)
        3. Handle GET request
        4. Handle POST request
        5. Else return HttpResponse("<h1>Error</h1><p>Bad Request</p>")
        6. When combined (POST and must be authed), handle auth inside the request type block !!
        7. After change to database using POST 'ALWAYS' redirect !!!
"""


def search(request):
    MAX_RES = 10
    if request.method == "GET":
        payload = []
        if len(request.GET) == 1 and ("sc" in request.GET or "c" in request.GET or "q" in request.GET) \
                or len(request.GET) == 2 and ("c" in request.GET and "q" in request.GET):
            if "sc" in request.GET:
                payload = fetchCategories()
            else:
                payload = fetchItems(request, search_in=["title"], limit=MAX_RES)
            return JsonResponse({'status': 200, 'data': payload[0:min(MAX_RES, len(payload))]})
        else:
            return HttpResponse("<h1>Error</h1><p>Invalid Parameters!</p>")
    else:
        return HttpResponse("<h1>Error</h1><p>Bad Request, only GET allowed!</p>")


all_views = {
    "search": search
}
