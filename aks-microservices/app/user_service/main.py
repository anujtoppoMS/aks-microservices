from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI(title="User Service")

class User(BaseModel):
    id: int
    name: str

users = []

@app.post("/users")
def create_user(user: User):
    users.append(user)
    return user

@app.get("/users")
def list_users():
    return users

@app.get("/health")
def health():
    return {"status": "ok"}