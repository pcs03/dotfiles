#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

export XDG_CONFIG_HOME="$HOME/.config"
export MOZ_ENABLE_WAYLAND=1
export EDITOR=nvim
export ZDOTDIR="$HOME/.config/zsh"
export ANSIBLE_CONFIG="$XDG_CONFIG_HOME/ansible"
export ANSIBLE_INVENTORY="$ANSIBLE_CONFIG/hosts"


# pyenv
export PYENV_ROOT="$XDG_CONFIG_HOME/pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
