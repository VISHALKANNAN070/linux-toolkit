#!/bin/bash

echo "=================================="
echo "        SYSTEM INFORMATION"
echo "=================================="
echo ""

echo -n "Hostname : " ;cat /etc/hostname
echo ""

echo -n "Kernel : "; uname -s
echo ""

echo -n "Root : ";uname -r
echo ""

echo -n "Hardware : ";uname -m
echo ""

echo -n "Processor : ";uname -p
echo ""

echo -n "System Uptime : ";uptime -p
echo ""

echo "Memory Usage : " ;
free -h | awk 'NR==1 || NR==2 {print}'
echo ""

echo "Disk Usage (Root Filesystem) : ";
df -h / | awk 'NR==1 || NR==2 {print}'
echo ""
