#############################################################################
# Auther: Vijay Powar
# This script automates the mongoDB log rotation & cleanup
# Version: v1
#############################################################################
set -x # Enables debug mode
set -u # Capture uninitilised variable
set -e # Cactures the command failure
set -o pipefail  
# set -e will not capture the pipe failure so use set -o command with set -e 
# set -o captures the pipe failure and prints

#!/bin/bash
mongodb_username="db-admin"
mongodb_password="1234"
mongo_command="db.adminCommand({ logRotate: 1 })"
mongosh --eval "$mongo_command" -u "$mongodb_username" -p "$mongodb_password"

sleep 120

log_dir="/var/log/mongodb/"
log_prefix="mongod.log.2024"
max_file_age=5 # Files older than 5 days will be removed

find "$log_dir" -name "$log_prefix*" -mtime +"$max_file_age" -exec rm -rf {}\;

echo "MongoDB log rotation and cleanup completed"

# crontab
0 18 * * * /path/to/script/db-log-rotate.sh >> /var/log/mongodb/db-log-rotate.log