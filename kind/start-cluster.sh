#!/bin/bash

set -x

kind create cluster --config=./cluster.yml

# Make the images we will use available
kind load docker-image xeyes:fun xserver:fun

# Add an nginx ingress controller
# kubectl apply -f ./nginx.yml

# Create the resources
kubectl apply -f ./pod.yml
kubectl apply -f ./service.yml
# kubectl apply -f ./ingress.yml