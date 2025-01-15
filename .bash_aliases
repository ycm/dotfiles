alias ls='ls --color=auto'
alias ll='ls -l'

alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias .4='.....'
alias .5='cd ../../../../..'

alias c='clear'
alias lcear='clear'
alias cear='clear'

alias mv='mv -i'
alias rm='rm -i --preserve-root'
alias cp='cp -i'
alias ln='ln -i'

alias mkdir='mkdir -pv'
alias f='find . -name'
alias grep='grep --color=auto'

alias lc='wc -l'

alias chmod='chmod -c --preserve-root'
alias chown='chown -c --preserve-root'
alias chgrp='chgrp -c --preserve-root'

alias wget='wget -c'

# gvim
alias gvim='gvim -v'

# alias vi='vim'
alias vi='gvim'

# usage: echo "hello world" | clip
alias clip='xclip -selection clipboard'

alias pkglist='pacman -Qs --color=always | less -R'

alias jn='jupyter notebook'
alias jl='jupyter lab'

alias open='xdg-open 2>/dev/null'

alias km='sudo chmod +0666 /dev/uinput && sudo chmod +0666 /dev/input/by-path/platform-i8042-serio-0-event-kbd && echo "[kmonad]" &&  kmonad ~/garden/kmonad/keymaps/thinkpad.kbd'

alias wlan='sudo iwctl device wlan0 set-property Powered on && sudo iwctl station list && ping archlinux.org'
