#!/bin/bash

microk8s kubectl delete all --all --all-namespaces
microk8s kubectl delete pvc --all