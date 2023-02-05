#!/bin/bash

microk8s kubectl delete pod --all
microk8s kubectl delete --all deployments
microk8s kubectl delete pvc --all
microk8s kubectl delete pv --all
microk8s kubectl delete svc postgres
microk8s kubectl delete svc rest-api
microk8s kubectl delete svc web-frontend
microk8s kubectl delete networkpolicy restrict-postgres-access   
microk8s kubectl delete networkpolicy allow-rest-api-to-postgres
microk8s kubectl delete networkpolicy allow-web-frontend-to-rest-api
microk8s kubectl delete role pod-reader
microk8s kubectl delete rolebinding read-pods
microk8s kubectl delete role pv-controller 
microk8s kubectl delete rolebinding pv-control-rolebinding  
microk8s kubectl delete ing web-ingress
microk8s kubectl delete ing flask-ingress
microk8s kubectl delete ns sandbox
microk8s kubectl delete clusterissuer selfsigned-issuer
# The line below is only needed if you want to use the issuer
# microk8s kubectl delete issuer my-ca-issuer
