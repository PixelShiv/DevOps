#!/bin/bash

# File to backup
FILE="/home/ec2-user/DevOps/myfile.txt"

# Backup directory
BACKUP_DIR="/home/ec2-user/DevOps/backups"

# Create backup directory if not exists
mkdir -p $BACKUP_DIR

# Timestamp
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

# Backup file name
BASENAME=$(basename $FILE)
BACKUP_FILE="$BACKUP_DIR/${BASENAME}_$TIMESTAMP.bak"

# Perform backup
if [ -f "$FILE" ]; then
    cp $FILE $BACKUP_FILE
    echo "Backup successful: $BACKUP_FILE"
else
    echo "Error: File $FILE not found!"
    exit 1
fi
