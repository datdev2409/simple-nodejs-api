#!/bin/bash

# CodeDeploy ApplicationStop Hook
# Stops the running Docker container
# This script ensures clean shutdown before deployment

set -e

echo "========================================="
echo "ApplicationStop: Stopping Docker container"
echo "========================================="

# Navigate to deployment directory
cd /opt/simple-nodejs-api

echo "Current directory: $(pwd)"

# Stop the container using make command
echo "Stopping Docker container..."
if [ -f Makefile ]; then
    make stop || echo "Container was not running or stop failed - continuing..."
else
    echo "Makefile not found, using direct docker commands"
    docker stop simple-api 2>/dev/null || echo "Container not running"
    docker rm simple-api 2>/dev/null || echo "Container does not exist"
fi

echo "Container stopped successfully"
exit 0
