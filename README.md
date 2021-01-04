# HashiCorp Vault/Consul/K8s - Encryption Application Demo
Software requirements (on your laptop). These can be easily installed with brew on mac. https://www.hashicorp.com/blog/announcing-hashicorp-homebrew-tap

```git curl jq kubectl(v1.17 or greater) helm3 consul vault```

At the time of writing this readme I have the following versions installed

```
➜  Hashicorp-k8s-demos git:(master) jq -V
jq-1.5
➜  Hashicorp-k8s-demos git:(master) helm version
version.BuildInfo{Version:"v3.4.2", GitCommit:"23dd3af5e19a02d4f4baa5b2f242645a1a3af629", GitTreeState:"dirty", GoVersion:"go1.15.5"}
➜  Hashicorp-k8s-demos git:(master) kubectl version
Client Version: version.Info{Major:"1", Minor:"18", GitVersion:"v1.18.2", GitCommit:"52c56ce7a8272c798dbc29846288d7cd9fbae032", GitTreeState:"clean", BuildDate:"2020-04-16T23:35:15Z", GoVersion:"go1.14.2", Compiler:"gc", Platform:"darwin/amd64"}
Server Version: version.Info{Major:"1", Minor:"16+", GitVersion:"v1.16.15-gke.4901", GitCommit:"7ed5ddc0e67cb68296994f0b754cec45450d6a64", GitTreeState:"clean", BuildDate:"2020-11-06T18:22:22Z", GoVersion:"go1.13.15b4", Compiler:"gc", Platform:"linux/amd64"}
➜  Hashicorp-k8s-demos git:(master) vault version
Vault v1.6.0 (7ce0bd9691998e0443bc77e98b1e2a4ab1e965d4)
➜  Hashicorp-k8s-demos git:(master) consul version
Consul v1.9.0-beta1
```

You will also need the gcloud CLI tool for authentication:
https://cloud.google.com/sdk/docs/quickstart#mac

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

