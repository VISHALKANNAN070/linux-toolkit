#!/bin/bash

echo "=================================="
echo "        PROCESS OVERVIEW"
echo "=================================="
echo ""

PROC_COUNT=$1
echo ""

if [ -z "$PROC_COUNT" ]; then
	PROC_COUNT=10
fi

echo ""

echo "Top ${PROC_COUNT} Processes by Memory Usage:"
echo "--------------------------------------------"
echo ""
ps -eo pid,tid,%cpu,%mem,rss,comm --sort=-rss | \
awk '
NR==1 {
	printf "%-8s %-10s %-6s %-8s %-10s %-20s\n", "PID", "TID", "%CPU", "%MEM", "MEM(MB)", "COMMAND"
}
NR>1 {
	cmd = substr($0, index($0, $6))
	printf "%-8s %-10s %-6s %-8s %-10.2f %-40s\n", $1, $2, $3, $4, $5/1024, cmd
}' | head -n $((PROC_COUNT+1))
echo ""
echo "Total Number of Running Processes:"
ps -e --no-headers | wc -l
echo ""
