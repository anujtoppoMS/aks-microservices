import requests
from django.shortcuts import render

USER_SERVICE = "http://user-service:8001/users"

def list_users(request):
    resp = requests.get(USER_SERVICE)
    users = resp.json()
    return render(request, "users/list.html", {"users": users})