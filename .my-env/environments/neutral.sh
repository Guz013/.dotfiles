#!/usr/bin/env bash

function open_neutral() {
    echo "Opening neutral"

    # Reload Hyperland just in case
    hyprctl reload

    hyprctl keyword general:col.active_border "rgba(ffffff99) rgba(ffffff33)"
    hyprctl keyword general:col.inactive_border "rgba(00000000)"

    local webcord="$(get_window_pid_by_str "class: WebCord" 8)"
    if [[ "$main_terminal" -le "0" ]]; then
        hyprctl 'dispatch exec [workspace index2 silent] webcord'
    fi
    sleep 1
    hyprctl "dispatch movetoworkspacesilent index2,pid:$webcord"

    local obsidian="$(get_window_pid_by_str "class: obsidian" 8)"
    if [[ "$obsidian" -le "0" ]]; then
        hyprctl "dispatch exec [workspace index silent] obsidian"
    fi
    hyprctl "dispatch movetoworkspacesilent index,pid:$obsidian"

    local main_terminal=$(get_window_pid_by_str "class: main-terminal" 8)
    if [[ "$main_terminal" -le "0" ]]; then
        hyprctl 'dispatch exec [workspace index silent] alacritty --class main-terminal'
    fi
    hyprctl --batch "dispatch workspace index2; dispatch workspace index; dispatch focuswindow pid:$main_terminal; dispatch moveactive exact 2227 822; dispatch resizeactive exact 300 200"

    echo "import: [$HOME/.my-env/environments/neutral_alacritty.yml]" >"$HOME/.config/alacritty/alacritty.yml"
    echo "@import \"/home/guz/.config/eww/vars-neutral.scss\";" >"$HOME/.config/eww/vars.scss"

    eww open bar-neutral
    eww open bar-neutral-2

    set_env "neutral"

    exec zsh

    sleep 1
    clear
}

function close_neutral() {
    echo "Closing neutral"

    eww close bar-neutral
    eww close bar-neutral-2

    echo "import: [$HOME/.config/alacritty/default_alacritty.yml]" >"$HOME/.config/alacritty/alacritty.yml"
    echo "@import \"/home/guz/.config/eww/vars-neutral.scss\";" >"$HOME/.config/eww/vars.scss"

    hyprctl reload

    sleep 1
    clear
}
