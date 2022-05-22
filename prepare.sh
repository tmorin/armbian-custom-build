#!/usr/bin/env bash

SCRIPT_SRC=${BASH_SOURCE[0]}
while [ -L "$SCRIPT_SRC" ]; do # resolve $SCRIPT_SRC until the file is no longer a symlink
  SCRIPT_DIR=$( cd -P "$( dirname "$SCRIPT_SRC" )" >/dev/null 2>&1 && pwd )
  SCRIPT_SRC=$(readlink "$SCRIPT_SRC")
  [[ $SCRIPT_SRC != /* ]] && SCRIPT_SRC=$SCRIPT_DIR/$SCRIPT_SRC # if $SCRIPT_SRC was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
SCRIPT_DIR=$( cd -P "$( dirname "$SCRIPT_SRC" )" >/dev/null 2>&1 && pwd )

set -e

source "$SCRIPT_DIR/include/lib_env.sh"
source "$SCRIPT_DIR/include/lib_git.sh"

set_env

mkdir -p "${TMP_DIR}"

checkout_armbian_build
