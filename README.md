# k8s4jd-support
Kubernetes for Java developers project support files


## 1. Minikube setup

Find out IP address of your minikube cluster by running:

```sh
minikube ip
```

This address is referenced in the rest of this documents as MINIKUBE_IP.

### 1.1. Enable ingress addon

```sh
minikube addons enable ingress
```

### 1.2. Allow connections to local Postgres from minikube 

Find out location of postgres.conf, execute:

```bash
sudo -u postgres psql -c 'SHOW config_file'
```
Edit postgres.conf file: 

* add the line `listen_addresses = '*'` to postgres.conf
* add the line `host all all MINIKUBE_IP/24 md5` to pg_hba.conf
* restart the postgres service

### 1.3. Add entires to /etc/hosts

Add these entry to /etc/hosts file
MINIKUBE_IP    geodata.local-minikube.io

Change the address above with the IP address of minikube on your machine.

### 1.4 Install Reloader

```sh
kubectl apply -f https://raw.githubusercontent.com/stakater/Reloader/master/deployments/kubernetes/reloader.yaml
```
