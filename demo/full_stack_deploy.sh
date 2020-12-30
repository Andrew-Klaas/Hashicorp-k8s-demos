#!/bin/bash
set -v

#REQUIRES HELM 3
helm repo add stable https://charts.helm.sh/stable
helm repo add hashicorp https://helm.releases.hashicorp.com
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

cd consul
./consul.sh
cd ..
kubectl wait --timeout=180s --for=condition=Ready $(kubectl get pod --selector=app=consul -o name)

cd postgresql
./postgresql.sh
cd ..
kubectl wait --timeout=180s --for=condition=Ready $(kubectl get pod pq-postgresql-0 -o name)

cd vault
./vault.sh
sleep 5s
./vault_setup.sh
cd ..
sleep 5s

kubectl apply -f vault-go-demo

echo ""
echo "vault-go-demo"
echo "use the following command to get your demo IP, port is 9090"
echo "$ kubectl get svc vault-go-demo"
