#!/usr/bin/env bash
### 2019-10-24 check
[ -e /opt/php71 ] && echo /opt/php71 已經存在，部屬中止 && exit 1
### 2019-10-24 check

tar zxvf setup.tar.gz
cd php71_install
chmod +x install_php71.sh
chmod +x conf_php71.sh
./install_php71.sh
./conf_php71.sh
id www || useradd -r -M -s /sbin/nologin www
/opt/php71/sbin/php-fpm
ps aux|grep php-fpm
pkill php-fpm
