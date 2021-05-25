# Bootstrapping Scripts for GCP

1. Create a project
2. Create a Cloud Router and NAT gateway for the subnet
3. Paste in the commands below

```# GitHub Master
gcloud beta compute --project=labs-311509 instances create master --zone=us-central1-a --machine-type=e2-standard-4 --subnet=default --private-network-ip=10.128.0.10 --no-address --metadata=startup-script=curl\ -L\ https://raw.githubusercontent.com/rafkruczkowski/journal/main/2021/05/GCP/master.sh\ \|\ sh\ - --can-ip-forward --maintenance-policy=MIGRATE --service-account=1054355330083-compute@developer.gserviceaccount.com --scopes=https://www.googleapis.com/auth/cloud-platform --image=centos-8-v20210512 --image-project=centos-cloud --boot-disk-size=20GB --boot-disk-type=pd-balanced --boot-disk-device-name=master --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --reservation-affinity=any

# Github Node1
gcloud beta compute --project=labs-311509 instances create node1 --zone=us-central1-a --machine-type=e2-standard-4 --subnet=default --private-network-ip=10.128.0.11 --no-address --metadata=startup-script=curl\ -L\ https://raw.githubusercontent.com/rafkruczkowski/journal/main/2021/05/GCP/node.sh\ \|\ sh\ - --can-ip-forward --maintenance-policy=MIGRATE --service-account=1054355330083-compute@developer.gserviceaccount.com --scopes=https://www.googleapis.com/auth/cloud-platform --image=centos-8-v20210512 --image-project=centos-cloud --boot-disk-size=20GB --boot-disk-type=pd-balanced --boot-disk-device-name=node1 --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --reservation-affinity=any

# Github Node2
gcloud beta compute --project=labs-311509 instances create node2 --zone=us-central1-a --machine-type=e2-standard-4 --subnet=default --private-network-ip=10.128.0.12 --no-address --metadata=startup-script=curl\ -L\ https://raw.githubusercontent.com/rafkruczkowski/journal/main/2021/05/GCP/node.sh\ \|\ sh\ - --can-ip-forward --maintenance-policy=MIGRATE --service-account=1054355330083-compute@developer.gserviceaccount.com --scopes=https://www.googleapis.com/auth/cloud-platform --image=centos-8-v20210512 --image-project=centos-cloud --boot-disk-size=20GB --boot-disk-type=pd-balanced --boot-disk-device-name=node2 --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --reservation-affinity=any

###
```

[Istio Docs](https://istio.io/latest/docs/setup/getting-started/)