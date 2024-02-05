# .bashrc

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

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

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

# Aliases
alias 'ssh-server'='ssh pstet@192.168.2.160'
alias 'sftp-server'='sftp pstet@192.168.2.160'
alias 'wake-server'='sudo ether-wake 58:11:22:d8:ac:65'

alias 'ssh-pc'='ssh pstet@192.168.2.162'
alias 'sftp-pc'='sftp pstet@192.168.2.162'
alias 'wake-pc'='sudo ether-wake 2c:f0:5d:0e:b1:b6'

alias 'ssh-pi3'='ssh pstet@192.168.2.189'
alias 'sftp-pi3'='sftp pstet@192.168.2.189'

alias 'ssh-pi4'='ssh pstet@192.168.2.197'
alias 'sftp-pi4'='sftp pstet@192.168.2.197'

alias 'ssh-sd'='ssh deck@192.168.2.191'
alias 'sftp-sd'='sftp deck@192.168.2.191'


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

if [[ $TERM_PROGRAM != 'vscode' ]] && [[ $TERM == 'xterm-256color' ]]; then
    neofetch --color_blocks off
fi
