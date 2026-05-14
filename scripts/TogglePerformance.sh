#!/usr/bin/env sh

gov="$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor)"

if [ "$gov" = "performance" ]; then
  # Balanced mode
  for cpu in /sys/devices/system/cpu/cpu[0-9]*; do
    echo powersave | sudo tee "$cpu/cpufreq/scaling_governor" >/dev/null
    [ -f "$cpu/cpufreq/energy_performance_preference" ] &&
      echo balance_performance | sudo tee "$cpu/cpufreq/energy_performance_preference" >/dev/null
  done
  notify-send "CPU Mode" "Balanced"
else
  # Performance mode
  for cpu in /sys/devices/system/cpu/cpu[0-9]*; do
    echo performance | sudo tee "$cpu/cpufreq/scaling_governor" >/dev/null
    [ -f "$cpu/cpufreq/energy_performance_preference" ] &&
      echo performance | sudo tee "$cpu/cpufreq/energy_performance_preference" >/dev/null
  done
  notify-send "CPU Mode" "Performance"
fi
