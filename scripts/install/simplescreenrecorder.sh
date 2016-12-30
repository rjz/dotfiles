#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. ${DIR}/../functions/require_sudo && require_sudo

add-apt-repository ppa:maarten-baert/simplescreenrecorder
apt-get update
apt-get install simplescreenrecorder
