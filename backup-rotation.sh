# --------------------------------------------------------------------
# Description: This script delete the oldest backups & keeps latest backup of 7 copies.
# Author: Vijay Powar
# Version: V1
# --------------------------------------------------------------------
#
#!/bin/bash
set -x  # Enable debug mode
set -u  # Exit on use of uninitialized variable
set -e  # Exit on any command failure
set -o pipefail  # Capture pipeline errors

# Define the directory where backups are stored
backup_dir="/path/to/backups"

# Define the maximum number of backups to keep
max_backups=7

# While the number of backups is greater than the maximum allowed
while [ $(ls -1 "$backup_dir" | wc -l) -gt "$max_backups" ]; do
  # Find the oldest backup by sorting the backups by modification time (oldest last) and picking the last one
  oldest_backup=$(ls -1t "$backup_dir" | tail -n 1)
  # Remove the oldest backup
  rm -r "$backup_dir/$oldest_backup"
done

# Print a message indicating the backup rotation is complete
echo "Backup rotation completed."

# Crontab // Execute this script on everyday at 12 AM
0 0 * * * /path/to/script/backup-rotation.sh