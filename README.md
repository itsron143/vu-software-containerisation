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
