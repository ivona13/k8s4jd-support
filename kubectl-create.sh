#!/bin/bash
kubectl create -f k8s4jdev/namespace.yml
kubectl create -f k8s4jdev/postgres-host-svc.yml

kubectl apply -f final/geodata-config.yml
kubectl apply -f final/geodata-secret.yml
kubectl apply -f final/geodata-service.yml
kubectl apply -f final/geodata-app-deployment.yml

kubectl apply -f k8s4jdev/ingress.yml
