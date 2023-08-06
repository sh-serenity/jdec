#!/bin/bash
mkdir -p /guests/$1 && \
chmod 0777 /guests/$1 && \
debootstrap --include=sudo,nano,wget,gnupg,dirmngr,openssl,bridge-utils --arch amd64 bullseye /guests/$1 http://deb.debian.org/debian/
if=ens3
HOST=$1
#/sbin/lvcreate -L +600G -n $HOST j
mkdir -p /guests/$1 && \
chmod 0777 /guests/$1 && \
mkdir -p /guests/$1/root/.ssh
cp -r /root/.ssh/ /guests/$1/root/
debootstrap --include=sudo,nano,wget,gnupg,dirmngr,openssl,bridge-utils,openssh-server --arch amd64 bullseye /guests/$1 http://deb.debian.org/debian/
cp mon1.sh /guests/$1
chroot /guests/$1 bash /mon1.sh
echo $1 > /guests/$1/etc/hostname
