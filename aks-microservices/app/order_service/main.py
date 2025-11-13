from fastapi import FastAPI
from pydantic import BaseModel
import requests

app = FastAPI(title="Order Service")

class Order(BaseModel):
    id: int
    user_id: int
    item: str

orders = []

# URL of the User Service (adjust for your deployment)
USER_SERVICE_URL = "http://user-service:8000/users"

@app.post("/orders")
def create_order(order: Order):
    # Validate user exists by calling User Service
    try:
        resp = requests.get(USER_SERVICE_URL)
        users = resp.json()
        if not any(u["id"] == order.user_id for u in users):
            return {"error": "User not found"}
    except Exception as e:
        return {"error": f"User service unavailable: {e}"}

    orders.append(order)
    return {"message": "Order created", "order": order}

@app.get("/orders")
def list_orders():
    return orders

@app.get("/health")
def health():
    return {"status": "ok"}