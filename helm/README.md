# Helm Chart Instructions #

## Running Helm Chart ##

Run the following two commands:

`sudo microk8s helm3 dependency update ./pushups-logger-chart`

`sudo microk8s helm3 install <your-name-for-chart> ./pushups-logger-chart`

You can also have helm generate a random name for you with the command:

`sudo microk8s helm3 install ./pushups-logger-chart --generate-name`

## Stopping Helm Chart ##

To stop the helm chart run the command:

`sudo microk8s helm3 uninstall <name-of-chart>`

## Authentication Error When Connecting To Postgres ##

There may be two different reasons for this:

- Either the pv or pvc or both are already in use. Then you need to use kubectl to delete them or change their names.

- The storage path directory /opt/helm-postgresql/data already contains data. Then you need to delete the directory or change the storage path.
