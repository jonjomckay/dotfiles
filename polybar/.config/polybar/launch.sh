#!/usr/bin/env sh

export NETWORK_INTERFACE=$(find /sys/class/net -maxdepth 1 -name 'enp*' -exec basename {} \;)

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2
polybar -c ~/.config/polybar/config.ini main
