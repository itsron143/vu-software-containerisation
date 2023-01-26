#!/bin/bash

echo "Creating the volume..."

microk8s kubectl apply -f postgres-config.yaml

echo "checking if /opt/postgres/data is created or not..."
if [ -d /opt/postgres/data ]; then
  echo "/opt/postgres/data does exist."
else
  echo "creating /opt/postgres/data ..."
  sudo mkdir -p /opt/postgres/data
fi

microk8s kubectl apply -f postgres-storage.yaml

echo "Creating the database credentials..."

microk8s kubectl apply -f ./kubernetes/postgres/postgres-secret.yml

echo "Creating the postgres deployment and service..."

microk8s kubectl create -f ./kubernetes/postgres/postgres-deployment.yml
microk8s kubectl create -f ./kubernetes/postgres/postgres-service.yml

echo "Waiting for postgres..."

while ! nc -z postgres 5432; do
  sleep 0.1
done

echo "PostgreSQL started"

echo "Creating the flask deployment and service..."

microk8s kubectl create -f ./kubernetes/flask/flask-deployment.yml
microk8s kubectl create -f ./kubernetes/flask/flask-service.yml


# echo "Adding the ingress..."

# minikube addons enable ingress
# kubectl delete -A ValidatingWebhookConfiguration ingress-nginx-admission
# kubectl apply -f ./kubernetes/minikube-ingress.yml