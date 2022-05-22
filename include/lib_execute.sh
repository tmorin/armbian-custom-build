#!/usr/bin/env bash

set -e

source "$SCRIPT_DIR/include/lib_log.sh"

function read_arguments() {
  local file_path="$1"
  sed '/^#/d' "${file_path}"
}

function start_vagrant {
  #vagrant plugin install vagrant-disksize
  cd "${GIT_BUILD_DIR}/config/templates" && vagrant up
}

function stop_vagrant {
  cd "${GIT_BUILD_DIR}/config/templates" && vagrant halt
}

function execute_armbian_build() {
  local board_config_name="$1"
  if [ -z "${board_config_name}" ]; then
    log_error "the config name cannot is not set!"
    exit 1
  fi

  local board_arguments_path="$SCRIPT_DIR/boards/${board_config_name}/arguments.properties"
  if [ ! -f "${board_arguments_path}" ]; then
    log_error "the config file '${board_arguments_path}' cannot be found!"
    exit 1
  fi

  local board_hooks_path="$SCRIPT_DIR/boards/${board_config_name}/hooks.sh"
  if [ ! -f "${board_hooks_path}" ]; then
    log_error "the config file '${board_hooks_path}' cannot be found!"
    exit 1
  fi

  # shellcheck source=boards/*
  source "${board_hooks_path}"

  log_info "execute ${board_config_name}"

  local arguments
  arguments=$(read_arguments "${board_arguments_path}")

  before_execute

  start_vagrant

  local ssh_command="cd armbian && sudo ./compile.sh ${arguments//$'\n'/ }"

  echo vagrant ssh -c "$ssh_command"

  vagrant ssh -c "$ssh_command"

  stop_vagrant

  sudo chown -R "${USER}:${USER}" "${GIT_BUILD_DIR}"

  after_execute
}
