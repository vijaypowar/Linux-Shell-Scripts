#!/bin/bash
# --------------------------------------------------------------------
# Description: Clean docker unused resources based on threshold value.
# Author: Vijay Powar
# Version: V1
# --------------------------------------------------------------------

set -x  # Enable debug mode
set -u  # Exit on use of uninitialized variable
set -e  # Exit on any command failure
set -o pipefail  # Capture pipeline errors

# Set variables for cleanup thresholds
CONTAINER_THRESHOLD="7d"
IMAGE_THRESHOLD="7d"
VOLUME_THRESHOLD="30d"

# Clean stopped containers older than threshold
echo "Cleaning stopped containers older than $CONTAINER_THRESHOLD..."
docker container prune --filter "until=$CONTAINER_THRESHOLD" -f

# Clean unused images older than threshold
echo "Cleaning unused images older than $IMAGE_THRESHOLD..."
docker image prune --filter "until=$IMAGE_THRESHOLD" -f

# Clean unused volumes older than threshold
echo "Cleaning unused volumes older than $VOLUME_THRESHOLD..."
docker volume prune --filter "until=$VOLUME_THRESHOLD" -f

echo "Docker cleanup complete."

