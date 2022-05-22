#!/usr/bin/env bash

set -e

source "$SCRIPT_DIR/include/lib_log.sh"

function checkout_armbian_build() {
  log_info "checkout the Armbian Build Git repository"

  if [ ! -d "${GIT_BUILD_DIR}" ]; then
    git clone https://github.com/armbian/build "${GIT_BUILD_DIR}"
  fi

  sudo chown -R "${USER}:${USER}" "${GIT_BUILD_DIR}"

  cd "${GIT_BUILD_DIR}" && git clean -xdf
  cd "${GIT_BUILD_DIR}" && git fetch origin
  cd "${GIT_BUILD_DIR}" && git checkout master
  cd "${GIT_BUILD_DIR}" && git reset --hard origin/master
}
