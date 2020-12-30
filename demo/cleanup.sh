#!/bin/bash

#NOTE: make sure to kill any "port-forward" processes if you are re-running this script.
#Check with the "ps" command on mac, then kill the vault/consul port-forward procceses 

kubectl delete -f ./vault-go-demo
helm delete consul
helm delete vault
helm delete pq

kubectl delete pvc data-default-consul-consul-server-0
kubectl delete pvc data-default-consul-consul-server-1
kubectl delete pvc data-default-consul-consul-server-2
kubectl delete pvc data-pq-postgresql-0
kubectl delete pvc data-vault-0