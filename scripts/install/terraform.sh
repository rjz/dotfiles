#!/bin/bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. ${DIR}/../functions/require_sudo && require_sudo

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
ZIP_PATH="${INSTALL_DIR}/${ZIP}"

mkdir -p "${INSTALL_DIR}"

[[ -f "${ZIP_PATH}" ]] || wget -O "${ZIP_PATH}" "${URL}"
[[ -x "${INSTALL_DIR}/terraform" ]] || unzip "${ZIP_PATH}" -d "${INSTALL_DIR}"

(
  cd terraform
  find -type f -executable -exec ln -s "${INSTALL_DIR}"/{} /usr/local/bin/{} \;
)
