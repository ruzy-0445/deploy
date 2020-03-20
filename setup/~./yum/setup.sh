#!/usr/bin/env bash
### 2019-10-24 check
rpm -q docker-ce && echo docker-ce 已經存在，部屬中止 && exit 1
### 2019-10-24 check

### install via yum
yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install -y docker-ce docker-ce-cli containerd.io

# Update work directory
mkdir -p /etc/systemd/system/docker.service.d
cat << EOF > /etc/systemd/system/docker.service.d/devicemapper.conf
[Service]
ExecStart=
ExecStart=/usr/bin/dockerd  --graph=/opt/docker
EOF
systemctl daemon-reload

# Enable and Start service
systemctl start docker && systemctl enable docker
#docker-compose
curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/bin/docker-compose
chmod +x /usr/bin/docker-compose

# check
echo "#### check ####"
docker info
docker ps
