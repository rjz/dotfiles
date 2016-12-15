#!/bin/bash

VIMDIR="${HOME}/.vim"
BUNDLE_PATH="${VIMDIR}/bundle"
PATHOGEN_SOURCE=https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim

GITHUB_BUNDLES=(
  'bronson/vim-trailing-whitespace'
  'plasticboy/vim-markdown'
  'elzr/vim-json'
  'mxw/vim-jsx'
  'fatih/vim-go'
  'kchmck/vim-coffee-script'
  'chase/vim-ansible-yaml'
  'chrisbra/csv.vim'
  'leafgarland/typescript-vim'
  'vim-airline/vim-airline'
  'airblade/vim-gitgutter'
)

install_plugin () {
  local target="$BUNDLE_PATH/$(basename $repo)"
  if [[ -d "$target" ]]; then
    echo "'$repo' (vim plugin): Checking github for updates ..."
    ( cd $target && git fetch && git pull -q origin master )
  else
    echo "'$repo' (vim plugin): Installing from github..."
    git clone https://github.com/${repo}.git $target > /dev/null
  fi
}

# Check if vim exists
command -v vim > /dev/null || {
  # Can we find it in apt?
  if [ ! $(command -v apt) ]; then
    sudo apt-get install vim
  else
    echo "apt isn't available. Please install vim manually before continuing"
    exit 1
  fi
}

# Install pathogen
mkdir -p ${VIMDIR}/autoload ${VIMDIR}/bundle && \
  curl -LSso ${VIMDIR}/autoload/pathogen.vim $PATHOGEN_SOURCE

# Install vim plugins
for repo in ${GITHUB_BUNDLES[@]}; do
  install_plugin "$repo"
done
