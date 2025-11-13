from django.db import models

class Order(models.Model):
    id = models.IntegerField(primary_key=True)
    user_id = models.IntegerField()
    item = models.CharField(max_length=100)

    def __str__(self):
        return f"Order {self.id} for user {self.user_id}"