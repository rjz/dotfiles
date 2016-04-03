#!/bin/bash

if [[ -z ${SUDO_USER} ]]; then
  echo "This script must be run under sudo" 1>&2
  exit 1
fi

apt-get install wireshark
dpkg-reconfigure wireshark-common
usermod ${SUDO_USER} -aG wireshark
