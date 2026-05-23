#!/usr/bin/env bash

set -euo pipefail

# Reset binds first
hyprctl keyword unbind SUPER,J || true
hyprctl keyword unbind SUPER,K || true

# Cycle windows
hyprctl keyword bind SUPER,J,cyclenext
hyprctl keyword bind SUPER,K,cyclenext,prev

