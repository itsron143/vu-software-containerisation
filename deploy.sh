#!/bin/bash

echo "Enable microk8s DNS"
microk8s enable dns

echo "Setting postgres config..."

microk8s kubectl apply -f ./kubernetes/postgres/postgres-config.yaml

echo "Creating the database credentials..."
microk8s kubectl apply -f ./kubernetes/postgres/postgres-secret.yaml

echo "Creating the volume..."

echo "checking if /opt/postgres/data is created or not..."
if [ -d /opt/postgres/data ]; then
  echo "/opt/postgres/data does exist, removing it..."
  sudo rm -rf /opt/postgres/data
fi

echo "creating /opt/postgres/data ..."
sudo mkdir -p /opt/postgres/data

microk8s kubectl apply -f ./kubernetes/postgres/postgres-storage.yaml

echo "Creating the postgres deployment and service..."
microk8s kubectl create -f ./kubernetes/postgres/postgres-deployment.yaml
microk8s kubectl create -f ./kubernetes/postgres/postgres-service.yaml

echo "waiting 5 seconds for postgres to start..."
sleep 5

echo "Check pods info to see if postgres has begun.."
microk8s kubectl get pods

echo "Creating the flask deployment and service..."
microk8s kubectl create -f ./kubernetes/flask/flask-deployment.yaml
microk8s kubectl create -f ./kubernetes/flask/flask-service.yaml

echo "Waiting 5 seconds for pushups-logger to start..."
sleep 5

echo "Check pods again to see if pushups-logger pod is running..."
microk8s kubectl get pods
