#!/usr/bin/env bash

# Path to a temporary file to store Yazi's selected paths


#!/usr/bin/env bash

# File to store last directory
LAST_DIR_FILE="/tmp/yazi_last_dir.txt"

# Zoom if requested
if [ "$3" = "zoom" ]; then
  wezterm cli zoom-pane
fi

while true; do
  # Set default start dir to last used if it exists
  if [ -f "$LAST_DIR_FILE" ]; then
    start_dir=$(<"$LAST_DIR_FILE")
    paths=$(yazi "$start_dir" --chooser-file=/dev/stdout | while read -r; do printf "%q " "$REPLY"; done)
  else
    paths=$(yazi --chooser-file=/dev/stdout | while read -r; do printf "%q " "$REPLY"; done)
  fi

  # Break if nothing selected
  if [[ -z "$paths" ]]; then
    break
  fi

  # Save the directory of the first selected file
  first_path=$(eval echo $paths | awk '{print $1}')
  dirname "$first_path" > "$LAST_DIR_FILE"

  # Send the file(s) to the target pane
  echo -en ":$2 $paths\r" | wezterm cli send-text --no-paste --pane-id "$1"

  # Switch focus to the target pane
  wezterm cli activate-pane --pane-id "$1"
done

# if [ "$3" = "zoom" ]; then
#   wezterm cli zoom-pane
# fi

# paths=$(yazi --chooser-file=/dev/stdout | while read -r; do printf "%q " "$REPLY"; done)

# if [[ -n "$paths" ]]; then
#   echo -en ":$2 $paths\r" | wezterm cli send-text --no-paste --pane-id $1
# fi


