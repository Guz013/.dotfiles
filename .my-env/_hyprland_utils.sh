#!/bin/env bash

_temp_file="$HOME/.my-env/temp.txt"

source "$HOME/.my-env/_utils.sh"

function get_current_clients() {
	echo "$(hyprctl clients)" >"$_temp_file"
	echo "$(cat "$_temp_file")"
}

function get_window_by_str() {
	local str="$1"
	local line_offset="$2"

	local temp="$(get_current_clients)"

	local line_num="$(get_line_number_of_str "$str" "$_temp_file")"
	if [[ "$line_num" == "" ]]; then
		return 1
	fi

	local line=$(("$line_num" - "$line_offset"))

	echo "$(get_line_by_number "$line" "$_temp_file" | awk '{print $2}')"

}

function get_window_pid_by_str() {
	echo "$(get_window_by_str "$1" $(("$2" - 12)))"
}
