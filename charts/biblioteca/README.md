# Biblioteca Helm Chart

[Biblioteca](https://biblioverse.github.io/biblioteca/) is a web application created to manage your personal library. This is an alternative to Calibre and other similar software.

## TL;DR;

```bash
helm repo add biblioverse https://biblioverse.github.io/helm/
helm install my-release biblioverse/biblioteca
```

## Quick Links

- [Introduction](#introduction)
- [Prerequisites](#prerequisites)
- [Installing the Chart](#installing-the-chart)
- [Uninstalling the Chart](#uninstalling-the-chart)
- [Biblioteca Configuration](#biblioteca-configuration)
- [Configuration](#configuration)
  - [Typesense](#typesense)
    - [External Typesense](#external-typesense)
    - [Embedded Typesense](#embedded-typesense)
      - [Typesense Probes Configuration](#typesense-probes-configurations)
  - [Database Configurations](#database-configurations)
  - [Presistence Configurations](#persistence-configurations)
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

## Biblioteca Configuration

This is the configuration of the Biblioteca app, check https://biblioverse.github.io/biblioteca/installing/dotenv-config/ for the details of each configuration.

| Parameter                                          | Description                                                                                                                                                       | Default                                    |
| -------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------ |
| `biblioteca.appSecret.appSecret`                   | A secret key used to secure the application. Make it unique!                                                                                                      | `""`                                       |
| `biblioteca.appSecret.existingSecret.enabled`      | Whether to use a existing secret or not                                                                                                                           | `false`                                    |
| `biblioteca.appSecret.existingSecret.secretName`   | Name of the existing secret                                                                                                                                       | `nil`                                      |
| `biblioteca.appSecret.existingSecret.appSecretKey` | Name of the key that contains the API Key                                                                                                                         | `app-secret`                               |
| `biblioteca.mailerDSN`                             | Currently not used.                                                                                                                                               | `native://default`                         |
| `biblioteca.messengerTransportDSN`                 | Do not change it.                                                                                                                                                 | `doctrine://default?auto_setup=0`          |
| `biblioteca.bookFolderNamingFormat`                | The format to use to name the folders where the books are stored. You can use the following placeholders: `{authorFirst}`, `{author}`, `{title}`, `{serie}`.      | `"{authorFirst}/{author}/{title}/{serie}"` |
| `biblioteca.bookFileNamingFormat`                  |                                                                                                                                                                   | `"{serie}-{serieIndex}-{title}"`           |
| `biblioteca.kobo.proxyUseDev`                      | If set to true, the kobo proxy will be used in development.                                                                                                       | `false`                                    |
| `biblioteca.kobo.proxyUseEverywhere`               | If set to true, the kobo proxy will be used everywhere and all request will be forwarded to the original store.                                                   | `false`                                    |
| `biblioteca.kobo.proxyEnabled`                     | If set to false, the kobo proxy will be disabled.                                                                                                                 | `true`                                     |
| `biblioteca.allowBookRelocation`                   | If set to false, the books will not be moved to the correct folder when added to the library. This is useful if you want to manage the folder structure yourself. | `true`                                     |
| `biblioteca.ollama.url`                            | Specify the Url to your ollama installation                                                                                                                       | `nil`                                      |
| `biblioteca.ollama.model`                          | Specify the ollama model to use                                                                                                                                   | `nil`                                      |
| `biblioteca.openai.apiKey`                         | ApiKey for Open AI                                                                                                                                                | `nil`                                      |
| `biblioteca.openai.model`                          | Specify the ollama model to use                                                                                                                                   | `gpt-3.5-turbo`                            |

## Configuration

The following table lists the configurable parameters of the Biblioteca chart and their default values.

| Parameter                                  | Description                                                                             | Default                                 |
| ------------------------------------------ | --------------------------------------------------------------------------------------- | --------------------------------------- |
| `image.repository`                         | biblioteca Image name                                                                   | `ghcr.io/biblioverse/biblioteca-docker` |
| `image.tag`                                | biblioteca Image tag                                                                    | `appVersion`                            |
| `image.pullPolicy`                         | Image pull policy                                                                       | `IfNotPresent`                          |
| `image.pullSecrets`                        | Specify image pull secrets                                                              | `nil`                                   |
| `service.type`                             | Kubernetes Service type                                                                 | `ClusterIP`                             |
| `service.loadBalancerIP`                   | LoadBalancerIp for service type LoadBalancer                                            | `""`                                    |
| `service.annotations`                      | Annotations for service type                                                            | `{}`                                    |
| `service.nodePort`                         | NodePort for service type NodePort                                                      | `nil`                                   |
| `service.ipFamilies`                       | Set ipFamilies as in k8s service objects                                                | `nil`                                   |
| `service.ipFamyPolicy`                     | define IP protocol bindings as in k8s service objects                                   | `nil`                                   |
| `ingress.className`                        | Name of the ingress class to use                                                        | `nil`                                   |
| `ingress.host`                             | Host Ingress                                                                            | `nil`                                   |
| `ingress.enabled`                          | Enable use of ingress controllers                                                       | `false`                                 |
| `ingress.servicePort`                      | Ingress' backend servicePort                                                            | `http`                                  |
| `ingress.annotations`                      | An array of service annotations                                                         | `nil`                                   |
| `ingress.labels`                           | An array of service labels                                                              | `nil`                                   |
| `ingress.path`                             | The `Path` to use in Ingress' `paths`                                                   | `/`                                     |
| `ingress.pathType`                         | The `PathType` to use in Ingress' `paths`                                               | `Prefix`                                |
| `ingress.tls`                              | Ingress TLS configuration                                                               | `[]`                                    |
| `containerPort`                            | Customize container port when not running as root                                       | `8080`                                  |
| `deployment.strategy`                      | specifies the strategy used to replace old Pods by new ones                             | `type: Recreate`                        |
| `deployment.replicaCount`                  | Number of biblioteca pods to deploy                                                     | `1`                                     |
| `deployment.labels`                        | Labels to be added at 'deployment' level                                                | not set                                 |
| `deployment.annotations`                   | Annotations to be added at 'deployment' level                                           | not set                                 |
| `pod.extraEnv`                             | specify additional environment variables                                                | `{}`                                    |
| `pod.extraSidecarContainers`               | specify additional sidecar containers                                                   | `[]`                                    |
| `pod.extraInitContainers`                  | specify additional init containers                                                      | `[]`                                    |
| `pod.extraVolumes`                         | specify additional volumes for the Biblioteca pod                                       | `{}`                                    |
| `pod.extraVolumeMounts`                    | specify additional volume mounts for the Biblioteca pod                                 | `{}`                                    |
| `pod.mariaDbInitContainer.resources`       | set the `resources` field of the MariaDB init container in the Biblioteca Pod.          | `{}`                                    |
| `pod.mariaDbInitContainer.securityContext` | set the `securityContext` field of the MariaDB init container in the Biblioteca Pod.    | `{}`                                    |
| `pod.securityContext`                      | Optional security context for the Biblioteca container                                  | `nil`                                   |
| `pod.podSecurityContext`                   | Optional security context for the Biblioteca pod (applies to all containers in the pod) | `nil`                                   |
| `pod.lifecycle.postStartCommand`           | Specify deployment lifecycle hook postStartCommand                                      | `nil`                                   |
| `pod.lifecycle.preStopCommand`             | Specify deployment lifecycle hook preStopCommand                                        | `nil`                                   |
| `pod.resources`                            | CPU/Memory resource requests/limits                                                     | `{}`                                    |
| `pod.labels`                               | Labels to be added at 'pod' level                                                       | not set                                 |
| `pod.annotations`                          | Annotations to be added at 'pod' level                                                  | not set                                 |
| `pod.affinity`                             | Affinity for pod assignment                                                             | `{}`                                    |
| `pod.nodeSelector`                         | Node labels for pod assignment                                                          | `{}`                                    |
| `pod.tolerations`                          | Tolerations for pod assignment                                                          | `[]`                                    |
| `pod.dnsConfig`                            | Custom dnsConfig for biblioteca containers                                              | `{}`                                    |

### Typesense

You can either use the embedded TypeSense deployment (`typesense.enabled`) or bring your own (`externalTypesense.enabled`).
Only one should be enabled at a time.

#### External Typesense

| Parameter                                     | Description                                                                | Default   |
| --------------------------------------------- | -------------------------------------------------------------------------- | --------- |
| `externalTypesense.enabled`                   | Whether to use external TypeSense                                          | `false`   |
| `externalTypesense.url`                       | URL to the external TypeSense. Example: `"http://your-typesense-url:8108"` | `""`      |
| `externalTypesense.apiKey`                    | API Key to the external Typesense.                                         | `""`      |
| `externalTypesense.existingSecret.enabled`    | Whether to use a existing secret or not                                    | `false`   |
| `externalTypesense.existingSecret.secretName` | Name of the existing secret                                                | `nil`     |
| `externalTypesense.existingSecret.apiKeyKey`  | Name of the key that contains the API Key                                  | `api-key` |

#### Embedded Typesense

| Parameter                                          | Description                                             | Default                                     |
| -------------------------------------------------- | ------------------------------------------------------- | ------------------------------------------- |
| `typesense.enabled`                                | Whether to use the MariaDB chart                        | `true`                                      |
| `typesense.service.type`                           | Kubernetes Service type                                 | `ClusterIP`                                 |
| `typesense.service.loadBalancerIP`                 | LoadBalancerIp for service type LoadBalancer            | `""`                                        |
| `typesense.service.annotations`                    | Annotations for service type                            | `{}`                                        |
| `typesense.service.nodePort`                       | NodePort for service type NodePort                      | `nil`                                       |
| `typesense.service.ipFamilies`                     | Set ipFamilies as in k8s service objects                | `nil`                                       |
| `typesense.service.ipFamyPolicy`                   | define IP protocol bindings as in k8s service objects   | `nil`                                       |
| `typesense.apiKeySecret.apiKey`                    | API Key to the external Typesense.                      | `""`                                        |
| `typesense.apiKeySecret.existingSecret.enabled`    | Whether to use a existing secret or not                 | `false`                                     |
| `typesense.apiKeySecret.existingSecret.secretName` | Name of the existing secret                             | `nil`                                       |
| `typesense.apiKeySecret.existingSecret.apiKeyKey`  | Name of the key that contains the API Key               | `api-key`                                   |
| `typesense.image.repository`                       | biblioteca Image name                                   | `...`                                       |
| `typesense.image.tag`                              | biblioteca Image tag                                    | `...`                                       |
| `typesense.image.pullPolicy`                       | Image pull policy                                       | `IfNotPresent`                              |
| `typesense.image.pullSecrets`                      | Specify image pull secrets                              | `nil`                                       |
| `typesense.containerPort`                          | Customize container port when not running as root       | `8108`                                      |
| `typesense.podLabels`                              | Labels to be added at 'pod' level                       | not set                                     |
| `typesense.podAnnotations`                         | Annotations to be added at 'pod' level                  | not set                                     |
| `typesense.deploymentLabels`                       | Labels to be added at 'deployment' level                | not set                                     |
| `typesense.deploymentAnnotations`                  | Annotations to be added at 'deployment' level           | not set                                     |
| `typesense.lifecycle.postStartCommand`             | Specify deployment lifecycle hook postStartCommand      | `nil`                                       |
| `typesense.lifecycle.preStopCommand`               | Specify deployment lifecycle hook preStopCommand        | `nil`                                       |
| `typesense.extraArgs`                              | specify additional command arguments                    | `{}`                                        |
| `typesense.extraEnv`                               | specify additional environment variables                | `{}`                                        |
| `typesense.extraSidecarContainers`                 | specify additional sidecar containers                   | `[]`                                        |
| `typesense.extraInitContainers`                    | specify additional init containers                      | `[]`                                        |
| `typesense.extraVolumes`                           | specify additional volumes for the Biblioteca pod       | `{}`                                        |
| `typesense.extraVolumeMounts`                      | specify additional volume mounts for the Biblioteca pod | `{}`                                        |
| `typesense.persistence.enabled`                    | Enable persistence using PVC                            | `false`                                     |
| `typesense.persistence.annotations`                | PVC annotations                                         | `{}`                                        |
| `typesense.persistence.storageClass`               | PVC Storage Class for the volume                        | `nil` (uses alpha storage class annotation) |
| `typesense.persistence.existingClaim`              | An Existing PVC name for the volume                     | `nil` (uses alpha storage class annotation) |
| `typesense.persistence.accessMode`                 | PVC Access Mode for the volume                          | `ReadWriteOnce`                             |
| `typesense.persistence.size`                       | PVC Storage Request for the volume                      | `1Gi`                                       |
| `typesense.resources`                              | CPU/Memory resource requests/limits                     | `{}`                                        |
| `typesense.affinity`                               | Affinity for pod assignment                             | `{}`                                        |
| `typesense.nodeSelector`                           | Node labels for pod assignment                          | `{}`                                        |
| `typesense.tolerations`                            | Tolerations for pod assignment                          | `[]`                                        |
| `typesense.dnsConfig`                              | Custom dnsConfig for biblioteca containers              | `{}`                                        |

##### Typesense Probes Configurations

You can learn more in the [Configure Liveness, Readiness and Startup Probes Kubernetes docs](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/).

| Parameter                                      | Description                                 | Default |
| ---------------------------------------------- | ------------------------------------------- | ------- |
| `typesense.livenessProbe.enabled`              | Turn on and off liveness probe              | `false` |
| `typesense.livenessProbe.initialDelaySeconds`  | Delay before liveness probe is initiated    | `10`    |
| `typesense.livenessProbe.periodSeconds`        | How often to perform the probe              | `10`    |
| `typesense.livenessProbe.timeoutSeconds`       | When the probe times out                    | `5`     |
| `typesense.livenessProbe.failureThreshold`     | Minimum consecutive failures for the probe  | `3`     |
| `typesense.livenessProbe.successThreshold`     | Minimum consecutive successes for the probe | `1`     |
| `typesense.readinessProbe.enabled`             | Turn on and off readiness probe             | `false` |
| `typesense.readinessProbe.initialDelaySeconds` | Delay before readiness probe is initiated   | `10`    |
| `typesense.readinessProbe.periodSeconds`       | How often to perform the probe              | `10`    |
| `typesense.readinessProbe.timeoutSeconds`      | When the probe times out                    | `5`     |
| `typesense.readinessProbe.failureThreshold`    | Minimum consecutive failures for the probe  | `3`     |
| `typesense.readinessProbe.successThreshold`    | Minimum consecutive successes for the probe | `1`     |
| `typesense.startupProbe.enabled`               | Turn on and off startup probe               | `false` |
| `typesense.startupProbe.initialDelaySeconds`   | Delay before readiness probe is initiated   | `30`    |
| `typesense.startupProbe.periodSeconds`         | How often to perform the probe              | `10`    |
| `typesense.startupProbe.timeoutSeconds`        | When the probe times out                    | `5`     |
| `typesense.startupProbe.failureThreshold`      | Minimum consecutive failures for the probe  | `30`    |
| `typesense.startupProbe.successThreshold`      | Minimum consecutive successes for the probe | `1`     |

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
