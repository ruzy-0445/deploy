#!/usr/bin/env bash
### 2019-10-24 check
[ -e /opt/chkrootkit ] && echo /opt/chkrootkit 已經存在，部屬中止 && exit 1
### 2019-10-24 check
#mkdir -p /opt/template

curl -O -L ftp://ftp.pangeia.com.br/pub/seg/pac/chkrootkit.tar.gz > /dev/null 2>&1
tar -xzf chkrootkit.tar.gz
cd chkrootkit-*
yum install -y gcc bc-static glibc-static  > /dev/null 2>&1
make sense  > /dev/null 2>&1
./chkrootkit -q
