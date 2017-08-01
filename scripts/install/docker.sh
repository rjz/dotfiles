#!/bin/bash

DOCKER_FINGERPRINT='9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88'

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. ${DIR}/../functions/require_sudo && require_sudo

cmd_exists () {
  which "$1" > /dev/null
}

configure_apt () {
  apt-get update
  apt-get install apt-transport-https ca-certificates

  sudo add-apt-repository \

  # https://docs.docker.com/engine/installation/linux/ubuntulinux/
  curl https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

  sudo apt-key fingerprint 0EBFCD88 | grep "${DOCKER_FINGERPRINT}" || {
    echo 'Failed verifying key'
    exit 2
  }

  echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable" \
    > ${APT_SOURCE_DOCKER}

  echo '!'
  cat $APT_SOURCE_DOCKER

  apt-get update
}

APT_SOURCE_DOCKER=/etc/apt/sources.list.d/docker.list

install_docker () {
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

  apt-get install docker-ce
  usermod ${SUDO_USER} -aG docker

  echo 'Docker installed! Boot it up with:

      $ service docker start
      $ docker run hello-world
  '
}

install_docker_machine () {
  curl -L https://github.com/docker/machine/releases/download/v0.12.1/docker-machine-`uname -s`-`uname -m` > /tmp/docker-machine &&
    chmod +x /tmp/docker-machine &&
    sudo mv /tmp/docker-machine /usr/local/bin/docker-machine
}

install_docker_compose () {
  curl -L https://github.com/docker/compose/releases/download/1.14.0/docker-compose-`uname -s`-`uname -m` > /tmp/docker-compose &&
    chmod +x /tmp/docker-compose &&
    sudo mv /tmp/docker-compose /usr/local/bin/docker-compose
}

if cmd_exists docker; then
  echo 'docker is already installed -- skipping [re]install'
else
  install_docker
fi

if cmd_exists docker-machine; then
  echo 'docker-machine is already installed -- skipping [re]install'
else
  install_docker_machine
fi

if cmd_exists docker-compose; then
  echo 'docker-compose is already installed -- skipping [re]install'
else
  install_docker_compose
fi
