#!/bin/bash

# take care with the user id
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus

DAILY_STAT_RAW=$(/home/mulc/bin/daily stat $@ )
if [[ $? != 0 ]]; then
    /usr/bin/notify-send "daily" "\nNo daily report entry yet. Use \`daily\` to start documenting the day."
    exit
fi

DISTANCE=$(echo $(echo $(date +%s)) - $(date --date="$(printf "$DAILY_STAT_RAW" | rg Change | sed 's/Change: //g' | awk '{print$1" "$2}')" +%s) | bc)

if [[ "$DISTANCE" -ge 7200 ]]; then
    /usr/bin/notify-send "daily" "\nDaily has not been modified since two hours. Use \`daily\` to document any new changes."
    exit
fi
