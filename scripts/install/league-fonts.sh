#!/bin/bash

URLS=(
  'https://www.theleagueofmoveabletype.com/chunk/download'
  'https://www.theleagueofmoveabletype.com/league-spartan/download'
  'https://www.theleagueofmoveabletype.com/league-gothic/download'
  'https://www.theleagueofmoveabletype.com/function/download'
  'https://www.theleagueofmoveabletype.com/fanwood/download'
  'https://www.theleagueofmoveabletype.com/linden-hill/download'
  'https://www.theleagueofmoveabletype.com/raleway/download'
  'https://www.theleagueofmoveabletype.com/prociono/download'
  'https://www.theleagueofmoveabletype.com/goudy-bookletter-1911/download'
  'https://www.theleagueofmoveabletype.com/sorts-mill-goudy/download'
)

# See: https://askubuntu.com/a/191782
FONTSDIR="${HOME}/.local/share/fonts"

mkdir -p ${FONTSDIR}

echo "Installing fonts from The League of Movable Type"
echo "https://www.theleagueofmoveabletype.com"

cd /tmp
for url in ${URLS[@]}; do
  URL=$(wget --trust-server-names -nc $url 2>&1 | grep -oE 'files.theleague.*\.zip')
  if [[ -z $URL ]]; then
    echo "Failed retrieving ${url}"
  else
    FILE="$(basename $URL)"
    echo "Unzipping $FILE"
    unzip -n $FILE -d $FONTSDIR > /dev/null
  fi
done

echo "Rebuilding font cache"
fc-cache -f -v > /dev/null

echo "All set!"
