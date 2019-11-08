#!/bin/sh

export WIRELESS_INTERFACE=$(find /sys/class/net -maxdepth 1 -name 'wl*' -exec basename {} \;)
export WIRED_INTERFACE=$(find /sys/class/net -maxdepth 1 -name 'enp*' -exec basename {} \;)

polybar top