#!/bin/bash

#rbd create newu --size 262144 --image-feature layering
#newu=`rbd map newu`
#mkfs.ext4 $newu
num=/mnt/$RANDOM
mkdir $num
mount $newu $num
ip=185.151.247.236
gate=185.151.247.1
debootstrap --include=sudo,nano,wget,gnupg,dirmngr,openssl,bridge-utils,openssh-server --arch amd64 bullseye $num http://deb.debian.org/debian/
auto ens3
cat <<EOF > /etc/fstab
iface bfg1 inet manual
auto br0
iface br0 inet static
    address $ip/24
    gateway $gate
    bridge_ports ens3
EOF
#cat <<EOF > /etc/fstab
#/dev/sda1 /     ext4    remount,rw      0       1
##/dev/sda2       none   swap    sw      0       0
#EOF
useradd user1
mkdir /home/user1
chown user1:wheek /home/user1
passwd user1
echo "user1    ALL=NOPASSWD: ALL" > /etc/sudoers
umount $num
jexec $num 255.255.255.0 $gate &d