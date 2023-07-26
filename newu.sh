#!/bin/bash
pass=$5
name=$4
#echo "creating rdb imgee"
#rbd create $name --size 1500000  --image-feature layering
#newu=`rbd map $name`
#echo "making filesysten"
#mkfs.ext4 $newu
num=/mnt/$3
mkdir /mnt/$num
#mount $newu $num
ip=$1
gate=$2
echo "installing debian bullsye"
debootstrap --include=sudo,nano,wget,gnupg,dirmngr,openssl,bridge-utils,openssh-server,ca-certificates --arch amd64 bullseye $num http://deb.debian.org/debian/
#cat <<EOF > /etc/fstab
#auto bfg1
#iface bfg1 inet manual
#auto br0
#iface br0 inet static
#    address $ip/24
#    gateway $gate
#    bridge_ports bfg1
#EOF
#cat <<EOF > /etc/fstab
#/dev/sda1 /     ext4    remount,rw      0       1
##/dev/sda2       none   swap    sw      0       0
#EOF
#useradd $name
#mkdir /home/$name
#chown $name:wheel /home/user1
#passwd $name
#cho "$name    ALL=NOPASSWD: ALL" > /etc/sudoers
#umount $num
#echo "executing"
#./jdec $num $ip 255.255.255.0 $gate &
cp /fjdec/post.sh $num 
chroot $num bash post.sh $ip $gate $name $num $pass
#cp sshd_config $num//etc/ssh/
echo $passwd
/fjdec//jdec $num $ip 255.255.255.0 $gate &