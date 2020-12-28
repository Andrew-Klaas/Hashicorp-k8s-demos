#!/bin/bash

helm install pq \
  --set postgresqlPassword=password,postgresqlDatabase=vault_go_demo \
    bitnami/postgresql -f values.yaml


