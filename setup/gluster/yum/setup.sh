#!/usr/bin/env bash
### 2019-10-24 check
rpm -q glusterfs-server-6*  && echo ansible 已經存在，部屬中止 && exit 1
### 2019-10-24 check

yum install -y centos-release-gluster6
yum install -y glusterfs-server

# 測試
systemctl start glusterd
systemctl status glusterd || exit 1
gluster  peer status || exit 1
