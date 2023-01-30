# Helm chart instructions #

## Running helm chart ##

Run the following two commands:

`sudo microk8s helm3 dependency update ./pushups-logger-chart`
`sudo microk8s helm3 install <your-name-for-chart> ./pushups-logger-chart`

You can also have helm generate a random name for you with the command:

`sudo microk8s helm3 install ./pushups-logger-chart --generate-name`

## Stopping helm chart ##

To stop the helm chart run the command:

`sudo microk8s helm3 uninstall <name-of-chart>`
