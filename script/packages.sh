mkdir -p /etc/dpkg/dpkg.cfg.d
cat >/etc/dpkg/dpkg.cfg.d/01_nodoc <<EOF
path-exclude /usr/share/doc/*
path-include /usr/share/doc/*/copyright
path-exclude /usr/share/man/*
path-exclude /usr/share/groff/*
path-exclude /usr/share/info/*
path-exclude /usr/share/lintian/*
path-exclude /usr/share/linda/*
EOF

export DEBIAN_FRONTEND=noninteractive
export APTARGS="-qq -o=Dpkg::Use-Pty=0"

apt clean ${APTARGS}
apt update ${APTARGS}

apt upgrade -y ${APTARGS}
apt dist-upgrade -y ${APTARGS}

# Update to the latest kernel
apt install -y linux-generic linux-image-generic ${APTARGS}

# pip
apt install -y python-pip ${APTARGS}
apt install -y python3-pip ${APTARGS}

# git
apt install -y git ${APTARGS}

# jq
apt install -y jq ${APTARGS}

# curl
apt install -y curl ${APTARGS}

# wget
apt install -y wget ${APTARGS}

# vim
apt install -y vim ${APTARGS}

# unzip
apt install -y unzip ${APTARGS}

# Hide Ubuntu splash screen during OS Boot, so you can see if the boot hangs
apt remove -y plymouth-theme-ubuntu-text
sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="quiet"/GRUB_CMDLINE_LINUX_DEFAULT=""/' /etc/default/grub
update-grub

# Reboot with the new kernel
shutdown -r now