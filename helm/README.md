# Helm Chart Instructions #

> Note that this chart works only in GKE

## Generating The Chart ##

This chart and its subcharts were all created using:

`helm create <name-of-chart>`

## Installing With The Chart ##

### Without Packaging First ###

Run the following two commands:

`helm dependency build ./humans-logger-chart`

`helm install <your-name-for-chart> ./humans-logger-chart`

You can also have helm generate a random name for you with the command:

`helm install ./humans-logger-chart --generate-name`

### With Packaging First ###

To package the helm chart run the following two commands:

`helm dependency build ./humans-logger-chart`

`helm package ./humans-logger-chart`

To install the package run either of the following commands:

`helm install <your-name-for-chart> <name-of-package>`

`helm install <name-of-package> --generate-name`

## Uninstalling With The Chart ##

To uninstall the helm chart run the command:

`helm uninstall <name-of-chart>`

## Upgrading An Image With The Chart ##

If a subchart was edited then remember to run the following code before upgrading:

`helm dependency update ./humans-logger-chart`

### Upgrading With Subdirectory ###

To upgrade with the subdirectory humans-logger chart run the following command:

`helm upgrade <name-of-image> ./humans-logger-chart`

### Upgrading With Package ###

To upgrade with a package run the following command:

`helm upgrade <name-of-image> <name-of-package>`
