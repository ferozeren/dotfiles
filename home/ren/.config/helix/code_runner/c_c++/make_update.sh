
#!/usr/bin/env bash

echo "make_update.sh called with args: $1" >> /tmp/make_update.log

current_pane="$1"
if [[ -z "$current_pane" ]]; then
  echo "Error: No current pane ID provided" >> /tmp/make_update.log
  exit 1
fi

window_id=$(wezterm cli list --format json | jq -r --arg pid "$current_pane" \
  '.[] | select(.pane_id == ($pid | tonumber)) | .window_id')

if [[ -z "$window_id" ]]; then
  echo "Error: Failed to get window ID for pane $current_pane" >> /tmp/make_update.log
  exit 1
fi

pane_ids=($(wezterm cli list --format json | jq -r --arg wid "$window_id" --arg pid "$current_pane" \
  '.[] | select(.window_id == ($wid | tonumber) and .pane_id != ($pid | tonumber)) | .pane_id'))

if [[ ${#pane_ids[@]} -eq 0 ]]; then
  echo "Error: No other panes found in window $window_id" >> /tmp/make_update.log
  exit 1
fi

target_pane="${pane_ids[0]}"
echo "Using target pane: $target_pane" >> /tmp/make_update.log

# 1. Send Ctrl+C
wezterm cli send-text --pane-id "$target_pane" --no-paste $'\x03' 2>> /tmp/make_update.log
sleep 0.2

# 2. Send the command + real Enter (not '\r' string)
wezterm cli send-text --pane-id "$target_pane" --no-paste $"clear; and make run"$'\r' 2>> /tmp/make_update.log

exit 0


# Without Killing pane processes
# #!/usr/bin/env bash

# # Debug: Log arguments
# echo "make_update.sh called with args: $1" >> /tmp/make_update.log

# # Get the current pane ID from the argument
# current_pane="$1"
# if [[ -z "$current_pane" ]]; then
#   echo "Error: No current pane ID provided" >> /tmp/make_update.log
#   exit 1
# fi

# # Get the window ID of the current pane using wezterm cli list
# window_id=$(wezterm cli list --format json | jq -r --arg pid "$current_pane" '.[] | select(.pane_id == ($pid | tonumber)) | .window_id')
# if [[ -z "$window_id" ]]; then
#   echo "Error: Failed to get window ID for pane $current_pane" >> /tmp/make_update.log
#   exit 1
# fi

# # Get all panes in the same window (excluding the current one)
# pane_ids=($(wezterm cli list --format json | jq -r --arg wid "$window_id" --arg pid "$current_pane" \
#   '.[] | select(.window_id == ($wid | tonumber) and .pane_id != ($pid | tonumber)) | .pane_id'))

# if [[ ${#pane_ids[@]} -eq 0 ]]; then
#   echo "Error: No other panes found in window $window_id" >> /tmp/make_update.log
#   exit 1
# fi

# # Define shell patterns for an "idle" terminal
# shell_patterns=("bash" "zsh" "fish" "sh")

# # Iterate through panes to find an idle one
# target_pane=""
# for pane_id in "${pane_ids[@]}"; do
#   # Get the title of the pane
#   pane_title=$(wezterm cli list --format json | jq -r --arg pid "$pane_id" '.[] | select(.pane_id == ($pid | tonumber)) | .title')

#   # Chemake if the pane title suggests an idle shell
#   is_idle_shell=false
#   for shell in "${shell_patterns[@]}"; do
#     if [[ "$pane_title" =~ $shell ]]; then
#       is_idle_shell=true
#       break
#     fi
#   done

# # Explicitly exclude yazi by chemakeing the title
#   if [[ "$pane_title" =~ "bash" ]]; then
#     echo "Pane $pane_id is occupied (title: '$pane_title'). Chemakeing next pane." >> /tmp/make_update.log
#     continue
#   fi

#   if [[ "$is_idle_shell" == true ]]; then
#     # Found an idle pane, use it
#     target_pane="$pane_id"
#     echo "Found idle pane $target_pane (title: '$pane_title')" >> /tmp/make_update.log
#     break
#   else
#     # Pane is occupied, log and continue
#     echo "Pane $pane_id is occupied (title: '$pane_title'). Chemakeing next pane." >> /tmp/make_update.log
#   fi
# done

# # If no idle pane was found, exit
# if [[ -z "$target_pane" ]]; then
#   echo "Error: No idle panes found in window $window_id" >> /tmp/make_update.log
#   exit 1
# fi

# # Send 'clear' and 'make run' to the target pane
# # echo -en "clear\r" | wezterm cli send-text --no-paste --pane-id "$target_pane" 2>> /tmp/make_update.log
# echo -en "make \r" | wezterm cli send-text --no-paste --pane-id "$target_pane" 2>> /tmp/make_update.log

# exit 0


