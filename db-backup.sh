#############################################################################
# Auther: Vijay Powar
# This script automates the mongoDB database backup & cleanup
# Version: v1
#############################################################################
set -x # Enables debug mode
set -u # Capture uninitilised variable
set -e # Cactures the command failure
set -o pipefail  
# set -e will not capture the pipe failure so use set -o command with set -e 
# set -o captures the pipe failure and prints

#!/bin/bash
current="$(date +'%d-%m-%Y_%H:%M')"
filename="mongo_backup_$current"
backupdir="/var/mongodb/backup/"
fullpath="$backupdir/$filename"
logfile="$backupdir/"backup_log_"$(date +'%d-%m-%Y')".txt
echo "mongodump started at $(date +'%d-%m-%Y %H:%M')" >> "$logfile"
mongodump --username db-admin --password 1234 --gzip --
out="$fullpath" --authenticationDatabase admin
echo "mongodump finished at $(date +'%d-%m-%Y %H:%M :%S')" >> "$logfile"
chown vijay "$fullpath"
chown vijay "$logfile"
echo "file permission changed" >> "$logfile"
find "$backupdir" -name "mongo_backup*" -mtime +1 -exec rm -rf {} \; echo "old files deleted" >> "$logfile"
echo "operation finished at $(date +'%d-%m-%Y %H :%M:%S') ">> "$logfile"
echo "*******" >> "$logfile"
exit 0

# Crontab

0 0 * * * /path/to/scrpt/db-backup.sh