#!/bin/bash

log() {
  echo "[install/ssh]: $@"
}

SSHDIR="${HOME}/.ssh"
SSHCONFIG="${SSHDIR}/config"

log "creating shared connection directory"
mkdir -p "${SSHDIR}/private"
chmod -R 0700 "${SSHDIR}"

if [[ -f "$SSHCONFIG" ]]; then
  log "$SSHCONFIG exists; skipping"
else
  log "creating $SSHCONFIG"
  cat > "$SSHCONFIG" <<EOF
# Reuse connections by default
Host *
  ControlMaster auto
  ControlPath ~/.ssh/private/ssh-%r@%h:%p
EOF
fi
