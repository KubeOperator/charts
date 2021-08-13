# Jenkins

[Jenkins](https://jenkins.io) is widely recognized as the most feature-rich CI available with easy configuration, continuous delivery and continuous integration support, easily test, build and stage your app, and more. It supports multiple SCM tools including CVS, Subversion and Git. It can execute Apache Ant and Apache Maven-based projects as well as arbitrary scripts.

## TL;DR

```console
helm repo add bitnami https://charts.bitnami.com/bitnami
helm install my-release bitnami/jenkins
```

## Introduction

This chart bootstraps a [Jenkins](https://github.com/bitnami/bitnami-docker-jenkins) deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

Bitnami charts can be used with [Kubeapps](https://kubeapps.com/) for deployment and management of Helm Charts in clusters. This Helm chart has been tested on top of [Bitnami Kubernetes Production Runtime](https://kubeprod.io/) (BKPR). Deploy BKPR to get automated TLS certificates, logging and monitoring for your applications.

## Prerequisites

- Kubernetes 1.12+
- Helm 3.1.0
- PV provisioner support in the underlying infrastructure
- ReadWriteMany volumes for deployment scaling

## Installing the Chart

To install the chart with the release name `my-release`:

```console
helm repo add bitnami https://charts.bitnami.com/bitnami
helm install my-release bitnami/jenkins
```

These commands deploy Jenkins on the Kubernetes cluster in the default configuration. The [Parameters](#parameters) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```console
helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Parameters

### Global parameters

| Name                      | Description                                     | Value |
| ------------------------- | ----------------------------------------------- | ----- |
| `global.imageRegistry`    | Global Docker image registry                    | `""`  |
| `global.imagePullSecrets` | Global Docker registry secret names as an array | `[]`  |
| `global.storageClass`     | Global StorageClass for Persistent Volume(s)    | `""`  |


### Common parameters

| Name                | Description                                        | Value           |
| ------------------- | -------------------------------------------------- | --------------- |
| `kubeVersion`       | Override Kubernetes version                        | `""`            |
| `nameOverride`      | String to partially override common.names.fullname | `""`            |
| `fullnameOverride`  | String to fully override common.names.fullname     | `""`            |
| `commonLabels`      | Labels to add to all deployed objects              | `{}`            |
| `commonAnnotations` | Annotations to add to all deployed objects         | `{}`            |
| `clusterDomain`     | Kubernetes cluster domain name                     | `cluster.local` |
| `extraDeploy`       | Array of extra objects to deploy with the release  | `[]`            |


### Jenkins Image parameters

| Name                | Description                                        | Value                  |
| ------------------- | -------------------------------------------------- | ---------------------- |
| `image.registry`    | Jenkins image registry                             | `docker.io`            |
| `image.repository`  | Jenkins image repository                           | `bitnami/jenkins`      |
| `image.tag`         | Jenkins image tag (immutable tags are recommended) | `2.289.3-debian-10-r0` |
| `image.pullPolicy`  | Jenkins image pull policy                          | `IfNotPresent`         |
| `image.pullSecrets` | Jenkins image pull secrets                         | `[]`                   |
| `image.debug`       | Enable image debug mode                            | `false`                |


### Jenkins Configuration parameters

| Name                    | Description                                                            | Value                   |
| ----------------------- | ---------------------------------------------------------------------- | ----------------------- |
| `jenkinsUser`           | Jenkins username                                                       | `user`                  |
| `jenkinsPassword`       | Jenkins user password                                                  | `""`                    |
| `jenkinsHost`           | Jenkins host to create application URLs                                | `""`                    |
| `jenkinsHome`           | Jenkins home directory                                                 | `/bitnami/jenkins/home` |
| `javaOpts`              | Custom JVM parameters                                                  | `[]`                    |
| `disableInitialization` | Skip performing the initial bootstrapping for Jenkins                  | `no`                    |
| `command`               | Override default container command (useful when using custom images)   | `[]`                    |
| `args`                  | Override default container args (useful when using custom images)      | `[]`                    |
| `extraEnvVars`          | Array with extra environment variables to add to the Jenkins container | `[]`                    |
| `extraEnvVarsCM`        | Name of existing ConfigMap containing extra env vars                   | `""`                    |
| `extraEnvVarsSecret`    | Name of existing Secret containing extra env vars                      | `""`                    |


### Jenkins deployment parameters

| Name                                    | Description                                                                               | Value           |
| --------------------------------------- | ----------------------------------------------------------------------------------------- | --------------- |
| `updateStrategy.type`                   | Jenkins deployment strategy type                                                          | `RollingUpdate` |
| `priorityClassName`                     | Jenkins pod priority class name                                                           | `""`            |
| `hostAliases`                           | Jenkins pod host aliases                                                                  | `[]`            |
| `extraVolumes`                          | Optionally specify extra list of additional volumes for Jenkins pods                      | `[]`            |
| `extraVolumeMounts`                     | Optionally specify extra list of additional volumeMounts for Jenkins container(s)         | `[]`            |
| `sidecars`                              | Add additional sidecar containers to the Jenkins pod                                      | `[]`            |
| `initContainers`                        | Add additional init containers to the Jenkins pods                                        | `[]`            |
| `lifecycleHooks`                        | Add lifecycle hooks to the Jenkins deployment                                             | `{}`            |
| `podLabels`                             | Extra labels for Jenkins pods                                                             | `{}`            |
| `podAnnotations`                        | Annotations for Jenkins pods                                                              | `{}`            |
| `podAffinityPreset`                     | Pod affinity preset. Ignored if `affinity` is set. Allowed values: `soft` or `hard`       | `""`            |
| `podAntiAffinityPreset`                 | Pod anti-affinity preset. Ignored if `affinity` is set. Allowed values: `soft` or `hard`  | `soft`          |
| `nodeAffinityPreset.type`               | Node affinity preset type. Ignored if `affinity` is set. Allowed values: `soft` or `hard` | `""`            |
| `nodeAffinityPreset.key`                | Node label key to match. Ignored if `affinity` is set                                     | `""`            |
| `nodeAffinityPreset.values`             | Node label values to match. Ignored if `affinity` is set                                  | `[]`            |
| `affinity`                              | Affinity for pod assignment                                                               | `{}`            |
| `nodeSelector`                          | Node labels for pod assignment                                                            | `{}`            |
| `tolerations`                           | Tolerations for pod assignment                                                            | `{}`            |
| `resources.limits`                      | The resources limits for the Jenkins container                                            | `{}`            |
| `resources.requests`                    | The requested resources for the Jenkins container                                         | `{}`            |
| `containerPorts.http`                   | Jenkins HTTP container port                                                               | `8080`          |
| `containerPorts.https`                  | Jenkins HTTPS container port                                                              | `8443`          |
| `podSecurityContext.enabled`            | Enabled Jenkins pods' Security Context                                                    | `true`          |
| `podSecurityContext.fsGroup`            | Set Jenkins pod's Security Context fsGroup                                                | `1001`          |
| `containerSecurityContext.enabled`      | Enabled Jenkins containers' Security Context                                              | `true`          |
| `containerSecurityContext.runAsUser`    | Set Jenkins container's Security Context runAsUser                                        | `1001`          |
| `containerSecurityContext.runAsNonRoot` | Set Jenkins container's Security Context runAsNonRoot                                     | `true`          |
| `livenessProbe.enabled`                 | Enable livenessProbe                                                                      | `true`          |
| `livenessProbe.initialDelaySeconds`     | Initial delay seconds for livenessProbe                                                   | `180`           |
| `livenessProbe.periodSeconds`           | Period seconds for livenessProbe                                                          | `10`            |
| `livenessProbe.timeoutSeconds`          | Timeout seconds for livenessProbe                                                         | `5`             |
| `livenessProbe.failureThreshold`        | Failure threshold for livenessProbe                                                       | `6`             |
| `livenessProbe.successThreshold`        | Success threshold for livenessProbe                                                       | `1`             |
| `readinessProbe.enabled`                | Enable readinessProbe                                                                     | `true`          |
| `readinessProbe.initialDelaySeconds`    | Initial delay seconds for readinessProbe                                                  | `30`            |
| `readinessProbe.periodSeconds`          | Period seconds for readinessProbe                                                         | `5`             |
| `readinessProbe.timeoutSeconds`         | Timeout seconds for readinessProbe                                                        | `3`             |
| `readinessProbe.failureThreshold`       | Failure threshold for readinessProbe                                                      | `3`             |
| `readinessProbe.successThreshold`       | Success threshold for readinessProbe                                                      | `1`             |
| `customLivenessProbe`                   | Custom livenessProbe that overrides the default one                                       | `{}`            |
| `customReadinessProbe`                  | Custom readinessProbe that overrides the default one                                      | `{}`            |


### Traffic Exposure Parameters

| Name                               | Description                                                                                           | Value                    |
| ---------------------------------- | ----------------------------------------------------------------------------------------------------- | ------------------------ |
| `service.type`                     | Jenkins service type                                                                                  | `LoadBalancer`           |
| `service.port`                     | Jenkins service HTTP port                                                                             | `80`                     |
| `service.httpsPort`                | Jenkins service HTTPS port                                                                            | `443`                    |
| `service.nodePorts.http`           | Node port for HTTP                                                                                    | `""`                     |
| `service.nodePorts.https`          | Node port for HTTPS                                                                                   | `""`                     |
| `service.clusterIP`                | Jenkins service Cluster IP                                                                            | `""`                     |
| `service.loadBalancerIP`           | Jenkins service Load Balancer IP                                                                      | `""`                     |
| `service.loadBalancerSourceRanges` | Jenkins service Load Balancer sources                                                                 | `[]`                     |
| `service.externalTrafficPolicy`    | Jenkins service external traffic policy                                                               | `Cluster`                |
| `service.annotations`              | Additional custom annotations for Jenkins service                                                     | `{}`                     |
| `ingress.enabled`                  | Enable ingress record generation for Jenkins                                                          | `false`                  |
| `ingress.pathType`                 | Ingress path type                                                                                     | `ImplementationSpecific` |
| `ingress.apiVersion`               | Force Ingress API version (automatically detected if not set)                                         | `""`                     |
| `ingress.hostname`                 | Default host for the ingress record                                                                   | `jenkins.local`          |
| `ingress.path`                     | Default path for the ingress record                                                                   | `ImplementationSpecific` |
| `ingress.annotations`              | Additional custom annotations for the ingress record                                                  | `{}`                     |
| `ingress.tls`                      | Enable TLS configuration for the host defined at `ingress.hostname` parameter                         | `false`                  |
| `ingress.certManager`              | Add the corresponding annotations for cert-manager integration                                        | `false`                  |
| `ingress.selfSigned`               | Create a TLS secret for this ingress record using self-signed certificates generated by Helm          | `false`                  |
| `ingress.extraHosts`               | An array with additional hostname(s) to be covered with the ingress record                            | `[]`                     |
| `ingress.extraPaths`               | An array with additional arbitrary paths that may need to be added to the ingress under the main host | `[]`                     |
| `ingress.extraTls`                 | TLS configuration for additional hostname(s) to be covered with this ingress record                   | `[]`                     |
| `ingress.secrets`                  | Custom TLS certificates as secrets                                                                    | `[]`                     |


### Persistence Parameters

| Name                                          | Description                                                                                     | Value                   |
| --------------------------------------------- | ----------------------------------------------------------------------------------------------- | ----------------------- |
| `persistence.enabled`                         | Enable persistence using Persistent Volume Claims                                               | `true`                  |
| `persistence.storageClass`                    | Persistent Volume storage class                                                                 | `""`                    |
| `persistence.annotations`                     | Additional custom annotations for the PVC                                                       | `{}`                    |
| `persistence.accessModes`                     | Persistent Volume access modes                                                                  | `[]`                    |
| `persistence.size`                            | Persistent Volume size                                                                          | `8Gi`                   |
| `volumePermissions.enabled`                   | Enable init container that changes the owner/group of the PV mount point to `runAsUser:fsGroup` | `false`                 |
| `volumePermissions.image.registry`            | Bitnami Shell image registry                                                                    | `docker.io`             |
| `volumePermissions.image.repository`          | Bitnami Shell image repository                                                                  | `bitnami/bitnami-shell` |
| `volumePermissions.image.tag`                 | Bitnami Shell image tag (immutable tags are recommended)                                        | `10-debian-10-r144`     |
| `volumePermissions.image.pullPolicy`          | Bitnami Shell image pull policy                                                                 | `IfNotPresent`          |
| `volumePermissions.image.pullSecrets`         | Bitnami Shell image pull secrets                                                                | `[]`                    |
| `volumePermissions.resources.limits`          | The resources limits for the init container                                                     | `{}`                    |
| `volumePermissions.resources.requests`        | The requested resources for the init container                                                  | `{}`                    |
| `volumePermissions.securityContext.runAsUser` | Set init container's Security Context runAsUser                                                 | `0`                     |


### Metrics Parameters

| Name                                         | Description                                                                                      | Value                         |
| -------------------------------------------- | ------------------------------------------------------------------------------------------------ | ----------------------------- |
| `metrics.enabled`                            | Start a sidecar prometheus exporter to expose Jenkins metrics                                    | `false`                       |
| `metrics.image.registry`                     | Jenkins Exporter image registry                                                                  | `docker.io`                   |
| `metrics.image.repository`                   | Jenkins Exporter image repository                                                                | `bitnami/jenkins-exporter`    |
| `metrics.image.tag`                          | Jenkins Jenkins Exporter image tag (immutable tags are recommended)                              | `0.20171225.0-debian-10-r510` |
| `metrics.image.pullPolicy`                   | Jenkins Exporter image pull policy                                                               | `IfNotPresent`                |
| `metrics.image.pullSecrets`                  | Jenkins Exporter image pull secrets                                                              | `[]`                          |
| `metrics.containerSecurityContext.enabled`   | Enabled Jenkins exporter containers' Security Context                                            | `true`                        |
| `metrics.containerSecurityContext.runAsUser` | Set Jenkins exporter containers' Security Context runAsUser                                      | `1001`                        |
| `metrics.resources.limits`                   | The resources limits for the Jenkins exporter container                                          | `{}`                          |
| `metrics.resources.requests`                 | The requested resources for the Jenkins exporter container                                       | `{}`                          |
| `metrics.service.type`                       | Jenkins exporter service type                                                                    | `ClusterIP`                   |
| `metrics.service.port`                       | Jenkins exporter service port                                                                    | `9122`                        |
| `metrics.service.nodePort`                   | Node port for exporter                                                                           | `""`                          |
| `metrics.service.externalTrafficPolicy`      | Jenkins exporter service external traffic policy                                                 | `Cluster`                     |
| `metrics.service.loadBalancerIP`             | Jenkins exporter service Load Balancer IP                                                        | `""`                          |
| `metrics.service.loadBalancerSourceRanges`   | Jenkins exporter service Load Balancer sources                                                   | `[]`                          |
| `metrics.service.annotations`                | Additional custom annotations for Jenkins exporter service                                       | `{}`                          |
| `metrics.serviceMonitor.enabled`             | Create ServiceMonitor resource(s) for scraping metrics using PrometheusOperator                  | `false`                       |
| `metrics.serviceMonitor.namespace`           | The namespace in which the ServiceMonitor will be created                                        | `""`                          |
| `metrics.serviceMonitor.interval`            | The interval at which metrics should be scraped                                                  | `30s`                         |
| `metrics.serviceMonitor.scrapeTimeout`       | The timeout after which the scrape is ended                                                      | `""`                          |
| `metrics.serviceMonitor.relabellings`        | Metrics relabellings to add to the scrape endpoint                                               | `[]`                          |
| `metrics.serviceMonitor.honorLabels`         | Specify honorLabels parameter to add the scrape endpoint                                         | `false`                       |
| `metrics.serviceMonitor.additionalLabels`    | Additional labels that can be used so ServiceMonitor resource(s) can be discovered by Prometheus | `{}`                          |


The above parameters map to the env variables defined in [bitnami/jenkins](http://github.com/bitnami/bitnami-docker-jenkins). For more information please refer to the [bitnami/jenkins](http://github.com/bitnami/bitnami-docker-jenkins) image documentation.

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```console
$ helm install my-release \
  --set jenkinsUser=admin \
  --set jenkinsPassword=password \
  bitnami/jenkins
```

The above command sets the Jenkins administrator account username and password to `admin` and `password` respectively.

> NOTE: Once this chart is deployed, it is not possible to change the application's access credentials, such as usernames or passwords, using Helm. To change these application credentials after deployment, delete any persistent volumes (PVs) used by the chart and re-deploy it, or use the application's built-in administrative tools if available.

Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the chart. For example,

```console
helm install my-release -f values.yaml bitnami/jenkins
```

> **Tip**: You can use the default [values.yaml](values.yaml)

## Configuration and installation details

### [Rolling vs Immutable tags](https://docs.bitnami.com/containers/how-to/understand-rolling-tags-containers/)

It is strongly recommended to use immutable tags in a production environment. This ensures your deployment does not change automatically if the same tag is updated with a different image.

Bitnami will release a new chart updating its containers if a new version of the main container, significant changes, or critical vulnerabilities exist.

### Configure Ingress

This chart provides support for Ingress resources. If you have an ingress controller installed on your cluster, such as [nginx-ingress-controller](https://github.com/bitnami/charts/tree/master/bitnami/nginx-ingress-controller) or [contour](https://github.com/bitnami/charts/tree/master/bitnami/contour) you can utilize the ingress controller to serve your application.

To enable Ingress integration, set `ingress.enabled` to `true`. The `ingress.hostname` property can be used to set the host name. The `ingress.tls` parameter can be used to add the TLS configuration for this host. It is also possible to have more than one host, with a separate TLS configuration for each host. [Learn more about configuring and using Ingress](https://docs.bitnami.com/kubernetes/apps/jenkins/configuration/configure-ingress/).

### Configure TLS Secrets for use with Ingress

The chart also facilitates the creation of TLS secrets for use with the Ingress controller, with different options for certificate management. [Learn more about TLS secrets](https://docs.bitnami.com/kubernetes/apps/jenkins/administration/enable-tls-ingress/).

### Configure extra environment variables

To add extra environment variables (useful for advanced operations like custom init scripts), use the `extraEnvVars` property.

```yaml
extraEnvVars:
  - name: LOG_LEVEL
    value: DEBUG
```

Alternatively, use a ConfigMap or a Secret with the environment variables. To do so, use the `extraEnvVarsCM` or the `extraEnvVarsSecret` values.

### Configure Sidecars and Init Containers

If additional containers are needed in the same pod as Jenkins (such as additional metrics or logging exporters), they can be defined using the `sidecars` parameter. Similarly, you can add extra init containers using the `initContainers` parameter.

[Learn more about configuring and using sidecar and init containers](https://docs.bitnami.com/kubernetes/apps/jenkins/configuration/configure-sidecar-init-containers/).

### Deploy extra resources

There are cases where you may want to deploy extra objects, such a ConfigMap containing your app's configuration or some extra deployment with a micro service used by your app. For covering this case, the chart allows adding the full specification of other objects using the `extraDeploy` parameter.

### Set Pod affinity

This chart allows you to set custom Pod affinity using the `XXX.affinity` parameter(s). Find more information about Pod affinity in the [Kubernetes documentation](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#affinity-and-anti-affinity).

As an alternative, you can use the preset configurations for pod affinity, pod anti-affinity, and node affinity available at the [bitnami/common](https://github.com/bitnami/charts/tree/master/bitnami/common#affinities) chart. To do so, set the `XXX.podAffinityPreset`, `XXX.podAntiAffinityPreset`, or `XXX.nodeAffinityPreset` parameters.

## Persistence

The [Bitnami Jenkins](https://github.com/bitnami/bitnami-docker-jenkins) image stores the Jenkins data and configurations at the `/bitnami/jenkins` path of the container. Persistent Volume Claims (PVCs) are used to keep the data across deployments.

If you encounter errors when working with persistent volumes, refer to our [troubleshooting guide for persistent volumes](https://docs.bitnami.com/kubernetes/faq/troubleshooting/troubleshooting-persistence-volumes/).

## Troubleshooting

Find more information about how to deal with common errors related to Bitnami’s Helm charts in [this troubleshooting guide](https://docs.bitnami.com/general/how-to/troubleshoot-helm-chart-issues).

## Upgrading

### To 8.0.0

Due to recent changes in the container image (see [Notable changes](https://github.com/bitnami/bitnami-docker-jenkins#notable-changes)), the major version of the chart has been bumped preemptively.

Upgrading from version `7.x.x` should be possible following the workaround below (the following example assumes that the release name is `jenkins`):

- Create a backup of your Jenkins data (e.g. using Velero to backup your PV)
- Remove Jenkins deployment:

```console
$ export JENKINS_PASSWORD=$(kubectl get secret --namespace default jenkins -o jsonpath="{.data.jenkins-password}" | base64 --decode)
$ kubectl delete deployments.apps jenkins
```

- Upgrade your release and delete data that should not be persisted anymore:

```console
$ helm upgrade jenkins bitnami/jenkins --set jenkinsPassword=$JENKINS_PASSWORD --set jenkinsHome=/bitnami/jenkins/jenkins_home
$ kubectl exec -it $(kubectl get pod -l app.kubernetes.io/instance=jenkins,app.kubernetes.io/name=jenkins -o jsonpath="{.items[0].metadata.name}") -- find /bitnami/jenkins -mindepth 1 -maxdepth 1 -not -name jenkins_home -exec rm -rf {} \;
```

### To 7.0.0

Chart labels were adapted to follow the [Helm charts standard labels](https://helm.sh/docs/chart_best_practices/labels/#standard-labels).

Consequences:

- Backwards compatibility is not guaranteed. However, you can easily workaround this issue by removing Jenkins deployment before upgrading (the following example assumes that the release name is `jenkins`):

```console
$ export JENKINS_PASSWORD=$(kubectl get secret --namespace default jenkins -o jsonpath="{.data.jenkins-password}" | base64 --decode)
$ kubectl delete deployments.apps jenkins
$ helm upgrade jenkins bitnami/jenkins --set jenkinsPassword=$JENKINS_PASSWORD
```

### To 6.1.0

This version also introduces `bitnami/common`, a [library chart](https://helm.sh/docs/topics/library_charts/#helm) as a dependency. More documentation about this new utility could be found [here](https://github.com/bitnami/charts/tree/master/bitnami/common#bitnami-common-library-chart). Please, make sure that you have updated the chart dependencies before executing any upgrade.

### To 6.0.0

[On November 13, 2020, Helm v2 support formally ended](https://github.com/helm/charts#status-of-the-project). This major version is the result of the required changes applied to the Helm Chart to be able to incorporate the different features added in Helm v3 and to be consistent with the Helm project itself regarding the Helm v2 EOL.

[Learn more about this change and related upgrade considerations](https://docs.bitnami.com/kubernetes/apps/jenkins/administration/upgrade-helm3/).

### To 5.0.0

The [Bitnami Jenkins](https://github.com/bitnami/bitnami-docker-jenkins) image was migrated to a "non-root" user approach. Previously the container ran as the `root` user and the Jenkins service was started as the `jenkins` user. From now on, both the container and the Jenkins service run as user `jenkins` (`uid=1001`). You can revert this behavior by setting the parameters `securityContext.runAsUser`, and `securityContext.fsGroup` to `root`.
Ingress configuration was also adapted to follow the Helm charts best practices.

Consequences:

- No "privileged" actions are allowed anymore.
- Backwards compatibility is not guaranteed when persistence is enabled.

To upgrade to `5.0.0`, install a new Jenkins chart, and migrate your Jenkins data ensuring the `jenkins` user has the appropriate permissions.

### To 4.0.0

Helm performs a lookup for the object based on its group (apps), version (v1), and kind (Deployment). Also known as its GroupVersionKind, or GVK. Changing the GVK is considered a compatibility breaker from Kubernetes' point of view, so you cannot "upgrade" those objects to the new GVK in-place. Earlier versions of Helm 3 did not perform the lookup correctly which has since been fixed to match the spec.

In 4dfac075aacf74405e31ae5b27df4369e84eb0b0 the `apiVersion` of the deployment resources was updated to `apps/v1` in tune with the api's deprecated, resulting in compatibility breakage.

This major version signifies this change.

### To 1.0.0

Backwards compatibility is not guaranteed unless you modify the labels used on the chart's deployments.
Use the workaround below to upgrade from versions previous to 1.0.0. The following example assumes that the release name is jenkins:

```console
kubectl patch deployment jenkins --type=json -p='[{"op": "remove", "path": "/spec/selector/matchLabels/chart"}]'
```
