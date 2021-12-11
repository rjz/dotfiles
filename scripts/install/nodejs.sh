#!/bin/bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

install_nvm () {
  curl -so- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash

  # Add it to the session immediately
  export NVM_DIR="$HOME/.config/nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
}

install_nodejs () {
  nvm install --lts
  nvm use node
}

which nvm > /dev/null || install_nvm
which node > /dev/null || install_nodejs
