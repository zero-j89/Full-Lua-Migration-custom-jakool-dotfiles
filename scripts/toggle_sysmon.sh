#!/usr/bin/env bash

if pgrep -f '[g]nome-system-monitor' >/dev/null; then
  pkill -f '[g]nome-system-monitor'
else
  gnome-system-monitor &
fi
