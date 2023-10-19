#!/usr/bin/env bash

sink="$(echo $(pulsemixer -l | grep 'Default' | grep 'sink-' | awk '{print $3}') | rev | cut -c 2- | rev)"
function="$1"
value="$2"

if [[ "$function" == "set" ]]; then
    pulsemixer --id "$sink" --set-volume $2
    echo "0"
elif [[ "$function" == "get" ]]; then
    echo "$(pulsemixer --id "$sink" --get-volume | awk '{print $1}')"
elif [[ "$function" == "label" ]]; then
    echo "$(pulsemixer --id "$sink" --get-mute | awk '{if($1>0) print "󰖁"; else print "󰕾"}')"
fi

