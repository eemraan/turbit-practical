#!/bin/bash
timestamp=$(date +"%Y%m%d%H%M%S")
# Configuration
BACKUP_DIR="/tmp/mongo-backup"                # Temporary directory for backup
BACKUP_FILENAME="backup_$timestamp.tar.gz"  # Backup filename
TARGET_VM_USER="vagrant"     # User on the target VM
TARGET_VM_IP="192.168.56.15"      # IP address of the target VM
TARGET_VM_DIR="/home/vagrant/mongo-backup"  # Directory on the target VM to store the backup

# Step 1: Create MongoDB Backup using mongodump
/usr/bin/mongodump --out "$BACKUP_DIR"

# Step 2: Tar the backup files
tar -czf "$BACKUP_FILENAME" -C "$BACKUP_DIR" .

# Step 3: Send the backup to the target VM using scp
scp "$BACKUP_FILENAME" "$TARGET_VM_USER@$TARGET_VM_IP:$TARGET_VM_DIR"

# Step 4: Cleanup - remove the temporary backup files
rm -f "$BACKUP_DIR/$BACKUP_FILENAME"
