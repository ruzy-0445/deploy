#!/usr/bin/env bash
### 2019-10-24 check
[ -e /usr/local/include/openssl ] && echo /usr/local/include/openssl 已經存在，部屬中止 && exit 1
### 2019-10-24 check


VERSION="1.1.1d"
PACKAGE="openssl-$VERSION"

SRCDIR="/opt/src"

yum groupinstall -y 'Development Tools'

[ ! -d $SRCDIR ] && mkdir -p $SRCDIR
cd $SRCDIR || exit 1
curl -O -L "https://www.openssl.org/source/$PACKAGE.tar.gz"
tar -xzf "$PACKAGE.tar.gz"
cd $PACKAGE || exit 1

./config
make
make install

echo "/usr/local/lib64" > /etc/ld.so.conf.d/openssl.conf

ldconfig
openssl version

