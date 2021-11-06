from django.shortcuts import render

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
# TODO: Track number of requests for a session, timeout if > N reqs/sec


# TODO: Extremely important, validate if can checkout (stock, positive items, ....)
def checkout(request):
    return render(request, 'pages/checkout.html')

all_views = {
    "checkout": checkout
}
