#!/bin/bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cmd_exists () {
  which "$1" > /dev/null
}

install_gvm() {
  bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
}

install_latest() {
  local latest=$(gvm listall \
    | sed 's/\s*//' | grep -xE 'go[0-9]+\.[0-9]+' | sort | tail -n1)
  export GOROOT_BOOTSTRAP=$(dirname $(dirname $(readlink -f $(which go))))
  echo $GOROOT_BOOTSTRAP
  gvm install "$latest"
}

cmd_exists bison || sudo apt-get install bison
cmd_exists go || sudo apt-get install golang

export PATH="$PATH:${HOME}/.gvm/bin"
cmd_exists gvm || {
  echo 'Installing gvm'
  install_gvm
}

if [[ -z "$GVM_ROOT" ]]; then
  source ${HOME}/.gvm/scripts/gvm
fi

install_latest
