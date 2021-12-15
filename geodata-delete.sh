#!/bin/bash
kubectl delete -n default service geodata-service-svc

kubectl delete -n geodata deployment geodata-app-deployment
kubectl delete -n geodata service geodata-app-service
kubectl delete -n geodata configmap geodata-app-config
kubectl delete -n geodata secret geodata-app-secret

kubectl delete ns geodata
