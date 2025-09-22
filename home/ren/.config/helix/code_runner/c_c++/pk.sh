#!/usr/bin/env bash

# Debug: Log arguments
echo "pk.sh called with args: $1 $2 $3" >> /tmp/pk.log

# Create a new pane and capture its ID
new_pane=$(wezterm cli split-pane --bottom --percent 30 2>> /tmp/pk.log)
if [[ -z "$new_pane" ]]; then
  echo "Error: Failed to create new pane" >> /tmp/pk.log
  exit 1
fi

# Handle zoom flag
if [[ "$3" = "zoom" ]]; then
  wezterm cli zoom-pane --pane-id "$new_pane" 2>> /tmp/pk.log
fi

# Send pk run command to the new pane
echo -en pk run\r" | wezterm cli send-text --no-paste --pane-id "$new_pane" 2>> /tmp/pk.log
