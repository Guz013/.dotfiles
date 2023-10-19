#!/usr/bin/env bash

app="$1"

if [[ "$app" == "" ]]; then
    hyprctl dispatch exec -- rofi -show drun
else
    hyprctl dispatch exec -- "$app"
fi
