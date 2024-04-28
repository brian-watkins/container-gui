#!/bin/bash

set -e

kind create cluster --config=./cluster.yml

# Make the images we will use available
kind load docker-image xeyes:fun xserver:fun

# Add an nginx ingress controller
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml

echo "Waiting for NGINX Ingress to be available ..."

kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=90s

# Create the resources
kubectl apply -f ./pod.yml
kubectl apply -f ./service.yml
kubectl apply -f ./ingress.yml

echo
echo "All set!"
echo "Go to http://localhost:8888/vnc/vnc.html in your browser!"
echo "Note that you may need to configure the novnc websocket to use the path /vnc/websockify if you haven't already."
echo "Enjoy!"
