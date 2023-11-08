#!/usr/bin/env bash

# Theme Nord
function open_coding() {
	local state_file="$HOME/.my-env/environments/coding_state.txt"

	echo "Opening coding"

	# Reload Hyperland just in case
	hyprctl reload

	# Load windows rules for this setup
	hyprctl keyword source "$HOME/.my-env/environments/coding_hyprland.conf"

	# Start softwares
	hyprctl --batch 'dispatch workspace 1; dispatch exec [workspace 1] alacritty --class neovim-instance -e tmux; dispatch workspace 4'
	hyprctl --batch 'dispatch exec [workspace 5 silent] librewolf -P code-profile; dispatch exec [workspace 6 silent] dbus-run-session webcord'

	sleep 1L
	# local webcord="$(get_window_pid_by_str "class: WebCord" 8)"
	# hyprctl "dispatch movetoworkspacesilent 6,pid:$webcord"

	# Read last session state
	local last_browser="$(get_state "coding_last_dev_browser")"
	if [[ "$last_browser" == "firefox" ]]; then
		hyprctl 'dispatch exec [workspace 4] firefox'
	elif [[ "$last_browser" == "brave" ]]; then
		hyprctl 'dispatch exec [workspace 4] brave'
	fi

	sleep 2
	hyprctl dispatch workspace 1;

	echo "import: [$HOME/.my-env/environments/coding_alacritty.yml]" > "$HOME/.config/alacritty/alacritty.yml"
	echo "@import \"/home/guz/.config/eww/vars-coding.scss\";" > "$HOME/.config/eww/vars.scss"

	eww open bar-coding
	eww open bar-coding-2

	set_env "coding"

	exec zsh

	sleep 2
	clear
}

function close_coding() {
	echo "Closing coding"

	eww close bar-coding
	eww close bar-coding-2

	echo "import: [$HOME/.config/alacritty/default_alacritty.yml]" > "$HOME/.config/alacritty/alacritty.yml"
	echo "@import \"/home/guz/.config/eww/vars-neutral.scss\";" > "$HOME/.config/eww/vars.scss"

	# close_discord_client


	if [[ "$(get_pid_by_name 'firefox')" -ne "" ]]; then
		save_state "coding_last_dev_browser" "firefox"
		hyprctl dispatch closewindow "pid:$(get_pid_by_name 'firefox')"
	elif [[ "$(get_pid_by_name 'brave')" -ne "" ]]; then
		save_state "coding_last_dev_browser" "brave"
		hyprctl dispatch closewindow "pid:$(get_pid_by_name 'brave')"
	else
		save_state "coding_last_dev_browser" ""
	fi

	hyprctl dispatch closewindow "pid:$(get_pid_by_name 'librewolf')"
	hyprctl dispatch closewindow "pid:$(get_window_pid_by_str "class: neovim-instance" 8)"

	sleep 1

	hyprctl reload

	sleep 2
	clear
}
