# --------------------------------------------------------------------
# Description: This script monitor the disk usage on every 5 minutes & send the email alert.
# Author: Vijay Powar
# Version: V1
# --------------------------------------------------------------------
#
#!/bin/bash
set -x  # Enable debug mode
set -u  # Exit on use of uninitialized variable
set -e  # Exit on any command failure
set -o pipefail  # Capture pipeline errors

#!/bin/bash

# Threshold for disk usage (percentage)
threshold=85

# Get the disk usage percentage of /dev/sda1
disk_usage=$(df -h | grep "/dev/sda1" | awk '{print $5}' | cut -d% -f1)

# Check if the disk usage exceeds the threshold
if [ "$disk_usage" -gt "$threshold" ]; then
  echo "High disk usage detected: $disk_usage%"
  
  # Add alert/notification logic here
  # Example: Send an email alert
  echo "Disk usage on /dev/sda1 has reached $disk_usage%" | mail -s "Disk Usage Alert" admin@example.com
fi

# Crontab // Execute this script on every 5 minute
*/5 * * * * /path/to/script/disk-usage-monitoring.sh