FROM python:3.11-slim
WORKDIR /app
COPY . .
RUN pip install django requests gunicorn django-prometheus
CMD ["gunicorn", "gateway.wsgi:application", "--bind", "0.0.0.0:8000"]