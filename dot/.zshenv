# XDG
export XDG_CONFIG_HOME="$HOME/.config"

# Editor
export EDITOR="nvim"
export VISUAL="nvim"

# zsh
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export HISTFILE="$ZDOTDIR/.zhistory"
export HISTSIZE=10000
export SAVEHIST=10000

# other software
export MOZ_ENABLE_WAYLAND=1

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH


if [[ $TERM_PROGRAM != 'vscode' ]] && [[ $TERM == 'xterm-256color' ]]; then
    neofetch --color_blocks off
fi
