# .bashrc

export HISTFILESIZE=
export HISTSIZE=

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

if [ -d "$HOME/.dotfiles/scripts" ]; then
    PATH="$HOME/.dotfiles/scripts:$PATH"
fi

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

unset rc

if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi


#########
# Aliases
#########

# Wake on LAN commands
alias 'wake-server'='sudo ether-wake 58:11:22:d8:ac:65'
alias 'wake-pc'='sudo ether-wake 2c:f0:5d:0e:b1:b6'

alias 'pubip'='echo "ipv4: $(curl -s ipinfo.io/ip)" && echo "ipv6: $(curl -s ifconfig.co)"'
alias 'ports'='sudo netstat -tulpn'

alias 'lm'='ls -t -1'
alias 'lt'='ls --human-readable --size -1 -S --classify'

alias 'cp'='cp -iv'
alias 'mv'='mv -iv'
alias 'rm'='rm -v'
alias 'df'='df -h'
alias 'mkdir'='mkdir -pv'

alias 'yt'='youtube-dl --add-metadata -i'

alias 'shd'='sudo shutdown -h now'

alias '..'='cd ..'
alias '...'='cd ../..'
alias '....'='cd ../../..'

alias 'ls'='eza --color=always --group-directories-first'
alias 'l.'='eza -a  | grep -E "^\."'

alias 'grep'='grep --color=auto'
alias 'egrep'='grep -E --color=auto'
alias 'fgrep'='fgrep --color=auto'

alias 'code'='code --profile UserProfile'
alias 'vim'='nvim'

# python venv
alias 'venv'='source venv/bin/activate'
alias 'venvc'='python -m venv venv && source venv/bin/activate'
alias 'venvd'='deactivate'

# Copy paste in terminal
alias ccc='xsel --input --clipboard'
alias ppp='xsel --output --clipboard'

# Arduino
alias acli="arduino-cli"


# Android studio command
studio() {
    dir="${1:-./}"
    (nohup android-studio &> /dev/null "$dir" &)
}

# Intellij IDEA command
idea() {
    dir="${1:-./}"
    (nohup /usr/bin/idea &> /dev/null "$dir" &)
}

dusort() {
    dir="${1:-./}"
	du -h "$dir" --max-depth=1 | sort -h
}

ex ()
{
   if [ -f "$1" ] ; then
     case $1 in
       *.tar.bz2)   tar xjf $1   ;;
       *.tar.gz)    tar xzf $1   ;;
       *.bz2)       bunzip2 $1   ;;
       *.rar)       unrar x $1   ;;
       *.gz)        gunzip $1    ;;
       *.tar)       tar xf $1    ;;
       *.tbz2)      tar xjf $1   ;;
       *.tgz)       tar xzf $1   ;;
       *.zip)       unzip $1     ;;
       *.Z)         uncompress $1;;
       *.7z)        7z x $1      ;;
       *.deb)       ar x $1      ;;
       *.tar.xz)    tar xf $1    ;;
       *.tar.zst)   unzstd $1    ;;
       *)           echo "'$1' cannot be extracted via ex()" ;;
     esac
   else
     echo "'$1' is not a valid file"
   fi
}

compress_all ()
{
    if [ $# -ne 1 ]; then
        echo "Usage: create_archives <directory>"
        return 1
    fi

    local source_dir="$1"

    if [ ! -d "$source_dir" ]; then
        echo "Error: '$source_dir' is not a valid directory."
        return 1
    fi

    for dir in "$source_dir"/*/; do
        if [ -d "$dir" ]; then
            base_name="$(basename "$dir")"
            tar -czvf "${base_name}.tar.gz" "$dir"
        fi
    done
}

# Show git branch

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

PS1="\[\e[34m\]\u@\h\[\e[00m\] \[\e[32m\]\w \[\e[91m\]\$(parse_git_branch)\[\e[00m\]$ "

if [ -f /etc/os-release ]; then
    # freedesktop.org and systemd
    . /etc/os-release
    OS=$NAME
fi


if [[ $OS == 'Ubuntu' ]]; then
    PS1="\[\e[38;5;208m\]\u@\h\[\e[00m\] \[\e[32m\]\w \[\e[91m\]\$(parse_git_branch)\[\e[00m\]$ "
fi

sys=$(uname -m)

if [[ $sys == 'aarch64' || $sys == 'armv7l' ]]; then
    PS1="\[\e[95m\]\u@\h\[\e[00m\] \[\e[32m\]\w \[\e[91m\]\$(parse_git_branch)\[\e[00m\]$ "
fi

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH

# pyenv
if command -v pyenv > /dev/null 2>&1; then
    export XDG_CONFIG_HOME="$HOME/.config"
    export PYENV_ROOT="$XDG_CONFIG_HOME/pyenv"
    command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
fi

# FZF 
if command -v fzf > /dev/null 2>&1; then
    eval "$(fzf --bash)"
fi

