# http://stackoverflow.com/a/246128/1040371
DIR="$( cd "$( dirname "$0" )" && pwd )"

# Install dependencies (ubuntu)
for pkg in tmux vim python-pygments build-essentials; do
  sudo apt-get install $pkg
done

# Install pathogen
PATHOGEN_SOURCE=https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
  curl -LSso ~/.vim/autoload/pathogen.vim $PATHOGEN_SOURCE

# Install vim plugins
git clone https://github.com/chase/vim-ansible-yaml.git ~/.vim/bundle/vim-ansible-yaml
git clone https://github.com/kchmck/vim-coffee-script.git ~/.vim/bundle/vim-coffee-script
git clone https://github.com/mxw/vim-jsx.git ~/.vim/bundle/vim-jsx
git clone https://github.com/elzr/vim-json.git ~/.vim/bundle/vim-json

# Copy files to home directory
for f in *; do
  if [ "$f" != "setup.sh" ]; then
    target="$HOME/.$f"
    rm -ri $target
    ln -s "$DIR/$f" $target
  fi
done

