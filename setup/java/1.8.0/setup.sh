#!/usr/bin/env bash
### 2019-10-24 check
[ -e /opt/java ] && echo /opt/java 已經存在，部屬中止 && exit 1
### 2019-10-24 check

mkdir -p /opt/src
cd /opt/src
yum install -y wget
wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.tar.gz" 2> /dev/null
tar zxf jdk-8u131-linux-x64.tar.gz
mv jdk1.8.0_131/ /opt/java
grep JAVA_HOME /etc/profile && echo JAVA_HOME 已經存在，部屬中止 && exit 1
cat << EOF >> /etc/profile
JAVA_HOME=/opt/java/
CLASSPATH=.:\$JAVA_HOME/jre/lib/ext:\$JAVA_HOME/jre/lib/rt.jar:\$JAVA_HOME/lib/dt.jar:\$JAVA_HOME/lib/tools.jar
PATH=.:\$JAVA_HOME/bin:$PATH
export JAVA_HOME CLASSPATH PATH
EOF
source /etc/profile
java -version 2>&1|| exit 1
rm -f jdk-8u131-linux-x64.tar.gz
