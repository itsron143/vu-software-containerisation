#!/bin/bash

docker-compose stop
docker-compose rm
docker rmi $(docker images)
docker volume rm flask-app-db
