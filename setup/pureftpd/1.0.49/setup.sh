#!/usr/bin/env bash
### 2019-10-24 check
[ -e /opt/pureftpd ] && echo /opt/pureftpd 已經存在，部屬中止 && exit 1
### 2019-10-24 check
tar zxvf setup.tar.gz
chmod +x *sh
./install_pureftpd.sh

# 測試
cd /opt/pureftpd && sbin/pure-ftpd etc/pure-ftpd.conf || exit 1