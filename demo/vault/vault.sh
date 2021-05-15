#!/bin/bash
set -v

helm install vault hashicorp/vault -f values.yaml 
# kubectl apply -f test.yaml

sleep 60s

nohup kubectl port-forward service/consul-consul-ui 8500:80 --pod-running-timeout=10m &
nohup kubectl port-forward service/vault-ui 8200:8200 --pod-running-timeout=10m &

echo ""
echo -n "Your Vault UI is at: http://localhost:8200"

open http://localhost:8200
