#!/bin/bash

# -------------------------------------------------
# Script: service-check.sh
# Description: Checks the status of a systemd service
# Author: Nduvho Madzivhandila
# Usage: ./service-check.sh <service-name>
# -------------------------------------------------

# Check if a service name was provided
if [ -z "$1" ]; then
  echo "Usage: $0 <service-name>"
  exit 1
fi

SERVICE_NAME="$1"

echo "Checking status of service: $SERVICE_NAME"
echo "-----------------------------------------"

# Verify systemctl is available
if ! command -v systemctl >/dev/null 2>&1; then
  echo "ERROR: systemctl is not available on this system."
  exit 2
fi

# Check service status
if systemctl is-active --quiet "$SERVICE_NAME"; then
  echo "OK: Service '$SERVICE_NAME' is running."
  exit 0
else
  echo "WARNING: Service '$SERVICE_NAME' is NOT running."
  systemctl status "$SERVICE_NAME" --no-pager
  exit 3
fi

