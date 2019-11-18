# Setting up the CI Pipeine.

You need a configured K8s Cluster. Also Helm should be aready setup

## Step 1 - install nginx ingress controller

```
helm upgrade --install nginx-ingress stable/nginx-ingress
```

## Setup CRDs

```
pp kubectl apply \
    -f https://raw.githubusercontent.com/jetstack/cert-manager/release-0.8/deploy/manifests/00-crds.yaml
```

## Add Jetstack repo

```
pp helm repo add jetstack https://charts.jetstack.io
```

## Create CertManager namespace

```
pp kubectl apply -f https://raw.githubusercontent.com/jetstack/cert-manager/release-0.6/deploy/manifests/01-namespace.yaml
```

## Setup the CertManager

```
pp helm upgrade --install  cert-manager --namespace cert-manager jetstack/cert-manager
```

## Setup the ClusterIssuer
Cluster issuers can be reached across the cluster and can issue ssl certs for ingress.
```
pp kubectl apply -f cluster-issuer.yaml
```

## Deploy the Jenkins Helm Chart
```
pp helm upgrade --install --namespace buildtools -f jenkins-helm-config.yaml --debug sdf-build stable/jenkins
```

It will generate an ingress definition that is similar to :

```
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  annotations:
    certmanager.k8s.io/cluster-issuer: letsencrypt-prod
    ingress.kubernetes.io/secure-backends: "true"
    kubernetes.io/ingress.class: nginx
    kubernetes.io/tls-acme: "true"

  name: sdf-build-jenkins
spec:
  rules:
  - host: "build.voicea.app"
    http:
      paths:
      - backend:
          serviceName: sdf-build-jenkins
          servicePort: 8080
  tls:
    - hosts:
      - build.voicea.app
      secretName: build.voicea.app
```
