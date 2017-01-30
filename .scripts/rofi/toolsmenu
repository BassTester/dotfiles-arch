#!/bin/bash

res=$(echo "0:Pavucontrol|1:Htop|2:Ping|3:Arandr|4:Wttr" | rofi -sep "|" -dmenu -i -p 'Narzędzia ' "" -auto-select)
if [ $res = "0:Pavucontrol" ]; then
  pavucontrol
fi
if [ $res = "1:Htop" ]; then
  xterm -e "htop"
fi
if [ $res = "2:Ping" ]; then
  xterm -e "ping 8.8.8.8"
fi
if [ $res = "3:Arandr" ]; then
  arandr
fi
if [ $res = "4.Wttr" ]; then
	curl wttr.in/Wroclaw
fi
exit 0
