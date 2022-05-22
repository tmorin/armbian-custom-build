#!/usr/bin/env bash

set -e

function log_info() {
  local message="$1"
  echo "[info] ${message}"
}

function log_error() {
  local message="$1"
  echo "[error] ${message}"
}