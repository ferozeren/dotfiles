#!/usr/bin/env bash

# Debug: Log arguments
echo "server.sh called with args: $1 $2 $3" >> /tmp/server.log

# Create a new pane and capture its ID
new_pane=$(wezterm cli split-pane --left --percent 30 2>> /tmp/server.log)
if [[ -z "$new_pane" ]]; then
  echo "Error: Failed to create new pane" >> /tmp/server.log
  exit 1
fi

# Handle zoom flag
if [[ "$3" = "zoom" ]]; then
  wezterm cli zoom-pane --pane-id "$new_pane" 2>> /tmp/server.log
fi

# Send live-server runcommand to the new pane
echo -en "live-server --browser=google-chrome-stable\r" | wezterm cli send-text --no-paste --pane-id "$new_pane" 2>> /tmp/server.log
