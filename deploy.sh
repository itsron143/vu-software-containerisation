#!/bin/bash

echo "Setting postgres config..."

microk8s kubectl apply -f ./kubernetes/postgres/postgres-config.yaml

echo "Creating the volume..."

echo "checking if /opt/postgres/data is created or not..."
if [ -d /opt/postgres/data ]; then
  echo "/opt/postgres/data does exist, removing it..."
  sudo rm -rf /opt/postgres/data
fi

echo "creating /opt/postgres/data ..."
sudo mkdir -p /opt/postgres/data

microk8s kubectl apply -f ./kubernetes/postgres/postgres-storage.yaml

echo "Creating the database credentials..."
microk8s kubectl apply -f ./kubernetes/postgres/postgres-secret.yaml

echo "Creating the postgres deployment and service..."
microk8s kubectl create -f ./kubernetes/postgres/postgres-deployment.yaml
microk8s kubectl create -f ./kubernetes/postgres/postgres-service.yaml

# while ! nc -z postgres 5432; do
#   sleep 0.1
# done

echo "waiting 10 seconds for postgres to start..."
sleep 10

echo "Check pods info to see if postgres has begun.."
microk8s kubectl get pods

echo "Creating the flask deployment and service..."
microk8s kubectl create -f ./kubernetes/flask/flask-deployment.yaml
microk8s kubectl create -f ./kubernetes/flask/flask-service.yaml


# echo "Adding the ingress..."

# minikube addons enable ingress
# kubectl delete -A ValidatingWebhookConfiguration ingress-nginx-admission
# kubectl apply -f ./kubernetes/minikube-ingress.yml