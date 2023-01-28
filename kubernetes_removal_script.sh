#!/bin/bash

microk8s kubectl delete pod --all
microk8s kubectl delete --all deployments
microk8s kubectl delete pvc --all
microk8s kubectl delete pv --all
microk8s kubectl delete svc postgres
microk8s kubectl delete svc pushups-logger
