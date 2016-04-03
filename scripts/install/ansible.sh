#!/bin/bash

if [[ -z ${SUDO_USER} ]]; then
  echo "This script must be run under sudo" 1>&2
  exit 1
fi

apt-get install software-properties-common
apt-add-repository ppa:ansible/ansible
apt-get update
apt-get install ansible
