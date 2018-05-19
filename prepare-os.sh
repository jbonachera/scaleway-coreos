#!/bin/bash

URL="https://raw.githubusercontent.com/coreos/init/master/bin/coreos-install"
curl -vLo /usr/bin/coreos-install  $URL
chmod +x /usr/bin/coreos-install
apt-get update
apt-get install -y bzip2
coreos-install -d /dev/vdb -C stable -i ignition.json
