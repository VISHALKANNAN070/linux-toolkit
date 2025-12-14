#!/bin/bash

echo "=================================="
echo "        SYSTEM LOG OVERVIEW"
echo "=================================="
echo ""

LOG_COUNT="$1"

# Default value
if [ -z "$LOG_COUNT" ]; then
    LOG_COUNT=5
fi

echo ""

if command -v journalctl >/dev/null 2>&1; then
    echo "Log source: systemd journal"
    echo ""

    echo "Last ${LOG_COUNT} system events:"
    echo "------------------------------"
    journalctl -n "$LOG_COUNT" --no-pager \
        --output=short-iso | sed 'G'
    echo ""

    echo "Recent important issues (errors only):"
    echo "-------------------------------------"
    journalctl -p err -n "$LOG_COUNT" --no-pager \
        --output=short-iso | sed 'G'
    echo ""

else
    LOG_FILE=""

    if [ -f /var/log/syslog ]; then
        LOG_FILE="/var/log/syslog"
    elif [ -f /var/log/messages ]; then
        LOG_FILE="/var/log/messages"
    else
        echo "No readable system logs found."
        exit 1
    fi

    echo "Log source: $LOG_FILE"
    echo ""

    echo "Last ${LOG_COUNT} system events:"
    echo "------------------------------"
    tail -n "$LOG_COUNT" "$LOG_FILE"
    echo ""

    echo "Recent errors:"
    echo "--------------"
    grep -i "error" "$LOG_FILE" | tail -n "$LOG_COUNT"
    echo ""
fi
