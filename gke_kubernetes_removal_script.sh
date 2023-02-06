#!/bin/bash

kubectl delete pod --all
kubectl delete --all deployments
kubectl delete pvc --all
kubectl delete pv --all
kubectl delete svc postgres
kubectl delete svc rest-api
kubectl delete svc web-frontend
kubectl delete ing web-ingress
kubectl delete ing flask-ingress
kubectl delete ns sandbox
kubectl delete clusterissuer selfsigned-issuer
# The line below is only needed if you want to use the issuer
# kubectl delete issuer my-ca-issuer
kubectl delete networkpolicy restrict-postgres-access   
kubectl delete networkpolicy allow-rest-api-to-postgres
kubectl delete networkpolicy allow-web-frontend-to-rest-api
kubectl delete role pod-reader
kubectl delete rolebinding read-pods
kubectl delete role pv-controller 
kubectl delete rolebinding pv-control-rolebinding 
