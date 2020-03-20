#!/usr/bin/env bash
### 2019-10-24 check
rpm -q ansible && echo ansible 已經存在，部屬中止 && exit 0
### 2019-10-24 check

yum install wget net-tools -y
#hostnamectl set-hostname master

# 禁用Selinux與swap
setenforce 0
sed -i 's@SELINUX=enforcing@SELINUX=disabled@' /etc/selinux/config
swapoff -a
sed -i '/swap/d' /etc/fstab

# iptables相關功能或模組的啟用與停用
systemctl disable firewalld && systemctl stop firewalld
echo 1 > /proc/sys/net/ipv4/ip_forward
echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
echo "net.bridge.bridge-nf-call-iptables = 1" >> /etc/sysctl.conf
modprobe br_netfilter
echo "br_netfilter" > /etc/modules-load.d/br_netfilter.conf
sysctl -p
lsmod | grep br_netfilter

# 添加docker-ce與kubernetes的yum源、並重整yum倉庫
yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager -y --add-repo https://download.docker.com/linux/centos/docker-ce.repo
cat > /etc/yum.repos.d/kubernetes.repo << EOF
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF
yum clean all && yum repolist

# 安裝docker-ce與kubernetes、指定套件的安裝版本並設置為開機啟動
yum install -y docker-ce-18.09.8 --nogpgcheck
systemctl enable docker && systemctl start docker
yum install -y kubelet-1.15.2 kubectl-1.15.2 kubeadm-1.15.2 --nogpgcheck --disableexcludes=kubernetes
systemctl enable kubelet && systemctl start kubelet

# 範例
cat << EOF
# 初始化master節點範例
# kubeadm init --apiserver-advertise-address=192.168.1.111 --pod-network-cidr=10.244.0.0/16 --service-cidr=10.96.0.0/12 --kubernetes-version=v1.15.2 --cri-socket="/var/run/dockershim.sock"
# mkdir -p $HOME/.kube
# cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
# chown $(id -u):$(id -g) $HOME/.kube/config
# kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

# Nodes機器加入叢集範例
# kubeadm join 192.168.1.111:6443 --token 1ypluc.v6gstqq9zd5fi7ow --discovery-token-ca-cert-hash sha256:1503d1042dd4781efbb57ff0ff833bda08afa8cb6f70e9a74a1a3d2b79226e8b
EOF
