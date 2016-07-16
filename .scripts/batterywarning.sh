#!/bin/bash
BATPATH=/sys/class/power_supply/BAT0
BAT_FULL=$BATPATH/charge_full
BAT_NOW=$BATPATH/charge_now

status="$(acpi -i | grep Charging)"
bf=$(cat $BAT_FULL)
bn=$(cat $BAT_NOW)

if [ -z $status ]; then
  if [ $(( 100 * $bn / $bf )) -lt 5 ]; then
    notify-send "Shutting down in 60 sec"
    sleep 60
    echo "shutting down" >> /home/maciej/batterylog
    systemctl poweroff
  else
    if [ $(( 100 * $bn / $bf )) -lt 8 ]; then
      res=$(echo "shutdown|ignore" | rofi -sep "|" -dmenu -i -p 'Low battery!: ' "" -auto-select)
      if [ $res = "shutdown" ]; then
          systemctl poweroff
      fi
      if [ $res = "ignore" ]; then
        echo "ignored"
      fi
    fi
  fi
fi
