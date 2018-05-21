#!/bin/bash

URL="https://raw.githubusercontent.com/coreos/init/master/bin/coreos-install"
pacman -Sy --noconfirm curl bzip2 wget
curl -sLo /usr/bin/coreos-install  $URL
chmod +x /usr/bin/coreos-install
coreos-install -d /dev/vdb -C stable -i ignition.json
