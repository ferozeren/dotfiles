#!/usr/bin/env bash

# Debug: Log arguments
echo "cargo_run.sh called with args: $1 $2 $3" >> /tmp/cargo_run.log

# Create a new pane and capture its ID
new_pane=$(wezterm cli split-pane --left --percent 30 2>> /tmp/cargo_run.log)
if [[ -z "$new_pane" ]]; then
  echo "Error: Failed to create new pane" >> /tmp/cargo_run.log
  exit 1
fi

# Handle zoom flag
if [[ "$3" = "zoom" ]]; then
  wezterm cli zoom-pane --pane-id "$new_pane" 2>> /tmp/cargo_run.log
fi

# Send cargo run command to the new pane
echo -en "cargo run\r" | wezterm cli send-text --no-paste --pane-id "$new_pane" 2>> /tmp/cargo_run.log
