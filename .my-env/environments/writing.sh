#!/usr/bin/env bash

# Theme Catppuccin Green
function open_writing() {
    echo "Opening writing"

    # Reload Hyperland just in case
    hyprctl reload

    hyprctl keyword general:col.active_border "rgba(a6e3a199) rgba(a6e3a133)"
    hyprctl keyword general:col.inactive_border "rgba(00000000)"

    set_env "writing"
}


function close_writing() {
    echo "Closing writing"

    hyprctl reload
}
