#!/usr/bin/env bash
### 2019-10-24 check
[ -e /opt/python3 ] && echo /opt/python3 已經存在，部屬中止 && exit 1
### 2019-10-24 check

[ ! -e /usr/local/include/openssl ] && yum install -y openssl-devel

mkdir -p /opt/src
cd /opt/src
yum install -y gcc bzip2-devel libffi-devel zlib-devel wget make file
wget https://www.python.org/ftp/python/3.7.4/Python-3.7.4.tar.xz
rm -rf Python-3.7.4
tar Jxf Python-3.7.4.tar.xz
cd Python-3.7.4
./configure --prefix=/opt/python3
make && make install
ln -s /opt/python3/bin/python3 /usr/bin/python3
ln -s /opt/python3/bin/pip3 /usr/bin/pip3
rm -rf Python-3.7.4 Python-3.7.4.tar.xz

# 測試
python3 -V || exit 1
pip3 -V || exit 1
pip3 list | grep SSLError && exit 1
pip3 install -U pip
