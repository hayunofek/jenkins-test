FROM python:3.9-slim-buster

WORKDIR /app
ADD main.py /app

ENTRYPOINT ["python3", "/app/main.py"]


