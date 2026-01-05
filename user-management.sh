#!/bin/bash

# -------------------------------------------------
# Script: user-management.sh
# Description: Create or delete local Linux users
# Author: Nduvho Madzivhandila
# Usage:
#   sudo ./user-management.sh add <username>
#   sudo ./user-management.sh delete <username>
# -------------------------------------------------

# Ensure script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "ERROR: This script must be run as root."
  exit 1
fi

# Validate arguments
if [ $# -ne 2 ]; then
  echo "Usage:"
  echo "  $0 add <username>"
  echo "  $0 delete <username>"
  exit 1
fi

ACTION="$1"
USERNAME="$2"

# Validate username format (basic)
if ! [[ "$USERNAME" =~ ^[a-z_][a-z0-9_-]{2,31}$ ]]; then
  echo "ERROR: Invalid username format."
  exit 1
fi

# Add user
if [ "$ACTION" == "add" ]; then
  if id "$USERNAME" >/dev/null 2>&1; then
    echo "ERROR: User '$USERNAME' already exists."
    exit 2
  fi

  useradd -m "$USERNAME"

  if [ $? -eq 0 ]; then
    echo "User '$USERNAME' created successfully."
    echo "Please set a password using: passwd $USERNAME"
  else
    echo "ERROR: Failed to create user '$USERNAME'."
    exit 3
  fi

# Delete user
elif [ "$ACTION" == "delete" ]; then
  if ! id "$USERNAME" >/dev/null 2>&1; then
    echo "ERROR: User '$USERNAME' does not exist."
    exit 2
  fi

  read -p "Are you sure you want to delete user '$USERNAME'? [y/N]: " CONFIRM
  if [[ "$CONFIRM" =~ ^[Yy]$ ]]; then
    userdel -r "$USERNAME"

    if [ $? -eq 0 ]; then
      echo "User '$USERNAME' deleted successfully."
    else
      echo "ERROR: Failed to delete user '$USERNAME'."
      exit 3
    fi
  else
    echo "Operation cancelled."
    exit 0
  fi

else
  echo "ERROR: Invalid action. Use 'add' or 'delete'."
  exit 1
fi

