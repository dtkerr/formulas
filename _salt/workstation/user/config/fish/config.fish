#!/bin/fish
set -g fish_greeting

set -g GTK_IM_MODULE ibus
set -g QT_IM_MODULE  ibus
set -g XMODIFIERS    @im=ibus

set -g PATH $PATH                 $HOME/.local/bin
set -x EDITOR                     /usr/bin/nvim
set -x GDK_BACKEND                wayland
set -x VIRTUAL_ENV_DISABLE_PROMPT 1

alias ip="ip -c"
alias pacman="sudo pacman"
alias ssh="env TERM=xterm-256color ssh"

if status --is-interactive
    fish_ssh_agent
    fish_vi_key_bindings
    source (rbenv init -|psub)
end
