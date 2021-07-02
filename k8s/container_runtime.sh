#!/bin/bash

# (Install Docker CE)

## Set up the repository:
### Install packages to allow apt to use a repository over HTTPS
apt-get update && apt-get install -y \
  apt-transport-https ca-certificates curl software-properties-common gnupg2
# Add Docker's official GPG key:
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
# Add the Docker apt repository:
add-apt-repository \
  "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) \
  stable"
# Install Docker CE
apt-get update && apt-get install -y \
  containerd.io=1.2.13-2 \
  docker-ce=5:19.03.11~3-0~ubuntu-$(lsb_release -cs) \
  docker-ce-cli=5:19.03.11~3-0~ubuntu-$(lsb_release -cs)
# Set up the Docker daemon
cat > /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF
mkdir -p /etc/systemd/system/docker.service.d
# Restart Docker
systemctl daemon-reload
systemctl restart docker

systemctl enable docker


# # CRI-O, not recommended because the version mismatch.

# modprobe overlay
# modprobe br_netfilter

# # Set up required sysctl params, these persist across reboots.
# cat > /etc/sysctl.d/99-kubernetes-cri.conf <<EOF
# net.bridge.bridge-nf-call-iptables  = 1
# net.ipv4.ip_forward                 = 1
# net.bridge.bridge-nf-call-ip6tables = 1
# EOF

# sysctl --system


# export OS=xUbuntu_18.04
# export VERSION=1.18


# echo "deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/$OS/ /" > /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list
# echo "deb http://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable:/cri-o:/$VERSION/$OS/ /" > /etc/apt/sources.list.d/devel:kubic:libcontainers:stable:cri-o:$VERSION.list

# curl -L https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable:cri-o:$VERSION/$OS/Release.key | apt-key add -
# curl -L https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/$OS/Release.key | apt-key add -

# apt-get update
# yes| apt-get install cri-o cri-o-runc

# systemctl daemon-reload
# systemctl start crio



# Containerd
## Prerequisites
cat > /etc/modules-load.d/containerd.conf <<EOF
overlay
br_netfilter
EOF

modprobe overlay
modprobe br_netfilter

# Setup required sysctl params, these persist across reboots.
cat > /etc/sysctl.d/99-kubernetes-cri.conf <<EOF
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF

sysctl --system

## Install containerd
# (Install containerd)
## Set up the repository
### Install packages to allow apt to use a repository over HTTPS
yes| apt-get update && apt-get install -y apt-transport-https ca-certificates curl software-properties-common
## Add Docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
## Add Docker apt repository.
add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"
## Install containerd
yes| apt-get update && apt-get install -y containerd.io
# Configure containerd
mkdir -p /etc/containerd
containerd config default > /etc/containerd/config.toml

# systemd
# To use the systemd cgroup driver, set plugins.cri.systemd_cgroup = true in /etc/containerd/config.toml. When using kubeadm, manually configure the cgroup driver for kubelet
# sed -i 's/systemd_cgroup = false/systemd_cgroup = true/' /etc/containerd/config.toml

# Restart containerd
systemctl restart containerd

yes|apt autoremove
