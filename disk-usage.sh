#!/bin/bash

# -------------------------------------------------
# Script: disk-usage.sh
# Description: Checks disk usage and warns if usage
#              exceeds a defined threshold.
# Author: Nduvho Madzivhandila
# -------------------------------------------------

THRESHOLD=80

echo "Checking disk usage on $(hostname)..."
echo "--------------------------------------"

df -h --output=source,pcent,target | tail -n +2 | while read filesystem usage mountpoint
do
    usage_percent=$(echo "$usage" | tr -d '%')

    if [ "$usage_percent" -ge "$THRESHOLD" ]; then
        echo "WARNING: $filesystem mounted on $mountpoint is at ${usage_percent}% usage"
    else
        echo "OK: $filesystem mounted on $mountpoint is at ${usage_percent}% usage"
    fi
done

echo "--------------------------------------"
echo "Disk usage check completed."

