
#!/bin/bash

PROFILE_FILE="/sys/firmware/acpi/platform_profile" # fallback for some devices
AVAILABLE_PROFILES=$(powerprofilesctl list 2>/dev/null | grep -oP '(?<=\[)\w+(?=\])' | tr '\n' ' ')

get_current_profile() {
    powerprofilesctl get 2>/dev/null || cat "$PROFILE_FILE" 2>/dev/null
}

set_profile() {
    powerprofilesctl set "$1" 2>/dev/null
}

toggle_profile() {
    current=$(get_current_profile)
    case "$current" in
        power-saver) set_profile balanced ;;
        balanced) set_profile performance ;;
        performance) set_profile power-saver ;;
        *) set_profile balanced ;;
    esac
}

icon_for_profile() {
    case "$1" in
        power-saver) echo "󰾆  S" ;;
        balanced) echo " B" ;;
        performance) echo " P" ;;
        # power-saver) echo "󰾆 Power Saver" ;;
        # balanced) echo " Balanced" ;;
        # performance) echo " Performance" ;;
        *) echo "" ;;
    esac
}

if [ "$1" == "toggle" ]; then
    toggle_profile
    exit 0
fi

profile=$(get_current_profile)
icon=$(icon_for_profile "$profile")

echo "{\"text\": \"$icon\", \"tooltip\": \"Current profile: $profile\nClick to change.\"}"
