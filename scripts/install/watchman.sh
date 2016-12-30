#!/bin/bash

WATCHMAN_VERSION_TAG=v4.7.0  # the latest stable release

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CWD=$(pwd)

. ${DIR}/../functions/require_sudo && require_sudo
. ${DIR}/../functions/repo && repo

[[ -d facebook ]] || mkdir facebook && cd facebook
git clone https://github.com/facebook/watchman.git

cd watchman
git checkout "${WATCHMAN_VERSION_TAG}"

./autogen.sh
./configure
make
sudo make install
cd "${CWD}"
