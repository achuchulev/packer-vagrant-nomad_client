#!/usr/bin/env bash

killall apt apt-get
rm /var/lib/apt/lists/lock
rm /var/cache/apt/archives/lock
rm /var/lib/dpkg/lock*
dpkg --configure -a

apt update
export DEBIAN_FRONTEND=noninteractive

apt install --no-install-recommends -y docker.io
apt install --no-install-recommends -y default-jre

docker run hello-world &>/dev/null && echo docker hello-world works