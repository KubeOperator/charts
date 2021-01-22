# 添加部署机nexus chart仓库
$ helm repo add applications http://172.16.10.64:8081/repository/applications

### kubernetes-dashboard
$ helm install dashboard --namespace kube-operator --version 2.2.0 \
--set image.repository=172.16.10.64:8082/kubernetesui/dashboard \
--set image.tag=v2.0.3 \
--set extraArgs[0]=--enable-skip-login \
--set extraArgs[1]=--enable-insecure-login \
--set protocolHttp=true \
--set service.type=NodePort \
--set service.externalPort=9090 \
--set metricsScraper.enabled=true \
--set metricsScraper.image.repository=172.16.10.64:8082/kubernetesui/metrics-scraper \
--set metricsScraper.image.tag=v1.0.4 \
applications/kubernetes-dashboard

### kubeapps 不支持arm64架构
$ helm install kubeapps --namespace kube-operator --version 5.0.1 \
--set global.imageRegistry=172.16.10.64:8082 \
--set global.storageClass=nfs-sc \
--set apprepository.initialRepos[0].name=kubeoperator \
--set apprepository.initialRepos[0].url=http://172.16.10.64:8081/repository/kubeapps/ \
--set postgresql.primary.nodeSelector."kubernetes\.io/hostname"=wanghe-node1 \
--set postgresql.persistence.enabled=true \
--set postgresql.persistence.size=8Gi \
applications/kubeapps

### chartmuseum
$ helm install chartmuseum --namespace kube-operator  --version 2.13.0 \
--set image.repository=172.16.10.64:8082/chartmuseum/chartmuseum \
--set image.tag=v0.12.0 \
--set service.type=NodePort \
--set env.open.DISABLE_API=false \
--set nodeSelector."kubernetes\.io/hostname"=wanghe-node1 \
--set persistence.enabled=true \
--set persistence.size=8Gi \
--set persistence.storageClass=nfs-sc \
applications/chartmuseum

### docker-registry
$ helm install registry --namespace kube-operator --version 1.9.3 \
--set image.repository=172.16.10.64:8082/registry \
--set image.tag=2.7.1 \
--set nodeSelector."kubernetes\.io/hostname"=wanghe-node1 \
--set service.type=NodePort \
--set persistence.enabled=true \
--set persistence.size=10Gi \
--set persistence.storageClass=nfs-sc \
applications/docker-registry

### prometheus
$ helm install prometheus --namespace kube-operator --version 11.5.0 \
--set alertmanager.enabled=false \
--set configmapReload.prometheus.enabled=true \
--set configmapReload.prometheus.image.repository=172.16.10.64:8082/jimmidyson/configmap-reload \
--set configmapReload.prometheus.image.tag=v0.4.0 \
--set configmapReload.alertmanager.enabled=false \
--set configmapReload.prometheus.enabled=true \
--set kubeStateMetrics.enabled=true \
--set kube-state-metrics.image.repository=172.16.10.64:8082/carlosedp/kube-state-metrics \
--set kube-state-metrics.image.tag=v1.9.5 \
--set nodeExporter.enabled=true \
--set nodeExporter.image.repository=172.16.10.64:8082/prom/node-exporter \
--set nodeExporter.image.tag=v1.0.1 \
--set server.enabled=true \
--set server.service.type=NodePort \
--set server.image.repository=172.16.10.64:8082/prom/prometheus \
--set server.image.tag=v2.20.1 \
--set server.nodeSelector."kubernetes\.io/hostname"=wanghe-node1 \
--set server.persistentVolume.enabled=true \
--set server.persistentVolume.size=8Gi \
--set server.persistentVolume.storageClass=nfs-sc \
--set server.retention=15d \
--set pushgateway.enabled=false \
applications/prometheus

### efk 不支持arm64架构
$ helm install logging --namespace kube-operator --version 1.0.0 \
--set fluentd-elasticsearch.image.repository=172.16.10.64:8082/fluentd_elasticsearch/fluentd \
--set fluentd-elasticsearch.image.tag=v2.8.0 \
--set fluentd-elasticsearch.elasticsearch.logstashPrefix=logstash \
--set elasticsearch.replicas=2 \
--set elasticsearch.image=172.16.10.64:8082/elasticsearch/elasticsearch \
--set elasticsearch.imageTag=7.6.2 \
--set elasticsearch.esJavaOpts="-Xmx1g -Xms1g" \
--set elasticsearch.persistence.enabled=true \
--set elasticsearch.volumeClaimTemplate.storageClassName=nfs-sc \
--set elasticsearch.volumeClaimTemplate.resources.requests.storage=100Gi \
--set elasticsearch.service.type=NodePort \
applications/logging

### loki-stack
$ helm install loki --namespace kube-operator --version 2.0.0 \
--set loki.image.repository=172.16.10.64:8082/grafana/loki \
--set loki.image.tag=2.1.0 \
--set loki.nodeSelector."kubernetes\.io/hostname"=wanghe-node1 \
--set loki.persistence.enabled=true \
--set loki.persistence.size=8Gi \
--set loki.persistence.storageClassName=nfs-sc \
--set loki.service.type=NodePort \
--set promtail.image.repository=172.16.10.64:8082/grafana/promtail \
--set promtail.image.tag=2.1.0 \
--set promtail.dockerPath="/data/docker" \
applications/loki-stack


### grafana
$ helm install grafana --namespace kube-operator --version 6.1.15 \
--set image.repository=172.16.10.64:8082/kubeoperator/grafana \
--set image.tag=7.3.3-amd64 \
--set service.type=NodePort \
--set nodeSelector."kubernetes\.io/hostname"=wanghe-master-1 \
--set persistence.enabled=true \
--set persistence.storageClassName=nfs-sc \
--set persistence.size=10Gi \
--set initChownData.enabled=true \
--set initChownData.image.repository=172.16.10.64:8082/kubeoperator/busybox \
--set initChownData.image.tag=1.28-amd64 \
--set downloadDashboardsImage.repository=172.16.10.64:8082/curlimages/curl \
--set downloadDashboardsImage.tag=7.73.0 \
--set adminPassword=1qaz@WSX \
--set datasources."datasources\.yaml".apiVersion=1 \
--set datasources."datasources\.yaml".datasources[0].name=MYDS_Prometheus \
--set datasources."datasources\.yaml".datasources[0].type=prometheus \
--set datasources."datasources\.yaml".datasources[0].url=http://prometheus-server \
--set datasources."datasources\.yaml".datasources[0].access=proxy \
--set datasources."datasources\.yaml".datasources[0].isDefault=true \
--set datasources."datasources\.yaml".datasources[1].name=Loki \
--set datasources."datasources\.yaml".datasources[1].type=loki \
--set datasources."datasources\.yaml".datasources[1].url=http://loki:3100 \
--set datasources."datasources\.yaml".datasources[1].access=proxy \
--set dashboardProviders."dashboardproviders\.yaml".apiVersion=1 \
--set dashboardProviders."dashboardproviders\.yaml".providers[0].name="default" \
--set dashboardProviders."dashboardproviders\.yaml".providers[0].orgId=1 \
--set dashboardProviders."dashboardproviders\.yaml".providers[0].folder="" \
--set dashboardProviders."dashboardproviders\.yaml".providers[0].type=file \
--set dashboardProviders."dashboardproviders\.yaml".providers[0].disableDeletion=false \
--set dashboardProviders."dashboardproviders\.yaml".providers[0].editable=true \
--set dashboardProviders."dashboardproviders\.yaml".providers[0].options.path=/var/lib/grafana/dashboards/default \
--set dashboards.default.custom-dashboard.file=dashboards/custom-dashboard.json \
applications/grafana

### istio-base
helm install istio-base --namespace istio-system \
--set global.istiod.enableAnalysis=true \
applications/istio-base

### istio-pilot
helm install istio-pilot --namespace istio-system \
--set pilot.image=172.16.10.64:8082/istio/pilot:1.8.0 \
--set pilot.resources.limits.cpu=500m \
--set pilot.resources.limits.memory=2048Mi \
--set pilot.resources.requests.cpu=500m \
--set pilot.resources.requests.memory=2048Mi \
--set pilot.traceSampling=1 \
applications/istio-discovery

### istio-ingress
helm install istio-ingress --namespace istio-system \
--set global.proxy.image=172.16.10.64:8082/istio/proxyv2:1.8.0 \
--set gateways.istio-ingressgateway.resources.limits.cpu=2000m \
--set gateways.istio-ingressgateway.resources.limits.memory=1024Mi \
--set gateways.istio-ingressgateway.resources.requests.cpu=100m \
--set gateways.istio-ingressgateway.resources.requests.memory=128Mi \
--set gateways.istio-ingressgateway.type=NodePort \
applications/istio-ingress

### istio-egress
helm install istio-egress --namespace istio-system \
--set global.proxy.image=172.16.10.64:8082/istio/proxyv2:1.8.0 \
--set gateways.istio-egressgateway.resources.limits.cpu=2000m \
--set gateways.istio-egressgateway.resources.limits.memory=1024Mi \
--set gateways.istio-egressgateway.resources.requests.cpu=100m \
--set gateways.istio-egressgateway.resources.requests.memory=128Mi \
--set gateways.istio-egressgateway.type=NodePort \
applications/istio-egress
