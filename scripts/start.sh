#!/bin/bash

# CodeDeploy ApplicationStart Hook
# Builds and starts the Docker container
# This script runs after files are deployed from S3 via CodeDeploy

set -e

echo "========================================="
echo "ApplicationStart: Building and starting Docker container"
echo "========================================="

# Navigate to deployment directory
cd /opt/simple-nodejs-api

# Verify we're in the right directory
echo "Current directory: $(pwd)"
ls -la

# Rebuild Docker image to include latest code
echo "Step 1: Building Docker image..."
if ! make build; then
    echo "ERROR: Docker build failed"
    exit 1
fi

echo "Docker image built successfully"

# Start the container
echo "Step 2: Starting Docker container..."
if ! make run; then
    echo "ERROR: Docker run failed"
    exit 1
fi

echo "Docker container started successfully"

# Give container time to initialize
echo "Waiting for container to initialize..."
sleep 5

echo "ApplicationStart completed successfully"
exit 0
