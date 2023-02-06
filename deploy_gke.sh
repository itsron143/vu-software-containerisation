#!/bin/bash


echo "Setting postgres config..."

kubectl apply -f ./kubernetes/postgres/postgres-config.yaml

echo "Creating the database credentials..."
kubectl apply -f ./kubernetes/postgres/postgres-secret.yaml

echo "Creating the volume..."

kubectl apply -f ./kubernetes/postgres/postgres-storage.yaml

echo "Creating the postgres deployment and service..."
kubectl apply -f ./kubernetes/postgres/postgres-deployment.yaml
kubectl apply -f ./kubernetes/postgres/postgres-service.yaml

echo "waiting 10 seconds for postgres to start..."
sleep 10

echo "Check pods info to see if postgres has begun.."
kubectl get pods

echo "Creating the database networkpolicy..."
kubectl apply -f ./kubernetes/postgres/postgres-network-policy.yaml

echo "Creating the role for pods..."
kubectl apply -f ./kubernetes/roles/pod-role.yaml

echo "Creating the binding role for pods..."
kubectl apply -f ./kubernetes/roles/pod-role-binding.yaml


echo "Creating the role for volumes..."
kubectl apply -f ./kubernetes/roles/volumes-role.yaml

echo "Creating the binding role for volumes..."
kubectl apply -f ./kubernetes/roles/volumes-role-binding.yaml

echo "Creating the role for secrets..."
kubectl apply -f ./kubernetes/roles/secrets-role.yaml

echo "Creating the binding role for secrets..."
kubectl apply -f ./kubernetes/roles/secrets-role-binding.yaml

echo "Creating the flask deployment and service..."
kubectl create -f ./kubernetes/flask/flask-deployment.yaml
kubectl create -f ./kubernetes/flask/flask-service.yaml
kubectl create -f ./kubernetes/flask/flask-network-policy.yaml
kubectl create -f ./kubernetes/flask/flask-ingress.yaml

echo "Waiting 10 secs for flask to begin..."
sleep 10

echo "Check pods again to see if rest-api pod is running..."
kubectl get pods

echo "Creating web-frontend deployment and service..."
kubectl apply -f ./kubernetes/web-frontend/web-frontend-managed-cert.yaml
kubectl apply -f ./kubernetes/web-frontend/web-deployment.yaml
kubectl apply -f ./kubernetes/web-frontend/web-service.yaml
kubectl apply -f ./kubernetes/web-frontend/web-network-policy.yaml
kubectl apply -f ./kubernetes/web-frontend/web-ingress.yaml

echo "Wait for web-frontend pods to show up..."
sleep 10

echo "Check pods again to see if web-frontend pod is running..."
kubectl get pods