#!/bin/sh

# Fetch all released versions (rc-x will be ignored)
VERSIONS=$(curl -s https://releases.hashicorp.com/terraform/ \
  | grep -oP 'terraform/\d+\.\d+\.\d+\/' \
  | cut -f2 -d/)
LAST_VERSION=$(echo "${VERSIONS}" \
  | sort --version-sort \
  | tail -n1)

PLATFORM=linux_amd64
ZIP=terraform_${LAST_VERSION}_${PLATFORM}.zip
URL=https://releases.hashicorp.com/terraform/${LAST_VERSION}/${ZIP}

INSTALL_DIR="$(pwd)/terraform"

mkdir -f "${INSTALL_DIR}"

wget -O "${INSTALL_DIR}"/${ZIP} ${URL}

find -name 'terraform*' -executable -exec ln -s "${INSTALL_DIR}"/{} /usr/local/bin/{} \;
