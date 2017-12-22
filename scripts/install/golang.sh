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
  echo "$latest"
  gvm install "$latest"
  gvm use "$latest" --default
}

install_helpers() {
  echo 'Installing helpers'
  go get github.com/dsnet/gotab
  go get github.com/nsf/gocode
}

cmd_exists bison || sudo apt-get install bison
cmd_exists go || sudo apt-get install golang

export PATH="$PATH:${HOME}/.gvm/bin"
cmd_exists gvm || {
  echo 'Installing gvm'
  install_gvm
}

if [[ -s "$GVM_ROOT/scripts/gvm" ]]; then
  source "$GVM_ROOT/scripts/gvm"
fi

install_latest
install_helpers
