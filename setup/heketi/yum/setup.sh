#!/usr/bin/env bash
### 2019-10-24 check
rpm -q heketi && echo heketi 已經存在，部屬中止 && exit 0
### 2019-10-24 check

# 安裝
yum install -y centos-release-gluster6
yum install -y heketi heketi-client

# 測試
systemctl start heketi
systemctl status heketi

sleep 1
heketi-cli node list
heketi-cli topology info

# 停止測試
systemctl stop heketi
