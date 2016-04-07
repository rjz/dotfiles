#!/bin/bash

if [[ -z ${SUDO_USER} ]]; then
  echo "This script must be run under sudo" 1>&2
  exit 1
fi

configure_apt () {
  #apt-get update
  apt-get install apt-transport-https ca-certificates

  # https://docs.docker.com/engine/installation/linux/ubuntulinux/
  apt-key adv \
    --keyserver hkp://p80.pool.sks-keyservers.net:80 \
    --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

  echo "deb https://apt.dockerproject.org/repo ubuntu-${UBUNTU_CODENAME} main" \
    > ${APT_SOURCE_DOCKER}

  apt-get update
}

UBUNTU_CODENAME=$(lsb_release -a 2>/dev/null \
                  | grep Codename: \
                  | cut -d: -f2 \
                  | tr -d '\t')

APT_SOURCE_DOCKER=/etc/apt/sources.list.d/docker.list

which docker && {
  echo 'Docker is already installed -- skipping [re]install'
  exit 1
}

test -f ${APT_SOURCE_DOCKER} || {
  configure_apt || {
    rm -rf ${APT_SOURCE_DOCKER}
    echo 'Failed configuring apt'
    exit 1
  }
}

apt-cache policy docker-engine > /dev/null || {
  echo 'Apt not configured correctly, bailing out'
  exit 1
}

usermod ${SUDO_USER} -aG rj

echo 'Docker installed!'
