#!/usr/bin/env python3
#
# Copyright (C) 2016 James Murphy
# Licensed under the GPL version 2 only
#
# A battery indicator blocklet script for i3blocks

from subprocess import check_output

status = check_output(['acpi'], universal_newlines=True)

if not status:
    # stands for no battery found
    fulltext = "<span color='red'><span font='FontAwesome'>\uf00d \uf240</span></span>"
    percentleft = 100
else:
    state = status.split(": ")[1].split(", ")[0]
    commasplitstatus = status.split(", ")
    percentleft = int(commasplitstatus[1].rstrip("%\n"))

    # stands for charging
    FA_LIGHTNING = "<span color='yellow'><span font='FontAwesome'>\uf0e7</span></span>"

    # stands for plugged in
    FA_PLUG = "<span font='FontAwesome'>\uf1e6</span>"

    fulltext = ""
    timeleft = ""

    if state == "Discharging":
        time = commasplitstatus[-1].split()[0]
        time = ":".join(time.split(":")[0:2])
        timeleft = " ({})".format(time)
    elif state == "Full":
        fulltext = FA_PLUG + " "
    elif state == "Unknown":
        fulltext = "<span font='FontAwesome'>\uf128</span> "
    else:
        fulltext = FA_LIGHTNING + " " + FA_PLUG + " "

    def color(percent):
        return "#000000"

    form =  '<span >{}%</span>'
    fulltext += form.format(percentleft)
    fulltext += timeleft

print(fulltext)
