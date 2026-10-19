#!/usr/bin/env bash

declare -A commands=(
    # ["reload hyprland"]="hyprctl reload"
    ["pcscd stop (guest)"]="sudo systemctl stop pcscd.service && sudo systemctl stop pcscd.socket"
    ["pcscd start (host)"]="sudo systemctl start pcscd.socket && sudo systemctl start pcscd.service"
    ["screenshot"]="grim -g \"\$(slurp)\" - | tee ~/pictures/screenshots/screenshot-\$(date +%Y%m%d-%H%M%S).png | wl-copy --type image/png",
)

choice=$(printf '%s\n' "${!commands[@]}" | sort | wofi \
    --dmenu \
    --prompt "command palette" \
    --width 500 \
    --height 400)

[[ -z "$choice" ]] && exit 0

command="${commands[$choice]}"
[[ -z "$command" ]] && exit 0

eval "$command"
