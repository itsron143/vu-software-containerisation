# Software Containerisation (Group 49)

Project space for Software Containerisation, VU Amsterdam.

### Description

The repository houses all the source files for running the web application using microk8s and Google Kubernetes Engine. The following explains the usage of each directory:

- `kubernetes`: Includes the manifests used to deploy `postgres`, `rest-api` and `web-frontend` on microk8s and GKE.
- `helm`: Includes the helm charts to run the application using `helm` (see helm/README.md to run the helm instructions).
- `rest-api`: Includes the source files to create the REST-API server. (also available as a docker image: `itsron143/rest-api:latest`)
- `web-frontend`: Includes the source file to create the frontend NGINX sercer. (also available as a docker image: `itsron143/web-frontend:latest`)

`deploy.sh` can be used to deploy the application from scratch using `microk8s`.

`deploy_gke.sh` can be used to deploy the application from scratch on GKE.

### Commands (Shown in the presentation)

> NOTE: The presentation is shown on GKE.

- Building Docker Images and Publishing to a Registry:
  First, we build and push the rest-api images to the registry:

  `cd rest-api` (from root directory)

  `sudo docker build -t itsron143/rest-api:latest .`

  `sudo docker push itsron143/rest-api:latest`

  Then, we build and push the web-frontend images to the registry:

  `cd web-frontend` (from root directory)

  `sudo docker build -t itsron143/web-frontend:latest .`

  `sudo docker push itsron143/web-frontend:latest`

- Deploying the Application for the first time (on GKE):

  `sudo ./deploy_gke.sh`

- Pre-requisites configuration:
  `kubectl describe ingress managed-cert`: Shows the load balancer used.

  `kubectl get storageclass`: Shows the storage class (Can also be seen using `kubectl get pv`).

  `kubectl describe managedcertificates managed-cert`: Shows the certificate.

  `kubectl get networkpolicies`: Shows the network policies.

  `kubectl get roles`: Shows the roles.

- Scaling the stateless application:
  `kubectl scale --replicas=3 deployment web-frontend`: Scales the web-frontend from 1 to 3 replicas.

- Install, Upgrade and Uninstall the application using Helm:
  `cd helm`

  `helm package humans-logger-chart`: Packages the `humans-logger-chart` helm chart.

  `helm install hl ./humans-logger-chart-1.0.0.tgz`: Installs the application.

  `helm ls`: To show version 1.0.0 installed.

  `nano humans-logger-chart/Chart.yaml`: Change the version number to `2.0.0` here `version: 1.0.0`.

  `helm upgrade hl ./humans-logger-chart-2.0.0.tgz`: Upgrades the application to 2.0.0.

  `helm ls`: To show the upgraded 2.0.0 version.

  `helm uninstall hl`: To uninstall the application.

  `helm ls`: To show the application has been uninstalled.

- Deployment Rollout:
  For deployment rollout:

  `kubectl edit deployment/rest-api`: Update `terminationGracePeriodSeconds: 30` to 60.

  The output is similar to `deployment.apps/rest-api edited`.

  To see the rollout status:

  `kubectl rollout status deployment/rest-api`

  The deployment rollout can be checked by seeing the new pods created using: `kubectl get pods`
