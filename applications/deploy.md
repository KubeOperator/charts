# 添加部署机nexus chart仓库
$ helm repo add applications http://172.16.10.64:8081/repository/applications

### kubernetes-dashboard
$ helm install dashboard --namespace kube-operator \
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
$ helm install kubeapps --namespace kube-operator \
--set global.imageRegistry=172.16.10.64:8082 \
--set global.storageClass=nfs-sc \
--set useHelm3=true \
--set apprepository.initialRepos[0].name=kubeoperator \
--set apprepository.initialRepos[0].url=http://172.16.10.64:8081/repository/kubeapps/ \
--set postgresql.enabled=true \s
--set postgresql.persistence.enabled=true \
--set postgresql.persistence.size=8Gi \
applications/kubeapps

### chartmuseum 不支持arm64架构
$ helm install chartmuseum --namespace kube-operator \
--set image.repository=172.16.10.64:8082/chartmuseum/chartmuseum \
--set image.tag=v0.12.0 \
--set service.type=NodePort \
--set env.open.DISABLE_API=false \
--set persistence.enabled=true \
--set persistence.storageClass=nfs-sc \
applications/chartmuseum

### docker-registry
$ helm install registry --namespace kube-operator \
--set image.repository=172.16.10.64:8082/registry \
--set image.tag=2.7.1 \
--set service.type=NodePort \
--set persistence.enabled=true \
--set persistence.storageClass=nfs-sc \
applications/docker-registry

### prometheus
$ helm install prometheus --namespace kube-operator \
--set alertmanager.enabled=false \
--set configmapReload.prometheus.enabled=true \
--set configmapReload.prometheus.image.repository=172.16.10.64:8082/jimmidyson/configmap-reload \
--set configmapReload.prometheus.image.tag=v0.3.0 \
--set configmapReload.alertmanager.enabled=false \
--set configmapReload.prometheus.enabled=true \
--set kubeStateMetrics.enabled=true \
--set kube-state-metrics.image.repository=172.16.10.64:8082/coreos/kube-state-metrics \
--set kube-state-metrics.image.tag=v1.9.5 \
--set nodeExporter.enabled=true \
--set nodeExporter.image.repository=172.16.10.64:8082/prom/node-exporter \
--set nodeExporter.image.tag=v0.18.1 \
--set server.enabled=true \
--set server.service.type=NodePort \
--set server.image.repository=172.16.10.64:8082/prom/prometheus \
--set server.image.tag=v2.18.1 \
--set server.persistentVolume.enabled=true \
--set server.persistentVolume.size=8Gi \
--set server.persistentVolume.storageClass=nfs-sc \
--set server.retention=15d \
--set pushgateway.enabled=false \
applications/prometheus

### efk 不支持arm64架构
$ helm install efk --namespace kube-operator \
--set fluentd-elasticsearch.image.repository=172.16.10.64:8082/fluentd_elasticsearch/fluentd \
--set fluentd-elasticsearch.image.tag=v2.8.0 \
--set elasticsearch.replicas=1 \
--set elasticsearch.image=172.16.10.64:8082/elasticsearch/elasticsearch \
--set elasticsearch.imageTag=7.6.2 \
--set elasticsearch.esJavaOpts="-Xmx1g -Xms1g" \
--set elasticsearch.persistence.enabled=true \
--set elasticsearch.volumeClaimTemplate.storageClassName=nfs-sc \
--set elasticsearch.volumeClaimTemplate.resources.requests.storage=100Gi \
--set elasticsearch.service.type=NodePort \
--set kibana.image=172.16.10.64:8082/kibana/kibana \
--set kibana.imageTag=7.6.2 \
--set kibana.service.type=NodePort \
applications/efk