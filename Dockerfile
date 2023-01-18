FROM python:3.8.0-slim
RUN apt-get update
RUN apt-get install -y libpq-dev python3-dev python-dev libevent-dev postgresql-client
RUN mkdir /pushups_logger
WORKDIR /pushups_logger
COPY . /pushups_logger
RUN pip install -U pip
RUN pip install --no-cache-dir -r requirements.txt
EXPOSE 5001