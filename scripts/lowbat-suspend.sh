#!/bin/env sh
acpi -b | awk -F'[,:%]' '{print $2, $3}' | {
	read -r status capacity

	if [ "$status" = Discharging -a "$capacity" -lt 8 ]; then
		logger "Critical battery threshold"
		systemctl suspend
    else
        echo "Battty level = $capacity"
	fi
}
