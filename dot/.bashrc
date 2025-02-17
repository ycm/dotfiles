#
# ~/.bashrc
#
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ -d /usr/local/texlive/2023/bin/x86_64-linux ]; then
    export PATH="/usr/local/texlive/2023/bin/x86_64-linux:$PATH"
fi
if [ -d /home/ycm/.local/bin ]; then
    export PATH="/home/ycm/.local/bin:$PATH"
fi
if [ -d /opt/wonderful/bin ]; then
    export PATH="/opt/wonderful/bin:$PATH"
fi

[ -f /etc/profile.d/vte.sh ] && . /etc/profile.d/vte.sh

# misc app/tool-specific --------------------------------------------------- >>>

# exclude single commands from history
export HISTIGNORE=$'*([\t ])+([-%+,./0-9\:@A-Z_a-z])*([\t ])'
export LS_COLORS="di=1;34:ln=1;36:so=1;32:pi=1;33:ex=1;31:*.txt=1;35"
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
