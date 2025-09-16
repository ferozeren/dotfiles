#!/usr/bin/env bash

# Debug: Log arguments
echo "pkit.sh called with args: $1 $2 $3" >> /tmp/pkit.log

# Create a new pane and capture its ID
new_pane=$(wezterm cli split-pane --bottom --percent 30 2>> /tmp/pkit.log)
if [[ -z "$new_pane" ]]; then
  echo "Error: Failed to create new pane" >> /tmp/pkit.log
  exit 1
fi

# Handle zoom flag
if [[ "$3" = "zoom" ]]; then
  wezterm cli zoom-pane --pane-id "$new_pane" 2>> /tmp/pkit.log
fi

# Send pkit run command to the new pane
echo -en pkit run\r" | wezterm cli send-text --no-paste --pane-id "$new_pane" 2>> /tmp/pkit.log
