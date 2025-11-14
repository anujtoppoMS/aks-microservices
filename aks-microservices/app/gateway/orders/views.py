import requests
from django.shortcuts import render

ORDER_SERVICE = "http://order-service:8002/orders"

def list_orders(request):
    resp = requests.get(ORDER_SERVICE)
    orders = resp.json()
    return render(request, "orders/list.html", {"orders": orders})