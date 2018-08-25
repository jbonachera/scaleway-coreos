#!/bin/bash

set -e

MD_VERSION="v0.0.12"
URL="https://raw.githubusercontent.com/coreos/init/master/bin/coreos-install"

MD_URL="https://github.com/jbonachera/scaleway-coreos-custom-metadata/releases/download/${MD_VERSION}/scaleway-coreos-custom-metadata"

# Make some space
apt remove -y vim libpython3.5 vim-common vim-runtime

apt update
apt install -y wget bzip2
rm -rf /var/cache/apt/*
curl -sLo /usr/bin/coreos-install  $URL
chmod +x /usr/bin/coreos-install
coreos-install -d /dev/vda -C stable -i ignition.json

echo ":: installing custom md agent on OEM partition"
mkdir /mnt/oem
mount /dev/vda6 /mnt/oem
curl -sLo /mnt/oem/scaleway-coreos-custom-metadata $MD_URL
chmod +x /mnt/oem/scaleway-coreos-custom-metadata
umount /dev/vda6
