#!/usr/bin/env bash

# Debug: Log arguments
echo "uv.sh called with args: $1 $2 $3" >> /tmp/uv.log

# Create a new pane and capture its ID
new_pane=$(wezterm cli split-pane --left --percent 30 2>> /tmp/uv.log)
if [[ -z "$new_pane" ]]; then
  echo "Error: Failed to create new pane" >> /tmp/uv.log
  exit 1
fi

# Handle zoom flag
if [[ "$3" = "zoom" ]]; then
  wezterm cli zoom-pane --pane-id "$new_pane" 2>> /tmp/uv.log
fi

# Send uv run main.py command to the new pane
echo -en "uv run main.py \r" | wezterm cli send-text --no-paste --pane-id "$new_pane" 2>> /tmp/uv.log
