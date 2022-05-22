#!/usr/bin/env bash

set -e

source "$SCRIPT_DIR/include/lib_log.sh"

function set_default_env() {
  log_info "set default environment variables"

  export TMP_DIR="${PWD}/tmp"

  if [ -f "${PWD}/.env" ]; then
    source "${PWD}/.env"
  fi
}

function set_git_env() {
  log_info "set GIT environment variables"

export GIT_BUILD_DIR="${TMP_DIR}/build"
}

function set_env() {
  log_info "set environment variables"

  set_default_env
  set_git_env
}
