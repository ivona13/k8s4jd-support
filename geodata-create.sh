#!/bin/bash
kubectl apply -f dev/postgres-host-svc.yml
kubectl create -f dev/namespace.yml

kubectl apply -f dev/geodata-config.yml
kubectl apply -f dev/geodata-secret.yml
kubectl apply -f dev/geodata-service.yml
kubectl apply -f dev/geodata-app-deployment.yml

kubectl apply -f dev/geodata-service-svc.yml

#kubectl apply -f dev/ingress-ns-default.yml
