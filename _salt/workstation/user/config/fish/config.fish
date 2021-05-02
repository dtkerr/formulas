#!/bin/fish
set -g fish_greeting

set -g GTK_IM_MODULE ibus
set -g QT_IM_MODULE  ibus
set -g XMODIFIERS    @im=ibus

set -g PATH $PATH $HOME/.local/bin $HOME/.local/rvm/bin
set -x EDITOR                     /usr/bin/nvim
set -x GDK_BACKEND                wayland
set -x VIRTUAL_ENV_DISABLE_PROMPT 1

alias ip="ip -c"
alias pacman="sudo pacman"
alias ssh="env TERM=xterm-256color ssh"

fish_ssh_agent
