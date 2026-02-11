FROM python:3.11-alpine
ENV PYTHONUNBUFFERED 1

WORKDIR /app

# Встановлюємо системні залежності
RUN apk add --update --no-cache \
    postgresql-client \
    jpeg-dev \
    zlib-dev \
    libjpeg-turbo-dev \
    libpq-dev \
    gcc \
    libc-dev \
    linux-headers \
    postgresql-dev \
    musl-dev

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

RUN mkdir -p /vol/web/media /vol/web/static