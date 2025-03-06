#!/bin/bash
# Simple script to display hostname, LimitNOFILE settings, and max open files

# Get hostname
HOSTNAME=$(hostname)

# Get LimitNOFILE from service file
SERVICE_LIMIT=$(systemctl cat duroslight-0 2>/dev/null | grep 'LimitNOFILE' | awk -F= '{print $2}')
if [ -z "$SERVICE_LIMIT" ]; then
    SERVICE_LIMIT="Not found"
fi

# Find duroslight process
DUROS_PID=$(ps -aux | grep -E "duroslight" | grep -v grep | head -1 | awk '{print $2}')
if [ -z "$DUROS_PID" ]; then
    MAX_FILES="No duroslight process found"
else
    # Get max open files from process limits
    MAX_FILES=$(sudo cat /proc/$DUROS_PID/limits 2>/dev/null | grep -i "Max open files" | awk '{print $4}')
    if [ -z "$MAX_FILES" ]; then
        MAX_FILES="Unable to access limits (try running as root)"
    fi
fi

# Display results in a simple format
echo "Hostname: $HOSTNAME"
echo "LimitNOFILE: $SERVICE_LIMIT"
echo "Max open files: $MAX_FILES"
