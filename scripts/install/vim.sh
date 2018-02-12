#!/bin/bash

VIMDIR="${HOME}/.vim"
BUNDLE_PATH="${VIMDIR}/bundle"
PATHOGEN_SOURCE=https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim

GITHUB_BUNDLES=(
  'bronson/vim-trailing-whitespace'
  'jonathanfilip/vim-lucius'
  'scrooloose/nerdtree'
  'vim-airline/vim-airline'
  'airblade/vim-gitgutter'
  'aperezdc/vim-template'
  'fholgado/minibufexpl.vim'
  'ctrlpvim/ctrlp.vim'
  'sheerun/vim-polyglot'
)

log() {
  echo "[install/vim]: $@"
}

install_vim () {
  command -v vim > /dev/null || {
    log 'vim not available. Attempting apt install'
    if [ ! $(command -v apt) ]; then
      sudo apt-get install vim
    else
      log "apt isn't available. Please install vim manually before continuing"
      exit 1
    fi
  }
}

install_pathogen () {
  log 'installing pathogen'
  mkdir -p ${VIMDIR}/autoload ${VIMDIR}/bundle && \
    curl -LSso ${VIMDIR}/autoload/pathogen.vim $PATHOGEN_SOURCE
}

install_plugin () {
  local target="$BUNDLE_PATH/$(basename $repo)"
  if [[ -d "$target" ]]; then
    log "plugin: checking for updates to '$repo' ..."
    ( cd $target && git fetch && git pull -q origin master > /dev/null )
  else
    log "plugin: installing '$repo' ..."
    git clone https://github.com/${repo}.git $target > /dev/null
  fi
}

create_helptags () {
  log 'Adding :helptags'
  vim -c "$(find "$BUNDLE_PATH" -type d -name doc | sed 's/^/:helptags /')
q"
}

install_vim
install_pathogen

for repo in ${GITHUB_BUNDLES[@]}; do
  install_plugin "$repo"
done

create_helptags
