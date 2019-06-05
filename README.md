# Setting up the CI Pipeine

You need a configured K8s Cluster. Also Helm should be aready setup

## Step 1 - install nginx ingress controller

```
helm upgrade --install nginx-ingress stable/nginx-ingress
```

## Setup CRDs

```
pp kubectl apply \                                                                                             master     oke-cluster/default ⎈  Jun05 13:18 
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
