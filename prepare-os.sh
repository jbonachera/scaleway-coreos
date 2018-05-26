#!/bin/bash

URL="https://raw.githubusercontent.com/coreos/init/master/bin/coreos-install"
apt update
apt install -y wget bzip2
rm -rf /var/cache/apt/*
curl -sLo /usr/bin/coreos-install  $URL
chmod +x /usr/bin/coreos-install
coreos-install -d /dev/vda -C stable -i ignition.json
