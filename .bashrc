#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

# exclude single commands from history >>>
export HISTIGNORE=$'*([\t ])+([-%+,./0-9\:@A-Z_a-z])*([\t ])'
export LS_COLORS="di=1;38;5;12:ln=1;38;5;14:so=1;32:pi=1;33:ex=1;38;5;13"
export BAT_THEME='gruvbox-dark'
export MOZ_ENABLE_WAYLAND=1
# <<<

# colors in less ----------------------------------------------------------- >>>
export MANPAGER="less -R --use-color -Dd+g -Du+m"
export MANROFFOPT="-P -c"
# <<<

# foot --------------------------------------------------------------------- >>>
if [ "$TERM" = "foot" ]; then
    osc7_cwd() {
        local strlen=${#PWD}
        local encoded=""
        local pos c o
        for (( pos=0; pos<strlen; pos++ )); do
            c=${PWD:$pos:1}
            case "$c" in
                [-/:_.!\'\(\)~[:alnum:]] ) o="${c}" ;;
                * ) printf -v o '%%%02X' "'${c}" ;;
            esac
            encoded+="${o}"
        done
        printf '\e]7;file://%s%s\e\\' "${HOSTNAME}" "${encoded}"
    }
    PROMPT_COMMAND=${PROMPT_COMMAND:+${PROMPT_COMMAND%;}; }osc7_cwd
fi
# <<<

# fastfetch image ??? >>>
if command -v fastfetch >/dev/null; then
  if [[ -f ~/dotfiles/assets/splash.jpg ]]; then
    fastfetch --sixel "$XDG_CONFIG_HOME/themes/terminal-splash.jpg"
  else
    fastfetch
  fi
fi
# <<<

# PROMPT >>>
NORMAL='\[\033[00m\]'
CODE_BOLD_FG="\[\e[1;38;5;m\]"
CODE_FG="\[\e[38;5;m\]"

MAKE_COLOR() {
    local A="$1"
    local B="$2"
    local prefix="${A%%m*}"
    local suffix="${A#*m}"
    echo "${prefix}${B}m${suffix}"
}

FIRST=014
SECOND=013

FIRST_BOLD_FG=$(MAKE_COLOR "$CODE_BOLD_FG" "$FIRST")
SECOND_BOLD_FG=$(MAKE_COLOR "$CODE_BOLD_FG" "$SECOND")

platform='linux'
if [[ `uname` == MINGW* ]]; then
    platform='windows'
fi

if [[ "$platform" == "linux" ]]; then
    DATE=$(date +%Y-%m-%d\ %H:%M\ \(%a\))
    export PS1="${NORMAL}\n╭─── $DATE ${FIRST_BOLD_FG}\u@\h${NORMAL}:${SECOND_BOLD_FG}\w\n${NORMAL}╰─ \$ "
elif [[ "$platform" == "windows" ]]; then
    if [[ -n $(net session 2>/dev/null) ]]; then
        export PS1="${NORMAL}\n╭─── ${SECOND_BOLD_FG}[ADMIN]${NORMAL} (\d \@) ${FIRST_BOLD_FG}\u@\h${NORMAL}:${SECOND_BOLD_FG}\w\n${NORMAL}╰─ \$ "
    else
        export PS1="${NORMAL}\n╭─── (\d \@) ${FIRST_BOLD_FG}\u@\h${NORMAL}:${SECOND_BOLD_FG}\w\n${NORMAL}╰─ \$ "
    fi
fi
# <<<

# ALIASES >>>

# dotfiles bare repo setup
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

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

if [ -x "$(command -v gvim)" ]
then
    alias gvim='gvim -v'
    alias vi='gvim'
else
    alias vi='vim'
fi

# usage: echo "hello world" | clip
alias clip='xclip -selection clipboard'

alias pkglist='pacman -Qs --color=always | less -R'

alias jn='jupyter notebook'
alias jl='jupyter lab'

platform='linux'
if [[ `uname` == MINGW* ]]; then
    platform='windows'
fi
if [[ "$platform" == "linux" ]]; then
    alias open='xdg-open 2>/dev/null'
    # alias km='sudo chmod +0666 /dev/uinput && sudo chmod +0666 /dev/input/by-path/platform-i8042-serio-0-event-kbd && echo "[kmonad]" &&  kmonad ~/garden/kmonad/keymaps/thinkpad.kbd'
    # alias wlan='sudo iwctl device wlan0 set-property Powered on && sudo iwctl station list && ping archlinux.org'
elif [[ "$platform" == "windows" ]]; then
    alias open='explorer'
fi
# <<<
