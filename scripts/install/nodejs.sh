#!/bin/bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

. "${DIR}/../functions/require_sudo" && require_sudo

install_nodejs () {
  curl -sL https://deb.nodesource.com/setup_8.x | bash -
  apt-get install -y nodejs
}

which node > /dev/null || install_nodejs

npm config set prefix /usr/local/
