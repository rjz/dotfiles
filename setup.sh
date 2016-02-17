#!/bin/bash

# http://stackoverflow.com/a/246128/1040371
DIR="$( cd "$( dirname "$0" )" && pwd )"

# Install dependencies (ubuntu)
function install_packages () {
  for pkg in tmux vim python-pygments build-essentials; do
    sudo apt-get install $pkg
  done
}

function install_vim_plugins () {

  # Install pathogen
  PATHOGEN_SOURCE=https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim
  mkdir -p ~/.vim/autoload ~/.vim/bundle && \
    curl -LSso ~/.vim/autoload/pathogen.vim $PATHOGEN_SOURCE

  BUNDLE_PATH="$HOME/.vim/bundle"

  # Install vim plugins
  for repo in \
    plasticboy/vim-markdown \
    elzr/vim-json \
    mxw/vim-jsx \
    fatih/vim-go \
    kchmck/vim-coffee-script \
    chase/vim-ansible-yaml \
    chrisbra/csv.vim \
    leafgarland/typescript-vim \
    vim-airline/vim-airline \
    airblade/vim-gitgutter \
  ; do
    target="$BUNDLE_PATH/$(basename $repo)"
    if [[ -d "$target" ]]; then
      echo "'$repo' (vim plugin): Checking github for updates ..."
      bash -c "cd $target && git fetch && git pull -q origin master && cd $DIR"
    else
      echo "'$repo' (vim plugin): Installing from github..."
      git clone https://github.com/${repo}.git $target > /dev/null
    fi
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

install_vim_plugins

