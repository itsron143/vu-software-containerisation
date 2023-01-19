FROM python:3.8-alpine
RUN apk update && \
    apk add --virtual build-deps gcc musl-dev && \
    apk add postgresql-dev && \
    rm -rf /var/cache/apk/*
RUN mkdir /pushups_logger
WORKDIR /pushups_logger
COPY . /pushups_logger
RUN pip install -U pip
RUN pip install --no-cache-dir -r requirements.txt
EXPOSE 5001