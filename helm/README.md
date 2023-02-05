# Helm Chart Instructions #

> The microk8s ingress controller can cause issues. If it does then we recommend considering installing the ingress controller using helm instead of enabling ingress in microk8s.

> Note that all the commands are made to be run from this directory and may not work in other directories.

## Generating The Chart ##

This chart and its subcharts were all created using:

`sudo microk8s helm3 create <name-of-chart>`

## Installing With The Chart ##

### Without Packaging First ###

Run the following two commands:

`sudo microk8s helm3 dependency build ./humans-logger-chart`

`sudo microk8s helm3 install <your-name-for-chart> ./humans-logger-chart`

You can also have helm generate a random name for you with the command:

`sudo microk8s helm3 install ./humans-logger-chart --generate-name`

### With Packaging First ###

To package the helm chart run the following two commands:

`sudo microk8s helm3 dependency build ./humans-logger-chart`

`sudo microk8s helm3 package ./humans-logger-chart`

To install the package run either of the following commands:

`sudo microk8s helm3 install <your-name-for-chart> <name-of-package>`

`sudo microk8s helm3 install <name-of-package> --generate-name`

## Uninstalling With The Chart ##

To uninstall the helm chart run the command:

`sudo microk8s helm3 uninstall <name-of-chart>`

## Upgrading An Image With The Chart ##

If a subchart was edited then remember to run the following code before upgrading:

`sudo microk8s helm3 dependency update ./humans-logger-chart`

### Upgrading With Subdirectory ###

To upgrade with the subdirectory humans-logger chart run the following command:

`sudo microk8s helm3 upgrade <name-of-image> ./humans-logger-chart`

### Upgrading With Package ###

To upgrade with a package run the following command:

`sudo microk8s helm3 upgrade <name-of-image> <name-of-package>`
