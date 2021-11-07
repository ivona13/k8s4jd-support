#!/bin/bash
kubectl delete -n k8s4jdev deployment geodata-app-deployment
kubectl delete -n k8s4jdev service geodata-app-service
kubectl delete -n k8s4jdev configmap geodata-app-config
kubectl delete -n k8s4jdev secret geodata-app-secret

kubectl delete -n k8s4jdev service postgres-db-svc
kubectl delete -n k8s4jdev ingress k8s4jdev-ingress
kubectl delete ns k8s4jdev
