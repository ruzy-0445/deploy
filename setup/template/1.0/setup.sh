#!/usr/bin/env bash
### 2019-10-24 check
[ -e /opt/template ] && echo /opt/template 已經存在，部屬中止 && exit 1
### 2019-10-24 check
mkdir -p /opt/template