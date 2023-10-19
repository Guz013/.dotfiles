#!/usr/bin/env bash

# $1 - The item to be founded
# $2 - The return value
# $3 - The aliases list
function check_alias() {
    local find="$1"
    local return="$2"
    shift 2
    local list=("$@")
    for alias in "${list[@]}"; do
        if [[ "$find" == "$alias" ]]; then
            echo "$return"
            return 0
        fi
    done
    echo "0"
}
env="0"
if [[ $env == "0" ]]; then
    env=$(check_alias $1 "neutral" "n" "index" "neutral" "off")
fi
if [[ $env == "0" ]]; then
    env=$(check_alias $1 "coding" "c" "code" "coding")
fi
if [[ $env == "0" ]]; then
    env=$(check_alias $1 "drawing" "d" "art" "draw" "drawing")
fi
if [[ $env == "0" ]]; then
    env=$(check_alias $1 "writing" "w" "write" "writing")
fi

if [[ $env == "0" ]]; then 
    echo "Please choose between: neutral, coding, drawing or writing"
    exit 1
fi

# $1 - Environment
function change_banner() {
    local wallpaper_dir="$HOME/.my-env/wallpapers"
    case "$1" in 
        "neutral") swww img "$wallpaper_dir/neutral.jpg";;
        "coding") swww img "$wallpaper_dir/coding.jpg";;
        "drawing") swww swww img "$wallpaper_dir/drawing.jpg";;
        "writing") swww img "$wallpaper_dir/writing.jpg";;
    esac
}
change_banner $env

bash "$HOME/.my-env/environments/_index.sh" $env

echo "$env"
