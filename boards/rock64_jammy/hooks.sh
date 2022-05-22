#!/usr/bin/env bash

source "$SCRIPT_DIR/include/lib_log.sh"

function before_execute() {
  log_info "before execute"
}

function after_execute() {
  log_info "after execute"
}
