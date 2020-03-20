#!/usr/bin/env bash
### 2019-10-24 check
[ -e /opt/nginx ] && echo /opt/nginx 已經存在，部屬中止 && exit 1
### 2019-10-24 check

rm -rf nginx_install
tar zxvf setup.tar.gz
cd nginx_install
sh install_nginx.sh
/opt/nginx/sbin/nginx
ps aux|grep nginx
/opt/nginx/sbin/nginx -s stop
/opt/nginx/sbin/nginx -V
111
