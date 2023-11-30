#!/usr/bin/env bash

function notify_function() {
	local type="${@: -1:1}"

	if [[ "$type" == ":success" ]]; then
		hyprctl dispatch exec -- play -v 0.3 "$HOME/.my-env/static/notification-success.mp3"
	else
		hyprctl dispatch exec -- play -v 0.5 "$HOME/.my-env/static/notification.mp3"
	fi
	/usr/bin/env notify-send $1
}

notify_function "$@"
