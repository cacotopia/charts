# sentinel-dashboard

alibaba sentinel dashboard for k8s.

## Install

Install with Helm 3:

```bash
helm repo add cacotopia https://cacotopia.github.io/charts/

helm install msentinel-dashboard cacotopia/sentinel-dashboard
```

## Uninstall

```bash
$ helm delete kruise
release "kruise" uninstalled
```

## Configuration

The following table lists the configurable parameters of the kruise chart and their default values.

| Parameter                                 | Description                                                  | Default                       |
| ----------------------------------------- | ------------------------------------------------------------ | ----------------------------- |