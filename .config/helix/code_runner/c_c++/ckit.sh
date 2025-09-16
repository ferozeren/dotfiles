#!/usr/bin/env bash

# Debug: Log arguments
echo "ckit.sh called with args: $1 $2 $3" >> /tmp/ckit.log

# Create a new pane and capture its ID
new_pane=$(wezterm cli split-pane --bottom --percent 30 2>> /tmp/ckit.log)
if [[ -z "$new_pane" ]]; then
  echo "Error: Failed to create new pane" >> /tmp/ckit.log
  exit 1
fi

# Handle zoom flag
if [[ "$3" = "zoom" ]]; then
  wezterm cli zoom-pane --pane-id "$new_pane" 2>> /tmp/ckit.log
fi

# Send ckit run command to the new pane
echo -en "ckit run\r" | wezterm cli send-text --no-paste --pane-id "$new_pane" 2>> /tmp/ckit.log
