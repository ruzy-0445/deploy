#!/usr/bin/env bash
### 2019-10-24 check
[ -e /opt/redis ] && echo /opt/redis 已經存在，部屬中止 && exit 1
### 2019-10-24 check

VERSION="5.0.5"
PACKAGE="redis-$VERSION"

SRCDIR="/opt/src"
DESTDIR="/opt/redis"
CONFIG="$DESTDIR/conf/redis.conf"
USER="redis"

[ ! -d $SRCDIR ] && mkdir -p $SRCDIR
cd $SRCDIR || exit 1

curl -O -L "http://download.redis.io/releases/$PACKAGE.tar.gz"
tar -xzf "$PACKAGE.tar.gz"
cd $PACKAGE || exit 1

yum install -y gcc

if ! id $USER; then
  useradd -r -s /sbin/nologin -M $USER
fi

make PREFIX=$DESTDIR install

mkdir -p $DESTDIR/{conf,bin,logs,pid}
chown -R $USER: $DESTDIR
cp -a redis.conf $CONFIG
chmod 644 $CONFIG

#sed -i "s|bind 127.0.0.1|bind 0.0.0.0|" $CONFIG
sed -i "s|# requirepass foobared|requirepass $(openssl rand -base64 16 | tr -d '=+/')|" $CONFIG
sed -i "s|daemonize no|daemonize yes|" $CONFIG
sed -i "s|pidfile /var/run/redis_6379.pid|pidfile \"$DESTDIR/pid/redis_6379.pid\"|" $CONFIG
sed -i "s|logfile \"\"|logfile \"$DESTDIR/logs/redis_6379.log\"|" $CONFIG
sed -i "s|dbfilename dump.rdb|dbfilename redis_6379_dump.rdb|" $CONFIG
sed -i "s|dir ./|dir \"$DESTDIR\"|" $CONFIG

PASSWORD=$(grep "^requirepass" $CONFIG |cut -d " " -f2)
echo "redis password: $PASSWORD"
echo "###########################"
echo "### start redis service ###"
echo "cd $DESTDIR && sudo -u $USER bin/redis-server conf/redis.conf"
echo "### start redis service ###"
echo "###########################"
echo "### check redis service ###"
echo "cd $DESTDIR && bin/redis-cli -a $PASSWORD ping"
echo "### check redis service ###"
echo "###########################"
echo "### stop redis service ###"
echo "cd $DESTDIR && kill "'$(cat pid/redis_6379.pid)'
echo "### stop redis service ###"