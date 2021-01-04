# HashiCorp Vault/Consul/K8s - Encryption Application Demo
Software requirements (on your laptop). These can be easily installed with brew on mac. https://www.hashicorp.com/blog/announcing-hashicorp-homebrew-tap

```git curl jq kubectl(v1.17 or greater) helm3 consul vault```

## Setup
0. Set your GCP creds. Use the following link to setup gcloud for authenticating the provider: https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/getting_started#configuring-the-provider


1. Fill out terraform.tfvars with your values

2. plan/apply
```bash
terraform apply --auto-approve;
```

3. Copy the command for  "connecting" to your k8s cluster from the terraform output.
```bash
gcloud container clusters get-credentials your-cluster-name --zone us-central1-c --project your-project
```

4. Deploy Consul/Vault/Mariadb/Python-transit-app. This takes a minute or two as there are a bunch of sleeps setup in the script. This script is running on your laptop and connecting out to the Kubernetes cluster! That is why we need the software requirements from above. 
```bash
cd demo
./full_stack_deploy.sh
```
cat that script if you want to see how to deploy each of the above by hand/manually.

## UI
Refresh your browser tab when they initally open up. They are started by nohup commands using kubectl port-forward. see demo/vault/vault.sh and demo/consul/consul.sh

```bash
#Consul
http://localhost:8500

#Vault
http://localhost:8200
```

You may need to re-run the nohup commands to reset port-forwarding to access the Vault and Consul services.

```bash
nohup kubectl port-forward service/consul-consul-ui 8500:80 --pod-running-timeout=10m &
nohup kubectl port-forward service/vault-ui 8200:8200 --pod-running-timeout=10m &

```

## Encryption as a service demo
Use the following command to access the application. Use port 9090.
```bash
$  kubectl get svc vault-go-demo
```

## Cleanup
Use the cleaup.sh script under demo/ to delete all pods, helm deploys, and PVCs.

NOTE: if you are re-running the deploy, make sure you kill any port-forward Consul/Vault procceses left over from the first execution. Use the "ps" command on your laptop to check. 

```bash
cd demo/
./cleanup.sh
```

