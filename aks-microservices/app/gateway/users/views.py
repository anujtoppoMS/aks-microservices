import requests
from django.shortcuts import render
from django.http import HttpResponse

USER_SERVICE = "http://user-service:8001/users"

def list_users(request):
    resp = requests.get(USER_SERVICE)
    users = resp.json()
    return render(request, "users/list.html", {"users": users})

def index(request):
    return HttpResponse("<h1>Welcome to My Django App</h1><p>This is the index page.</p>")