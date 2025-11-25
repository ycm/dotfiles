#
# ~/.bashrc
#
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[ -f /etc/profile.d/vte.sh ] && . /etc/profile.d/vte.sh

# misc app/tool-specific --------------------------------------------------- >>>

# exclude single commands from history
export HISTIGNORE=$'*([\t ])+([-%+,./0-9\:@A-Z_a-z])*([\t ])'
export LS_COLORS="di=1;38;5;12:ln=1;38;5;14:so=1;32:pi=1;33:ex=1;38;5;13"
export BAT_THEME='gruvbox-dark'
export MOZ_ENABLE_WAYLAND=1
# <<<

# gba dev ------------------------------------------------------------------ >>>
export WONDERFUL_TOOLCHAIN="/opt/wonderful"
DEVKITPRO="/opt/devkitpro"
DEVKITARM="/opt/devkitpro/devkitARM"
DEVKITPPC="/opt/devkitpro/devkitPPC"
# <<<

# colors in less ----------------------------------------------------------- >>>
export MANPAGER="less -R --use-color -Dd+g -Du+m"
export MANROFFOPT="-P -c"
# <<<

# custom bash dotfiles ----------------------------------------------------- >>>
dotfiles=(
    "${HOME}/.bash_aliases"
    "${HOME}/.bash_functions"
    "${HOME}/.bash_prompt"
)
for dotfile in "${dotfiles[@]}"; do
    [[ -r "${dotfile}" ]] && source "${dotfile}"
done
unset dotfiles; unset -v dotfile
# <<<

# conda initialize --------------------------------------------------------- >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/ycm/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/ycm/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/ycm/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/ycm/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<<

[ -f "/home/ycm/.ghcup/env" ] && . "/home/ycm/.ghcup/env" # ghcup-env
export LIBVIRT_DEFAULT_URI="qemu:///system"

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

if command -v fastfetch >/dev/null; then
  if [[ -f ~/dotfiles/assets/splash.jpg ]]; then
    fastfetch --sixel "$XDG_CONFIG_HOME/themes/terminal-splash.jpg"
  else
    fastfetch
  fi
fi
