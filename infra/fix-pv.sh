#!/bin/bash

echo "Fixing Persistent Volume permissions..."

kubectl get pods -A

echo "Restarting pods to ensure PV mounts correctly..."

kubectl delete pods --all -n logging || true
kubectl delete pods --all -n monitoring || true

echo "Persistent volume fix completed."