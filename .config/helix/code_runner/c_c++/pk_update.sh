# #!/usr/bin/env bash

# # Debug: Log arguments
# echo "pk_update.sh called with args: $1" >> /tmp/pk_update.log

# # Get the current pane ID from the argument
# current_pane="$1"
# if [[ -z "$current_pane" ]]; then
#   echo "Error: No current pane ID provided" >> /tmp/pk_update.log
#   exit 1
# fi

# # Get the window ID of the current pane using wezterm cli list
# window_id=$(wezterm cli list --format json | jq -r --arg pid "$current_pane" '.[] | select(.pane_id == ($pid | tonumber)) | .window_id')
# if [[ -z "$window_id" ]]; then
#   echo "Error: Failed to get window ID for pane $current_pane" >> /tmp/pk_update.log
#   exit 1
# fi

# # Find another pane in the same window (not the current one)
# target_pane=$(wezterm cli list --format json | jq -r --arg wid "$window_id" --arg pid "$current_pane" \
#   '.[] | select(.window_id == ($wid | tonumber) and .pane_id != ($pid | tonumber)) | .pane_id' | head -n 1)

# if [[ -z "$target_pane" ]]; then
#   echo "Error: No other pane found in window $window_id" >> /tmp/pk_update.log
#   exit 1
# fi

# # Send 'clear' and 'pk run' to the target pane
# # echo -en "clear\r" | wezterm cli send-text --no-paste --pane-id "$target_pane" 2>> /tmp/pk_update.log
# echo -en "pk run\r" | wezterm cli send-text --no-paste --pane-id "$target_pane" 2>> /tmp/pk_update.log

# exit 0

# 1

# #!/usr/bin/env bash

# # Debug: Log arguments
# echo "pk_update.sh called with args: $1" >> /tmp/pk_update.log

# # Get the current pane ID from the argument
# current_pane="$1"
# if [[ -z "$current_pane" ]]; then
#   echo "Error: No current pane ID provided" >> /tmp/pk_update.log
#   exit 1
# fi

# # Get the window ID of the current pane using wezterm cli list
# window_id=$(wezterm cli list --format json | jq -r --arg pid "$current_pane" '.[] | select(.pane_id == ($pid | tonumber)) | .window_id')
# if [[ -z "$window_id" ]]; then
#   echo "Error: Failed to get window ID for pane $current_pane" >> /tmp/pk_update.log
#   exit 1
# fi

# # Find another pane in the same window (not the current one)
# target_pane=$(wezterm cli list --format json | jq -r --arg wid "$window_id" --arg pid "$current_pane" \
#   '.[] | select(.window_id == ($wid | tonumber) and .pane_id != ($pid | tonumber)) | .pane_id' | head -n 1)

# if [[ -z "$target_pane" ]]; then
#   echo "Error: No other pane found in window $window_id" >> /tmp/pk_update.log
#   exit 1
# fi

# # Get the title of the target pane
# pane_title=$(wezterm cli list --format json | jq -r --arg pid "$target_pane" '.[] | select(.pane_id == ($pid | tonumber)) | .title')

# # Define shell patterns for an "idle" terminal
# shell_patterns=("bash" "zsh" "fish" "sh")
# is_idle_shell=false

# # Check if the pane title suggests an idle shell
# for shell in "${shell_patterns[@]}"; do
#   if [[ "$pane_title" =~ $shell ]]; then
#     is_idle_shell=true
#     break
#   fi
# done

# # If the pane is not an idle shell, assume it's occupied and skip
# if [[ "$is_idle_shell" == false ]]; then
#   echo "Error: Target pane $target_pane is occupied (title: '$pane_title'). Skipping pk run." >> /tmp/pk_update.log
#   exit 1
# fi

# # Optional: Additional check for shell prompt (if needed)
# # Send a no-op command (like Enter) to check if the pane is at a prompt
# # echo -en "\r" | wezterm cli send-text --no-paste --pane-id "$target_pane" 2>> /tmp/pk_update.log
# # sleep 0.1  # Wait briefly for output
# # This requires capturing pane output, which Wezterm CLI doesn't support easily

# # Send 'clear' and 'pk run' to the target pane
# # echo -en "clear\r" | wezterm cli send-text --no-paste --pane-id "$target_pane" 2>> /tmp/pk_update.log
# echo -en "pk run\r" | wezterm cli send-text --no-paste --pane-id "$target_pane" 2>> /tmp/pk_update.log

# exit 0


# 2
#!/usr/bin/env bash

# Debug: Log arguments
echo "pk_update.sh called with args: $1" >> /tmp/pk_update.log

# Get the current pane ID from the argument
current_pane="$1"
if [[ -z "$current_pane" ]]; then
  echo "Error: No current pane ID provided" >> /tmp/pk_update.log
  exit 1
fi

# Get the window ID of the current pane using wezterm cli list
window_id=$(wezterm cli list --format json | jq -r --arg pid "$current_pane" '.[] | select(.pane_id == ($pid | tonumber)) | .window_id')
if [[ -z "$window_id" ]]; then
  echo "Error: Failed to get window ID for pane $current_pane" >> /tmp/pk_update.log
  exit 1
fi

# Get all panes in the same window (excluding the current one)
pane_ids=($(wezterm cli list --format json | jq -r --arg wid "$window_id" --arg pid "$current_pane" \
  '.[] | select(.window_id == ($wid | tonumber) and .pane_id != ($pid | tonumber)) | .pane_id'))

if [[ ${#pane_ids[@]} -eq 0 ]]; then
  echo "Error: No other panes found in window $window_id" >> /tmp/pk_update.log
  exit 1
fi

# Define shell patterns for an "idle" terminal
shell_patterns=("bash" "zsh" "fish" "sh")

# Iterate through panes to find an idle one
target_pane=""
for pane_id in "${pane_ids[@]}"; do
  # Get the title of the pane
  pane_title=$(wezterm cli list --format json | jq -r --arg pid "$pane_id" '.[] | select(.pane_id == ($pid | tonumber)) | .title')

  # Check if the pane title suggests an idle shell
  is_idle_shell=false
  for shell in "${shell_patterns[@]}"; do
    if [[ "$pane_title" =~ $shell ]]; then
      is_idle_shell=true
      break
    fi
  done


# Explicitly exclude yazi by checking the title
  if [[ "$pane_title" =~ "bash" ]]; then
    echo "Pane $pane_id is occupied (title: '$pane_title'). Checking next pane." >> /tmp/pk_update.log
    continue
  fi


  if [[ "$is_idle_shell" == true ]]; then
    # Found an idle pane, use it
    target_pane="$pane_id"
    echo "Found idle pane $target_pane (title: '$pane_title')" >> /tmp/pk_update.log
    break
  else
    # Pane is occupied, log and continue
    echo "Pane $pane_id is occupied (title: '$pane_title'). Checking next pane." >> /tmp/pk_update.log
  fi
done

# If no idle pane was found, exit
if [[ -z "$target_pane" ]]; then
  echo "Error: No idle panes found in window $window_id" >> /tmp/pk_update.log
  exit 1
fi

# Send 'clear' and 'pk run' to the target pane
# echo -en "clear\r" | wezterm cli send-text --no-paste --pane-id "$target_pane" 2>> /tmp/pk_update.log
echo -en "pk run\r" | wezterm cli send-text --no-paste --pane-id "$target_pane" 2>> /tmp/pk_update.log

exit 0
