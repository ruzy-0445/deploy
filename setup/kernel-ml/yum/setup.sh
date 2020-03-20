#!/usr/bin/env bash
### 2019-10-24 check
rpm -q kernel-ml && echo kernel-ml 已經存在，部屬中止 && exit 0
### 2019-10-24 check

rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-2.el7.elrepo.noarch.rpm
rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
yum -y --enablerepo=elrepo-kernel install kernel-ml
grub2-editenv list
grub2-set-default 0
grub2-mkconfig -o /boot/grub2/grub.cfg
grub2-editenv list

# 範例
echo "重新啟動系統後生效"
echo "使用uname -sr確認核心版本"
