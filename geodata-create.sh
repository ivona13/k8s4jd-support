#!/bin/bash
kubectl apply -f default/postgres-host-svc.yml
kubectl create -f geodata/namespace.yml

kubectl apply -f geodata/geodata-config.yml
kubectl apply -f geodata/geodata-secret.yml
kubectl apply -f geodata/geodata-service.yml
kubectl apply -f geodata/geodata-app-deployment.yml

kubectl apply -f default/geodata-service-svc.yml

#kubectl apply -f default/ingress-ns-default.yml
