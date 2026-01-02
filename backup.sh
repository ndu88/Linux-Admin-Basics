#!/bin/bash

SOURCE_DIR="/etc"
BACKUP_DIR="/var/backups"
DATE=$(date +"%Y-%m-%d")
BACKUP_FILE="backup_$DATE.tar.gz"

echo "Starting backup of $SOURCE_DIR..."

if [ ! -d "$BACKUP_DIR" ]; then
  echo "Backup directory does not exist. Creating $BACKUP_DIR"
  mkdir -p "$BACKUP_DIR"
fi

tar -czf "$BACKUP_DIR/$BACKUP_FILE" "$SOURCE_DIR"

if [ $? -eq 0 ]; then
  echo "Backup completed successfully: $BACKUP_DIR/$BACKUP_FILE"
else
  echo "Backup failed"
fi
