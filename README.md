# k8s4jd-support
Kubernetes for Java developers project support files.

## 1. Database setup 
(copy from geodata README.md)

If you already do not have it create database named: **ag04**. 
Connect to database with user that has sufficient privileges and execute:

```sql
CREATE DATABASE ag04;
```

The next step is to create **geodata** user and his corresponding schema.
To do so execute the following sql commands:

```sql
CREATE ROLE geodata NOSUPERUSER NOCREATEDB NOCREATEROLE NOINHERIT LOGIN PASSWORD 'geodatapwd';
GRANT ALL PRIVILEGES ON DATABASE ag04 TO geodata;
CREATE SCHEMA IF NOT EXISTS AUTHORIZATION "geodata";
```

## 2. Minikube setup

Start minikube.

On Linux

```sh
minikube start
```
On macosx

```sh
minikube start --vm=true
```

Find out IP address of your minikube cluster by running:

```sh
minikube ip
```

This address is referenced in the rest of this documents as MINIKUBE_IP.

### 2.1. Enable ingress addon

```sh
minikube addons enable ingress
```

### 2.2. Allow connections to local Postgres from minikube 

Find out location of postgres.conf, to do so execute:

```bash
sudo -u postgres psql -c 'SHOW config_file'
```
Edit postgres.conf and pg_hba.conf files: 

* add the line `listen_addresses = '*'` to postgres.conf
* add the line `host all all MINIKUBE_IP/24 md5` to pg_hba.conf
* restart the postgres service

On Ubuntu issue:
```bash
sudo service postgresql restart
```
Now it is time to create ExternalService that points to your host Postgres instance.

```bash
kubectl apply -f default/postgres-host-svc.yml
```

### 2.3. Add entires to /etc/hosts

Add these entry to /etc/hosts file

```
MINIKUBE_IP    www.local-minikube.io
MINIKUBE_IP    geodata.local-minikube.io
```

Change the address above with the IP address of minikube on your machine.

### 2.4 Install Reloader

```sh
kubectl apply -f https://raw.githubusercontent.com/stakater/Reloader/master/deployments/kubernetes/reloader.yaml
```


## 3. Deploy geodata-app to minikube

Simply run the following script:

```bash
./geodata-create.sh
```


To cleanup minikube from all geodata related objects execute:

```bash
./geodata-delete.sh
```

**Test deployment**

To test if everything is working properly, expose geodata-app by using this command:

```bash
kubectl expose deployment geodata-app-deployment --name geodata-app-lb \
   --type LoadBalancer --port 80 --target-port 8000 -n geodata
```

**Expose geodata application with Ingress:**

```bash
kubectl apply -f default/ingress-ns-default.yml
```

## 4. Configuring minikube resources (CPU/memory)

If minikube is lacking resources to run the objects created by the script above, you need to give it more cpu and memory than granted by default cnfiguration.

On macosx run:

```sh
minikube start start --vm=true --cpus=2 --memory 6072
```
Note: vm option is requiered due to the bug in 1.14 version which prevents ingress from running. For more see [https://github.com/kubernetes/minikube/issues/7332](https://github.com/kubernetes/minikube/issues/7332)

On Linux run:

```sh
minikube start start --cpus=2 --memory 6072
```

