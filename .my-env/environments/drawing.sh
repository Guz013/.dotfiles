#!/usr/bin/env bash

# Theme Catppuccin Mauve
function open_drawing() {
    echo "Opening drawing"

    # Reload Hyperland just in case
    hyprctl reload

    hyprctl keyword general:col.active_border "rgba(cba6f799) rgba(cba6f733)"
    hyprctl keyword general:col.inactive_border "rgba(00000000)"

    set_env "drawing"
}

function close_drawing() {
    echo "Closing drawing"

    hyprctl reload
}
