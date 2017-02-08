#!/bin/bash -eux

set -e
curl -L -o /tmp/jdk-8.rpm -b "oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u121-b13/e9e7ea248e2c4826b92b3f075a80e441/jdk-8u121-linux-x64.rpm"
yum localinstall -y /tmp/jdk-8.rpm

echo "Check installation"
java -version
javac -version
