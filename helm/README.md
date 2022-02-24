# Helm chart for deploying Thingsboard in Kubernetes
This folder contains a helm chart that can be used to deploy Thingsboard on any Kubernetes cluster

## Some examples
* Simple deployment
```
helm install --create-namespace -n thingsboard thingsboard thingsboard
```
* Hybrid database (Cassandra for timeseries)
```
helm install --create-namespace -n thingsboard thingsboard thingsboard \
  --set cassandra.enable=true
```
* Hybrid database and set passwords
```
helm install --create-namespace -n thingsboard thingsboard thingsboard \
  --set cassandra.enable=true \
  --set postgresql-ha.postgresql.password=SET \
  --set postgresql-ha.postgresql.repmgrPassword=REALLY \
  --set postgresql-ha.pgpool.adminPassword=SECURE \
  --set redis.auth.password=PASSWORDS \
  --set cassandra.dbUser.password=HERE
```
* Tune number of replicas
```
helm install --create-namespace -n thingsboard thingsboard thingsboard \
  --set mqtt.replicaCount=3 \
  --set http.replicacount=0 \
  --set coap.replicacount=0
```
* Enable ingress and TLS for API REST (requirements `cert-manager` and `nginx-ingress`)
```
helm install --create-namespace -n thingsboard thingsboard thingsboard \
  --set ingress.enabled=true \
  --set ingress.tls=true \
  --set ingress.host=myurl.example.com \
  --set ingress.annotations."cert-manager\.io/cluster-issuer"=letsencrypt \
  --set-string ingress.annotations."nginx\.ingress\.kubernetes\.io/proxy-read-timeout"=3600 \
  --set-string ingress.annotations."nginx\.ingress\.kubernetes\.io/ssl-redirect"=true \
  --set ingress.annotations."kubernetes\.io/ingress\.class"=nginx \
  --set-string ingress.annotations."nginx\.ingress\.kubernetes\.io/use-regex"=true
```
* Enable MQTT SSL (requirements: public and private keys in a Kubernetes secret, for example by using `cert-manager`)
```
helm install --create-namespace -n thingsboard thingsboard thingsboard \
  --set mqtt.ssl.enabled=true \
  --set mqtt.ssl.secret=my-secret \
  --set mqtt.ssl.cert=tls.crt \
  --set mqtt.ssl.key=tls.key
```
## All options
* For the full list of options of this helm chart:
```
helm inspect values thingsboard
```
* For the list of values of this chart dependencies:
  * cassandra: https://github.com/bitnami/charts/blob/master/bitnami/cassandra/values.yaml
  * kafka: https://github.com/bitnami/charts/blob/master/bitnami/kafka/values.yaml
  * postgresql-ha: https://github.com/bitnami/charts/blob/master/bitnami/postgresql-ha/values.yaml
  * redis: https://github.com/bitnami/charts/blob/master/bitnami/redis/values.yaml

