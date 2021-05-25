#GCP K8s Node bootstrap
echo "Starting startup script" >> /root/status.txt
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
sudo yum install -y kubelet kubeadm kubectl jq tree --disableexcludes=kubernetes
sudo systemctl enable --now kubelet
dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
dnf install https://download.docker.com/linux/centos/7/x86_64/stable/Packages/containerd.io-1.2.6-3.3.el7.x86_64.rpm -y
dnf install docker-ce --nobest -y
systemctl start docker
kubeadm config images pull
echo "Ready to install Kubeadm" >> /root/status.txt

#Master node
cd /root
kubeadm init
export KUBECONFIG=/etc/kubernetes/admin.conf
kubeadm token create --print-join-command > /root/join.txt

echo "Join nodes with join.txt - or next steps will hang" >> /root/status.txt
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"

echo "CNI should be installed next - Ready to install Helm and Istio" >> /root/status.txt

# Helm and Istio
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
curl -L https://git.io/getLatestIstio | sh -
export PATH="$PATH:/root/istio-1.10.0/bin"
echo "export KUBECONFIG=/etc/kubernetes/admin.conf" > /root/export.txt
echo "export PATH=\"$PATH:/root/istio-1.10.0/bin\"" >> /root/export.txt
echo "Next to install Istio with Demo profile" >> /root/status.txt
istioctl install --set profile=demo -y