#!/bin/bash

WATCHMAN_VERSION_TAG=v4.7.0  # the latest stable release

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CWD=$(pwd)

if [[ -z ${SUDO_USER} ]]; then
  echo "This script must be run under sudo" 1>&2
  exit 1
fi

# Switch to repositories directory
. "${DIR}/../functions/repo" && repo

[[ -d facebook ]] || mkdir facebook && cd facebook
git clone https://github.com/facebook/watchman.git

cd watchman
git checkout "${WATCHMAN_VERSION_TAG}"

./autogen.sh
./configure
make
sudo make install
cd "${CWD}"
