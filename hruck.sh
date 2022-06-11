#!/bin/bash
mkdir -p /guests/$1 && \
chmod 0777 /guests/$1 && \
debootstrap --include=sudo,nano,wget,gnupg,dirmngr,openssl,bridge-utils --arch amd64 bullseye /guests/$1 http://deb.debian.org/debian/
