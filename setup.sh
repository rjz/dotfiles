#!/bin/bash

# http://stackoverflow.com/a/246128/1040371
DIR="$( cd "$( dirname "$0" )" && pwd )"

# Install dependencies (ubuntu)
function install_packages () {
  for pkg in tmux python-pygments build-essentials; do
    sudo apt-get install $pkg
  done
}


function install_dotfiles () {
  # Copy files to home directory
  for f in *; do
    if [ "$f" != "setup.sh" ]; then
      target="$HOME/.$f"
      if [[ `readlink ${target}` != "$DIR/$f" ]]; then
        rm -ri $target
        ln -s "$DIR/$f" $target
      fi
    fi
  done
}

./scripts/install/vim.sh

