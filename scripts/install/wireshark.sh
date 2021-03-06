#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. ${DIR}/../functions/require_sudo && require_sudo

apt-get install wireshark
dpkg-reconfigure wireshark-common
usermod ${SUDO_USER} -aG wireshark
