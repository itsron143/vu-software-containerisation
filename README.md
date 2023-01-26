# Software Containerisation

Project space for Software Containerisation, VU Amsterdam.

# Kubernetes Deployment Instructions

> make sure you have docker and microk8s installed on your vm.

Start microk8s and enable `DNS`:

```bash
microk8s start; microk8s enable dns;
```

```bash
sudo ./deploy.sh
```

If the above script runs successfully, check if pods are running:
```bash
microk8s kubectl get pods
```

If both the `postgres-deployment` and `pushups-logger` pods have the 
`STATUS` as `Running` then the web app should be avaialble at 
`http://localhost:5001`
