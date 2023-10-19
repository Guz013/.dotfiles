#!/usr/bin/env bash

source "$HOME/.my-env/_utils.sh"
source "$HOME/.my-env/_hyprland_utils.sh"

function set_env() {
	touch "$HOME/.my-env/env.txt"
	echo "$1" >"$HOME/.my-env/env.txt"
	export GUZ_ACTIVE_ENV="$1"
	hyprctl keyword env "GUZ_ACTIVE_ENV,$1"
}

function get_env() {
	echo $(cat "$HOME/.my-env/env.txt")
	return 0
}

source "$HOME/.my-env/environments/neutral.sh"
source "$HOME/.my-env/environments/coding.sh"
source "$HOME/.my-env/environments/drawing.sh"
source "$HOME/.my-env/environments/writing.sh"

case $(get_env) in
"neutral") close_neutral ;;
"coding") close_coding ;;
"drawing") close_drawing ;;
"writing") close_writing ;;
esac

case $1 in
"neutral") open_neutral ;;
"coding") open_coding ;;
"drawing") open_drawing ;;
"writing") open_writing ;;
esac
