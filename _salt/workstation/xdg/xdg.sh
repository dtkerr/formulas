#!/bin/sh
# XDG Base Directory env values, as well as application specific configuration
# to try and make non-compliant apps use the XDG dirs anyway.

export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local"

# config
export BASH_COMPLETION_USER_FILE="${XDG_CONFIG_HOME}/bash-completion/bash_completion"
export BUNDLE_USER_CONFIG="${XDG_CONFIG_HOME}/bundle"
export CABAL_CONFIG="${XDG_CONFIG_HOME}/cabal/config"
export DOCKER_CONFIG="${XDG_CONFIG_HOME}/docker"
export GTK2_RC_FILES="${XDG_CONFIG_HOME}/gtk-2.0/gtkrc"
export IPYTHONDIR="${XDG_CONFIG_HOME}/jupyter"
export JUPYTER_CONFIG_DIR="${XDG_CONFIG_HOME}/jupyter"
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/npmrc"

# cache
export BUNDLE_USER_CACHE="${XDG_CACHE_HOME}/bundle"
export CABAL_DIR="${XDG_CACHE_HOME}/cabal"
export CUDA_CACHE_PATH="${XDG_CACHE_HOME}/nv"
export PSQL_HISTORY="${XDG_CACHE_HOME}/psql_history"
export PYTHON_EGG_CACHE="${XDG_CACHE_HOME}/python-eggs"
export RANDFILE="${XDG_CACHE_HOME}/rnd"
export SQLITE_HISTORY="${XDG_CACHE_HOME}/sqlite_history"
export GEM_SPEC_CACHE="${XDG_CACHE_HOME}/gem"

# data
export BUNDLE_USER_PLUGIN="${XDG_DATA_HOME}/bundle"
export CARGO_HOME="${XDG_DATA_HOME}/cargo"
export GOPATH="${XDG_DATA_HOME}/go"
export IPFS_PATH="${XDG_DATA_HOME}/ipfs"
export TERMINFO="${XDG_DATA_HOME}/terminfo"
export TERMINFO_DIRS="${XDG_DATA_HOME}/terminfo:/usr/share/terminfo"
export NODE_REPL_HISTORY="${XDG_DATA_HOME}/node_repl_history"
export PLTUSERHOME="${XDG_DATA_HOME}/racket"
export REDISCLI_HISTFILE="${XDG_DATA_HOME}/redis/rediscli_history"
export RLWRAP_HOME="${XDG_DATA_HOME}/rlwrap"
export RUSTUP_HOME="${XDG_DATA_HOME}/rustup"
export STACK_ROOT="${XDG_DATA_HOME}/stack"
export WORKON_HOME="${XDG_DATA_HOME}/venvs"
export SSB_HOME="${XDG_DATA_HOME}/zoom"
export GEM_HOME="${XDG_DATA_HOME}/gem"
