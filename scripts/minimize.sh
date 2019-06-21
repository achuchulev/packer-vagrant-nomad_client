#!/usr/bin/env bash

# Reduce installed languages to just "en_US"
echo "==> Configuring locales"
apt -y purge language-pack-en language-pack-gnome-en
sed -i '/^[^# ]/s/^/# /' /etc/locale.gen
LANG=en_US.UTF-8
LC_ALL=$LANG
locale-gen --purge $LANG
update-locale LANG=$LANG LC_ALL=$LC_ALL

# Remove some packages to get a minimal install
echo "==> Removing all linux kernels except the currrent one"
dpkg --list 'linux-*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d' | xargs apt -y purge
echo "==> Removing linux source"
dpkg --list | awk '{print $2}' | grep linux-source | xargs apt -y purge
echo "==> Removing documentation"
dpkg --list | awk '{print $2}' | grep -- '-doc$' | xargs apt -y purge

# Clean up the apt cache
echo "==> Clean up the apt cache"
apt -y clean

echo "==> Removing APT files"
find /var/lib/apt -type f -exec rm -rf {} \;
echo "==> Removing caches"
find /var/cache -type f -exec rm -rf {} \;