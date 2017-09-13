#!/usr/bin/env bash

# Build the image and tag it as dev-latest
docker build -t nodehttp1:dev-latest .

# Delete any previous nodehttp1 deployment and service
kubectl delete deployment,svc nodehttp1

# Use Makefile to create deployment and service and mounting volumes
make create
make local
make mount

# Get the URL to access the nodehttp1 service
minikube service nodehttp1 --url

# Access the logs (to the the POD_NAME do kubectl get pod)
kubectl logs POD_NAME -c nodehttp1

### Alternatively here are some commands to run/create deployment services one by one

# Create the nodehttp1 deployment and specify which port you want to expose
# Add `--dry-run -o yaml > deployment.yaml` to create conf file
kubectl run nodehttp1 --image=nodehttp1:dev-latest --port=8081

# Expose the previously created deployment
# Add `--dry-run -o yaml > svc.yaml` to create conf file
kubectl expose deployment nodehttp1 --type=NodePort