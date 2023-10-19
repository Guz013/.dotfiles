#!/usr/bin/env bash

function cut_str() {
	local str="$1"
	local number="$(($2 + 1))"

	echo "$(echo $1 | rev | cut -c $number- | rev)"
}

function get_line_number_of_str() {
	local str="$1"
	local file="$2"
	local line="$(cat "$file" | grep "$str" -n -m1 | awk '{print $1}')"
	echo "$(cut_str "$line" "1")"
}

function get_line_by_number() {
	local line_num="$1"
	local file="$2"
	echo "$(sed -n ""$line_num"p" "$file")"
}

function get_pid_by_name() {
	local name="$1"
	echo $(ps -ax | grep "$name" | grep -v 'grep' -m1 | awk '{print $1}')
}

function get_librewolf_profile_path() {
	local profile_name="$1"
	local profile_file="$(ls "$HOME/.librewolf/" | grep ".$profile_name")"
	echo "$HOME/.librewolf/$profile_file"
}

# Workaround to opening discord when it's already opened in the background
# $1 - Workspace to open discord
# $2 - Workspace to go after opening
function open_discord_client() {
	local discord_client_name="webcord/app.asar"
	local discord_w="$1"
	local last_w="$2"
	local discord_pid=$(get_pid_by_name "$discord_client_name")
	sleep 1
	if [[ "$discord_pid" -ne "" ]]; then
		echo "Moving discord to workspace $discord_w"
		hyprctl "dispatch workspace 6"
		sleep 2
		hyprctl "dispatch exec [workspace $discord_w silent] bash $HOME/.temp-fixes/discord-wayland.sh"
		sleep 2
		hyprctl "dispatch movetoworkspace $discord_w,pid:$discord_pid"
		sleep 2
		hyprctl "dispatch workspace $last_w"
	else
		hyprctl "dispatch exec [workspace $discord_w silent] $discord_client_name"
	fi
}

function close_discord_client() {
	local discord_client_name="webcord/app.asar"
	local discord_pid=$(get_pid_by_name "$discord_client_name")
	hyprctl dispatch closewindow "pid:$discord_pid"
}

# $1 - File path
# $2 - State key
function get_state() {
	local file="$1"

	echo $(cat "$HOME/.my-env/environments/states/$file.txt")
}

# $1 - File path
# $2 - State key
# $3 - State value
function save_state() {
	local file="$1"
	local value="$2"

	touch "$HOME/.my-env/environments/states/$file.txt"
	echo "$value" >"$HOME/.my-env/environments/states/$file.txt"
}
