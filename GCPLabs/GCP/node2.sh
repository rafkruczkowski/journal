#GCP K8s Node bootstrap
echo "Starting Node startup script" >> /root/status.txt
swapoff -a
systemctl stop firewalld
systemctl disable firewalld
cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-\$basearch
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
exclude=kubelet kubeadm kubectl
EOF

sudo setenforce 0
sudo sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config
#sudo yum install -y kubelet kubeadm kubectl jq tree --disableexcludes=kubernetes
sudo yum install -y kubelet-1.20.9-0.x86_64 kubectl-1.20.9-0.x86_64 kubeadm-1.20.9-0.x86_64 jq tree --disableexcludes=kubernetes
sudo systemctl enable --now kubelet
dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
dnf install https://download.docker.com/linux/centos/7/x86_64/stable/Packages/containerd.io-1.2.6-3.3.el7.x86_64.rpm -y
dnf install docker-ce --nobest -y
systemctl start docker
kubeadm config images pull
echo "Node should be ready for Join command on master" >> /root/status.txt
sleep 60
echo "Sleeping for master to be ready" >> /root/status.txt
sudo gsutil cp gs://kruczkowski-bucket/join.txt /root/join.txt
echo "Join command copied from bucket" >> /root/status.txt
sudo chmod +x /root/join.txt
sudo ./root/join.txt
echo "Join command should be running" >> /root/status.txt
#end
