#!/usr/bin/env bash

# Debug: Log arguments
echo "ck.sh called with args: $1 $2 $3" >> /tmp/ck.log

# Create a new pane and capture its ID
new_pane=$(wezterm cli split-pane --bottom --percent 30 2>> /tmp/ck.log)
if [[ -z "$new_pane" ]]; then
  echo "Error: Failed to create new pane" >> /tmp/ck.log
  exit 1
fi

# Handle zoom flag
if [[ "$3" = "zoom" ]]; then
  wezterm cli zoom-pane --pane-id "$new_pane" 2>> /tmp/ck.log
fi

# Send ck run command to the new pane
echo -en "ck run\r" | wezterm cli send-text --no-paste --pane-id "$new_pane" 2>> /tmp/ck.log
