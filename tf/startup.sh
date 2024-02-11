#!/bin/sh

sudo echo "alias l='ls -latFrh'" >> /root/.bashrc
sudo echo "alias vi='vim'"       >> /root/.bashrc
sudo echo "set background=dark"  >> /root/.vimrc
sudo echo "syntax on"            >> /root/.vimrc

#yum install -y mlocate bind-utils git make jq vim-enhanced deltarpm

systemctl stop firewalld
systemctl disable firewalld

sed -i 's/^SELINUX=.*/SELINUX=permissive/g' /etc/selinux/config
setenforce 0

