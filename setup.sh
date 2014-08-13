# http://stackoverflow.com/a/246128/1040371
DIR="$( cd "$( dirname "$0" )" && pwd )"

# Install dependencies (ubuntu)
for pkg in tmux vim python-pygments; do
  sudo apt-get install $pkg
done

# Copy files to home directory
for f in *; do
  if [ "$f" != "setup.sh" ]; then
    target="$HOME/.$f"
    rm -ri $target
    ln -s "$DIR/$f" $target
  fi
done

