FROM python:3.11-alpine
ENV PYTHONUNBUFFERED 1

WORKDIR /app

# Встановлюємо системні пакети, які потрібні завжди
RUN apk add --update --no-cache \
    postgresql-client \
    jpeg-dev \
    zlib-dev \
    libpq

# Встановлюємо пакети для збірки ТИМЧАСОВО
RUN apk add --update --no-cache --virtual .tmp-build-deps \
    gcc \
    libc-dev \
    linux-headers \
    postgresql-dev \
    musl-dev \
    zlib-dev

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# ВИДАЛЯЄМО тимчасові пакети (це звільнить сотні МБ всередині образу)
RUN apk del .tmp-build-deps

COPY . .

RUN mkdir -p /vol/web/media /vol/web/static