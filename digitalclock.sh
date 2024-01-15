#!/bin/bash

# Function to convert hours, minutes, and seconds to total seconds
to_seconds() {
    local hours=$1
    local minutes=$2
    local seconds=$3
    echo $((hours * 3600 + minutes * 60 + seconds))
}

# Function to format seconds into HH:MM:SS
format_time() {
    local seconds=$1
    local hours=$((seconds / 3600))
    local minutes=$(( (seconds % 3600) / 60 ))
    local seconds=$((seconds % 60))
    printf "%02d:%02d:%02d" $hours $minutes $seconds #to display hours,minutes and seconds with a two characters format if it's than 10
}

# Function to display the countdown for a given duration
countdown() {
    local total_seconds=$1
    local current_seconds=$total_seconds

    while [ $current_seconds -gt 0 ]; do
        formatted_time=$(format_time $current_seconds)
        echo -ne "Time left: $formatted_time\033[0K\r" #it updates the time on the same line
        sleep 1
        : $((current_seconds--))
    done

    echo -e "Time's up!\033[0K"
}

# Check if hours, minutes, and seconds are provided as command-line arguments
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <hours> <minutes> <seconds>"
    exit 1
fi

# Get the countdown duration in hours, minutes, and seconds from the command-line arguments
hours=$1
minutes=$2
seconds=$3

# Convert to total seconds
duration=$(to_seconds $hours $minutes $seconds)

# Call the countdown function with the specified duration
countdown $duration
