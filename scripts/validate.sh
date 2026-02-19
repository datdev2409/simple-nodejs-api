#!/bin/bash

# CodeDeploy ValidateService Hook
# Validates that the Docker container is running and responding
# Tests the health check endpoint

set -e

echo "========================================="
echo "ValidateService: Verifying deployment"
echo "========================================="

# Navigate to deployment directory
cd /opt/simple-nodejs-api

echo "Current directory: $(pwd)"

# Wait for container to be ready
echo "Waiting for service to be ready..."
sleep 3

# Check if container is running
CONTAINER_NAME="simple-api"
echo "Checking if container '$CONTAINER_NAME' is running..."

if ! docker ps --filter "name=$CONTAINER_NAME" --format "{{.Names}}" | grep -q "^${CONTAINER_NAME}$"; then
    echo "ERROR: Container $CONTAINER_NAME is not running"
    echo "Running containers:"
    docker ps -a
    exit 1
fi

echo "✓ Container $CONTAINER_NAME is running"

# Test the health check endpoint
echo "Testing health check endpoint..."
MAX_ATTEMPTS=10
ATTEMPT=1

while [ $ATTEMPT -le $MAX_ATTEMPTS ]; do
    echo "Attempt $ATTEMPT/$MAX_ATTEMPTS: Testing http://localhost:3000/health"
    
    if curl -sf http://localhost:3000/health > /dev/null 2>&1; then
        echo "✓ Health check passed"
        
        # Get more details
        echo "Service details:"
        curl -s http://localhost:3000/health
        echo ""
        
        echo "Deployment validation successful!"
        exit 0
    fi
    
    if [ $ATTEMPT -lt $MAX_ATTEMPTS ]; then
        echo "Health check failed, retrying in 3 seconds..."
        sleep 3
    fi
    
    ATTEMPT=$((ATTEMPT + 1))
done

echo "ERROR: Health check failed after $MAX_ATTEMPTS attempts"
echo ""
echo "Container logs:"
docker logs $CONTAINER_NAME || true

exit 1
