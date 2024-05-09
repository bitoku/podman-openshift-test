#!/usr/bin/env bash
#
# from https://github.com/haircommander/che-podman-fuse-demo/blob/main/entrypoint.sh

if [ ! -d "${HOME}" ]; then
  mkdir -p "${HOME}"
fi

if ! whoami &> /dev/null; then
  if [ -w /etc/passwd ]; then
    echo "${USER_NAME:-user}:x:$(id -u):0:${USER_NAME:-user} user:${HOME}:/bin/bash" >> /etc/passwd
    echo "${USER_NAME:-user}:x:$(id -u):" >> /etc/group
  fi
fi
USER=$(whoami)
START_ID=$(( $(id -u)+1 ))
echo "${USER}:${START_ID}:65535" > /etc/subuid
echo "${USER}:${START_ID}:65535" > /etc/subgid
exec "$@"
