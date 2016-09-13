#!/bin/bash -eux

set -e

sudo yum -y update

sudo echo "elasticsearch soft nofile 128000" > /etc/security/limits.conf
sudo echo "elasticsearch hard nofile 128000" > /etc/security/limits.conf
sudo echo "root soft nofile 128000" > /etc/security/limits.conf
sudo echo "root hard nofile 128000" > /etc/security/limits.conf

sudo echo "fs.file-max = 500000" > /etc/sysctl.conf