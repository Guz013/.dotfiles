#!/usr/bin/env zsh

# Pomodoro timer written in Bash
# Inspired by Bashbunni's pomodoro timer:
# https://gist.github.com/bashbunni/3880e4194e3f800c4c494de286ebc1d7

source "$HOME/.my-env/_hyprland_utils.sh"

declare -A pomo_options
pomo_options["work"]="50m"
pomo_options["break"]="10m"

function pomotimer() {
  local time="$1"
  shift 1;
  local message="$@"

  clear
  timer "$time"
  notify-send "$message"
  play -v 0.5 "$HOME/.my-env/static/notification-success.mp3"
}

function pomoterminal() {
    local time="$1"
    shift 1;
    local message="$@"

    hyprctl dispatch exec "[workspace index silent] alacritty --class 'pomodoro-terminal' -e bash $HOME/.my-env/apps/pomodoro.sh timer $time '$message'"

    local pomodoro_terminal=$(get_window_pid_by_str "class: pomodoro-terminal" 8)
}

function pomodoro() {
  if [ -n "$1" -a -n "${pomo_options["$1"]}" ]; then
    local option="$1"
    echo $option | dotacat
    local time="${pomo_options["$1"]}"
    pomoterminal $time "FINISHED: '$option' ($time) [Pomodoro timer]"
  fi
}

if [[ "$1" == "timer" ]]; then
  tmp="$2"
  shift 2;
  pomotimer "$tmp" "$@"
else
  pomodoro $1
fi
