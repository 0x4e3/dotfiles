#!/usr/bin/env bash

set -e

# Exporting the specific shell we want to work with:

SHELL='/bin/bash'
export SHELL

# Standard dotbot pre-configuration:

readonly DOTBOT_DIR='dotbot'
readonly DOTBOT_BIN='bin/dotbot'
readonly BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

readonly ARGS="$@"

cd "$BASEDIR"
git submodule sync --quiet --recursive
git submodule update --init --recursive

# Linking dotfiles:

run_dotbot () {
  local config
  config="$1"

  "$BASEDIR/$DOTBOT_DIR/$DOTBOT_BIN" \
    -d "$BASEDIR" \
    --plugin-dir dotbot-brewfile \
    --plugin-dir dotbot-git \
    --plugin-dir dotbot-pip \
    -c "$config" $ARGS
}

run_dotbot 'installation/shell.yaml' || true
run_dotbot 'installation/git.yaml' || true
run_dotbot 'installation/brew.yaml' || true
run_dotbot 'installation/python.yaml' || true
run_dotbot 'installation/iTerm.yaml' || true
run_dotbot 'installation/vim.yaml' || true
run_dotbot 'installation/config.yaml' || true
run_dotbot 'installation/defaults.yaml' || true
