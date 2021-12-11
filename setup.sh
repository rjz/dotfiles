#!/bin/bash

# http://stackoverflow.com/a/246128/1040371
DIR="$( cd "$( dirname "$0" )" && pwd )"

APT_PACKAGES=(
  tmux
  python-pygments
  bats
  build-essential
  jq
  curl
  nmap
  whois
  uuid
  awscli
  fortune
  exuberant-ctags
  vim-gtk `# clipboard support for normal vim`
)

fatal () {
  echo "FATAL: '$1'"
  exit 2
}


# Install dependencies (ubuntu)
install_packages () {
  for pkg in "${APT_PACKAGES[@]}"; do
    echo "INSTALLING $pkg..."
    sudo apt-get install $pkg
  done
}

install_dotfiles () {
  # Copy files to home directory
  for p in $(find `pwd` -maxdepth 1 -type f \
    | grep -v setup.sh \
    | grep -v screenshot.png \
    | grep -v README.md
  ); do
    local f="$(basename "$p")"
    local dst="$HOME/.$f"
    local src="$DIR/$f"
    echo "linking ${src} => $dst"
    if [[ "$(readlink ${dst})" != "$src" ]]; then
      rm -rf $dst
      ln -s ${src} $dst
    fi
  done
}

sudo apt-get update
sudo apt-get upgrade
sudo apt-get autoremove

install_packages || fatal 'installing packages'
install_dotfiles
${DIR}/scripts/install/vim.sh

if [ $(uname) = 'Darwin' ]; then
  # fix xterm
  cp inputrc ~/.inputrc
fi
