FROM python:3.8-slim

WORKDIR /app

COPY requirements.txt requirements.txt

RUN apt-get update && \
    apt-get install -y libmariadb-dev build-essential && \
    apt-get install -y pkg-config && \
    pip install -r requirements.txt

COPY . .

CMD ["python", "app.py"]

