#!/usr/bin/env bash
### 2019-10-24 check
[ -e /etc/fdfs ] && echo /etc/fdfs 已經存在，部屬中止 && exit 1
### 2019-10-24 check

yum install -y wget
wget https://github.com/happyfish100/libfastcommon/archive/V1.0.7.tar.gz
tar zxvf V1.0.7.tar.gz
cd libfastcommon-1.0.7

yum install -y gcc perl make
./make.sh
./make.sh install

ln -s /usr/lib64/libfastcommon.so /usr/local/lib/libfastcommon.so
ln -s /usr/lib64/libfastcommon.so /usr/lib/libfastcommon.so
ln -s /usr/lib64/libfdfsclient.so /usr/local/lib/libfdfsclient.so
ln -s /usr/lib64/libfdfsclient.so /usr/lib/libfdfsclient.so 

cd ..
wget https://github.com/happyfish100/fastdfs/archive/V5.05.tar.gz
tar zxvf V5.05.tar.gz
cd fastdfs-5.05
./make.sh
./make.sh install

ln -s /usr/bin/fdfs_trackerd   /usr/local/bin
ln -s /usr/bin/fdfs_storaged   /usr/local/bin
ln -s /usr/bin/stop.sh         /usr/local/bin
ln -s /usr/bin/restart.sh      /usr/local/bin

# 範例配置

cat /etc/fdfs/tracker.conf.sample|grep -v '^#\|^$'|grep -v '^base_path' > /etc/fdfs/tracker.conf
echo base_path=/opt/fdfs/tracker >> /etc/fdfs/tracker.conf

cat /etc/fdfs/storage.conf.sample|grep -v '^#\|^$'|grep -v '^base_path\|^tracker_server\|^store_path0' > /etc/fdfs/storage.conf
echo base_path=/opt/fdfs/storage >> /etc/fdfs/storage.conf
echo tracker_server=localhost:22122 >> /etc/fdfs/storage.conf
echo store_path0=/opt/fdfs/file >> /etc/fdfs/storage.conf

cat /etc/fdfs/client.conf.sample|grep -v '^#\|^$'|grep -v '^base_path\|^tracker_server' > /etc/fdfs/client.conf
echo tracker_server=localhost:22122 >> /etc/fdfs/client.conf
echo base_path=/opt/fdfs/client >> /etc/fdfs/client.conf

mkdir -p /opt/fdfs/{tracker,storage,file,client}

service fdfs_trackerd start && service fdfs_storaged start
yum install -y net-tools
netstat -naltup
fdfs_monitor /etc/fdfs/client.conf || exit 1
service fdfs_trackerd stop && service fdfs_storaged stop
