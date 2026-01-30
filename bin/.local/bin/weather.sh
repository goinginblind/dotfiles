#!/bin/bash

while true; do
    # Run wttrbar with timeout
    # output=$(timeout 10s wttrbar --nerd --location moscow --custom-indicator "{ICON} {temp_C}°" 2>/dev/null)
    output=$(timeout 10s wttrbar --nerd --location moscow --custom-indicator "{temp_C}°" 2>/dev/null)

    # Check if output starts with { (indicating JSON)
    if [[ "$output" == \{* ]]; then
        echo "$output"
        # SUCCESS: Wait 10 minutes before next check
        sleep 600
    else
        echo '{"text": "NA", "tooltip": "Offline / Weather Unavailable"}'
        # echo '{"text": "", "tooltip": "Offline / Weather Unavailable"}'
        # FAILURE: Wait 30 seconds and retry automatically
        sleep 30 
    fi
done
