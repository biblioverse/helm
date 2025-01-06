# Biblioteca Helm Chart

[Biblioteca](https://biblioverse.github.io/biblioteca/) is a web application created to manage your personal library. This is an alternative to Calibre and other similar software.

## TL;DR;

```console
helm repo add biblioverse https://biblioverse.github.io/helm/
helm install my-release biblioverse/biblioteca
```

## Quick Links

- [Introduction](#introduction)
- [Prerequisites](#prerequisites)
- [Installing the Chart](#installing-the-chart)
- [Uninstalling the Chart](#uninstalling-the-chart)
- [Configuration](#configuration)
  - [Database Configurations](#database-configurations)
  - [Probes Configurations](#probes-configurations)

## Introduction

This chart bootstraps a Biblioteca deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

You will also need a database compatible with Biblioteca. For more info, please see the [Database Configuration](#database-configurations) section below.

If you want to persist data accross installs and upgrades, you'll need to configure persistence. For more info, please see the [Persistence Configuration](#persistence-configurations) section below.

We also package the following helm charts from Bitnami for you to _optionally_ use:

| Chart                                                                  | Descrption                      |
| ---------------------------------------------------------------------- | ------------------------------- |
| [MariaDB](https://github.com/bitnami/charts/tree/main/bitnami/mariadb) | For use as an external database |

## Prerequisites

- Kubernetes 1.24+
- Persistent Volume provisioner support in the underlying infrastructure
- Helm >=3.7.0 (for subchart scope exposing)

## Installing the Chart

To install the chart with the release name `my-release`:

```console
helm repo add biblioverse https://biblioverse.github.io/helm/
helm install my-release biblioverse/biblioteca
```

The command deploys Biblioteca on the Kubernetes cluster in the default configuration.
The [configuration](#configuration) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```console
helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following table lists the configurable parameters of the Biblioteca chart and their default values.

| Parameter                                         | Description                                                                             | Default                                    |
| ------------------------------------------------- | --------------------------------------------------------------------------------------- | ------------------------------------------ |
| `image.repository`                                | biblioteca Image name                                                                   | `ghcr.io/biblioverse/biblioteca-docker`    |
| `image.tag`                                       | biblioteca Image tag                                                                    | `appVersion`                               |
| `image.pullPolicy`                                | Image pull policy                                                                       | `IfNotPresent`                             |
| `image.pullSecrets`                               | Specify image pull secrets                                                              | `nil`                                      |
| `replicaCount`                                    | Number of biblioteca pods to deploy                                                     | `1`                                        |
| `ingress.className`                               | Name of the ingress class to use                                                        | `nil`                                      |
| `ingress.host`                                    | Host Ingress                                                                            | `nil`                                      |
| `ingress.enabled`                                 | Enable use of ingress controllers                                                       | `false`                                    |
| `ingress.servicePort`                             | Ingress' backend servicePort                                                            | `http`                                     |
| `ingress.annotations`                             | An array of service annotations                                                         | `nil`                                      |
| `ingress.labels`                                  | An array of service labels                                                              | `nil`                                      |
| `ingress.path`                                    | The `Path` to use in Ingress' `paths`                                                   | `/`                                        |
| `ingress.pathType`                                | The `PathType` to use in Ingress' `paths`                                               | `Prefix`                                   |
| `ingress.tls`                                     | Ingress TLS configuration                                                               | `[]`                                       |
| `biblioteca.update`                               | Trigger update if custom command is used                                                | `0`                                        |
| `biblioteca.containerPort`                        | Customize container port when not running as root                                       | `80`                                       |
| `biblioteca.strategy`                             | specifies the strategy used to replace old Pods by new ones                             | `type: Recreate`                           |
| `biblioteca.mailerDSN`                            |                                                                                         | `native://default`                         |
| `biblioteca.messengerTransportDSN`                |                                                                                         | `doctrine://default?auto_setup=0`          |
| `biblioteca.bookFolderNamingFormat`               |                                                                                         | `"{authorFirst}/{author}/{title}/{serie}"` |
| `biblioteca.bookFileNamingFormat`                 |                                                                                         | `"{serie}-{serieIndex}-{title}"`           |
| `biblioteca.extraEnv`                             | specify additional environment variables                                                | `{}`                                       |
| `biblioteca.extraSidecarContainers`               | specify additional sidecar containers                                                   | `[]`                                       |
| `biblioteca.extraInitContainers`                  | specify additional init containers                                                      | `[]`                                       |
| `biblioteca.extraVolumes`                         | specify additional volumes for the Biblioteca pod                                       | `{}`                                       |
| `biblioteca.extraVolumeMounts`                    | specify additional volume mounts for the Biblioteca pod                                 | `{}`                                       |
| `biblioteca.mariaDbInitContainer.resources`       | set the `resources` field of the MariaDB init container in the Biblioteca Pod.          | `{}`                                       |
| `biblioteca.mariaDbInitContainer.securityContext` | set the `securityContext` field of the MariaDB init container in the Biblioteca Pod.    | `{}`                                       |
| `biblioteca.securityContext`                      | Optional security context for the Biblioteca container                                  | `nil`                                      |
| `biblioteca.podSecurityContext`                   | Optional security context for the Biblioteca pod (applies to all containers in the pod) | `nil`                                      |
| `lifecycle.postStartCommand`                      | Specify deployment lifecycle hook postStartCommand                                      | `nil`                                      |
| `lifecycle.preStopCommand`                        | Specify deployment lifecycle hook preStopCommand                                        | `nil`                                      |
| `service.type`                                    | Kubernetes Service type                                                                 | `ClusterIP`                                |
| `service.loadBalancerIP`                          | LoadBalancerIp for service type LoadBalancer                                            | `""`                                       |
| `service.annotations`                             | Annotations for service type                                                            | `{}`                                       |
| `service.nodePort`                                | NodePort for service type NodePort                                                      | `nil`                                      |
| `service.ipFamilies`                              | Set ipFamilies as in k8s service objects                                                | `nil`                                      |
| `service.ipFamyPolicy`                            | define IP protocol bindings as in k8s service objects                                   | `nil`                                      |
| `resources`                                       | CPU/Memory resource requests/limits                                                     | `{}`                                       |
| `deploymentLabels`                                | Labels to be added at 'deployment' level                                                | not set                                    |
| `deploymentAnnotations`                           | Annotations to be added at 'deployment' level                                           | not set                                    |
| `podLabels`                                       | Labels to be added at 'pod' level                                                       | not set                                    |
| `podAnnotations`                                  | Annotations to be added at 'pod' level                                                  | not set                                    |
| `dnsConfig`                                       | Custom dnsConfig for biblioteca containers                                              | `{}`                                       |

### Database Configurations

Biblioteca needs a MySQL or MariaDB database.
You can either bring your own database or benefit from the embedded [Bitnami MariaDB chart](https://github.com/bitnami/charts/tree/main/bitnami/mariadb)

If you choose to use the prepackaged Bitnami helm charts, you must configure both the `externalDatabase` parameters, and the parameters for the chart you choose.

For instance, if you choose to use the Bitnami PostgreSQL chart that we've prepackaged, you need to also configure all the parameters for `postgresql`.
You do not need to use the Bitnami helm charts.
If you want to use an already configured database that you have externally, just configure the `externalDatabase` parameters below.

| Parameter                                    | Description                                                                       | Default           |
| -------------------------------------------- | --------------------------------------------------------------------------------- | ----------------- |
| `externalDatabase.enabled`                   | Whether to use external database                                                  | `false`           |
| `externalDatabase.url`                       | URL to the external DB. Example: `"mysql://user:pass@host/db"`                    | `""`              |
| `externalDatabase.existingSecret.enabled`    | Whether to use a existing secret or not                                           | `false`           |
| `externalDatabase.existingSecret.secretName` | Name of the existing secret                                                       | `nil`             |
| `externalDatabase.existingSecret.urlKey`     | Name of the key that contains the DB URL                                          | `url`             |
| `mariadb.enabled`                            | Whether to use the MariaDB chart                                                  | `false`           |
| `mariadb.auth.database`                      | Database name to create                                                           | `biblioteca`      |
| `mariadb.auth.username`                      | Database user to create                                                           | `biblioteca`      |
| `mariadb.auth.password`                      | Password for the database                                                         | `changeme`        |
| `mariadb.auth.rootPassword`                  | MariaDB admin password                                                            | `nil`             |
| `mariadb.auth.existingSecret`                | Use existing secret for MariaDB password details; see values.yaml for more detail | `''`              |
| `mariadb.image.registry`                     | MariaDB image registry                                                            | `docker.io`       |
| `mariadb.image.repository`                   | MariaDB image repository                                                          | `bitnami/mariadb` |
| `mariadb.image.tag`                          | MariaDB image tag                                                                 | ``                |
| `mariadb.global.defaultStorageClass`         | MariaDB Global default StorageClass for Persistent Volume(s)                      | `''`              |
| `mariadb.primary.persistence.enabled`        | Whether or not to Use a PVC on MariaDB primary                                    | `false`           |
| `mariadb.primary.persistence.storageClass`   | MariaDB primary persistent volume storage Class                                   | `''`              |
| `mariadb.primary.persistence.existingClaim`  | Use an existing PVC for MariaDB primary                                           | `''`              |

Is there a missing parameter for one of the Bitnami helm charts listed above? Please feel free to submit a PR to add that parameter in our values.yaml, but be sure to also update this README file :)

### Persistence Configurations

The Biblioteca image stores its data at the `/var/www/html` paths of the container.
Persistent Volume Claims are used to keep the data across deployments. This is known to work with GKE, EKS, K3s, and minikube.
Biblioteca will _not_ delete the PVCs when uninstalling the helm chart.

Three paths are used:

- `/var/www/html/public/books`: For your books, this should be persisted, configured by the `persistence` key
- `/var/www/html/public/covers`: Extracted covers of your books, configured by the `persistenceTmpCovers` key
- `/var/www/html/public/media`: Extracted pages of your books, configured by the `persistenceTmpCovers` key

| Parameter                            | Description                         | Default                                     |
| ------------------------------------ | ----------------------------------- | ------------------------------------------- |
| `persistence.enabled`                | Enable persistence using PVC        | `false`                                     |
| `persistence.annotations`            | PVC annotations                     | `{}`                                        |
| `persistence.storageClass`           | PVC Storage Class for the volume    | `nil` (uses alpha storage class annotation) |
| `persistence.existingClaim`          | An Existing PVC name for the volume | `nil` (uses alpha storage class annotation) |
| `persistence.accessMode`             | PVC Access Mode for the volume      | `ReadWriteOnce`                             |
| `persistence.size`                   | PVC Storage Request for the volume  | `10Gi`                                      |
| `persistenceTmpCovers.enabled`       | Create a PVC for book covers        | `false`                                     |
| `persistenceTmpCovers.annotations`   | see `persistence.annotations`       | `{}`                                        |
| `persistenceTmpCovers.storageClass`  | see `persistence.storageClass`      | `nil` (uses alpha storage class annotation) |
| `persistenceTmpCovers.existingClaim` | see `persistence.existingClaim`     | `nil` (uses alpha storage class annotation) |
| `persistenceTmpCovers.accessMode`    | see `persistence.accessMode`        | `ReadWriteOnce`                             |
| `persistenceTmpCovers.size`          | see `persistence.size`              | `5Gi`                                       |
| `persistenceTmpMedia.enabled`        | Create a PVC for media files        | `false`                                     |
| `persistenceTmpMedia.annotations`    | see `persistence.annotations`       | `{}`                                        |
| `persistenceTmpMedia.storageClass`   | see `persistence.storageClass`      | `nil` (uses alpha storage class annotation) |
| `persistenceTmpMedia.existingClaim`  | see `persistence.existingClaim`     | `nil` (uses alpha storage class annotation) |
| `persistenceTmpMedia.accessMode`     | see `persistence.accessMode`        | `ReadWriteOnce`                             |
| `persistenceTmpMedia.size`           | see `persistence.size`              | `5Gi`                                       |

We recommend setting the values in a `values.yaml` file and install with the following command.

```console
helm install --name my-release -f values.yaml biblioverse/biblioteca
```

> **Tip**: You can use the default [values.yaml](values.yaml) and customize it to your needs.

### Probes Configurations

The Biblioteca deployment includes a series of different probes you can use to determine if a pod is ready or not. You can learn more in the [Configure Liveness, Readiness and Startup Probes Kubernetes docs](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/).

| Parameter                            | Description                                 | Default |
| ------------------------------------ | ------------------------------------------- | ------- |
| `livenessProbe.enabled`              | Turn on and off liveness probe              | `false` |
| `livenessProbe.initialDelaySeconds`  | Delay before liveness probe is initiated    | `10`    |
| `livenessProbe.periodSeconds`        | How often to perform the probe              | `10`    |
| `livenessProbe.timeoutSeconds`       | When the probe times out                    | `5`     |
| `livenessProbe.failureThreshold`     | Minimum consecutive failures for the probe  | `3`     |
| `livenessProbe.successThreshold`     | Minimum consecutive successes for the probe | `1`     |
| `readinessProbe.enabled`             | Turn on and off readiness probe             | `false` |
| `readinessProbe.initialDelaySeconds` | Delay before readiness probe is initiated   | `10`    |
| `readinessProbe.periodSeconds`       | How often to perform the probe              | `10`    |
| `readinessProbe.timeoutSeconds`      | When the probe times out                    | `5`     |
| `readinessProbe.failureThreshold`    | Minimum consecutive failures for the probe  | `3`     |
| `readinessProbe.successThreshold`    | Minimum consecutive successes for the probe | `1`     |
| `startupProbe.enabled`               | Turn on and off startup probe               | `false` |
| `startupProbe.initialDelaySeconds`   | Delay before readiness probe is initiated   | `30`    |
| `startupProbe.periodSeconds`         | How often to perform the probe              | `10`    |
| `startupProbe.timeoutSeconds`        | When the probe times out                    | `5`     |
| `startupProbe.failureThreshold`      | Minimum consecutive failures for the probe  | `30`    |
| `startupProbe.successThreshold`      | Minimum consecutive successes for the probe | `1`     |
