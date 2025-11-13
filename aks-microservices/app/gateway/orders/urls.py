from django.urls import path
from .views import list_orders

urlpatterns = [
    path("", list_orders, name="list_orders"),
]