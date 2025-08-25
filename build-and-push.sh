#!/bin/bash
# Build and push Claude dev image to Docker Hub
# Usage: ./build-and-push.sh [dockerhub-username]

DOCKER_USER="${1:-realaiengineering}"
IMAGE_NAME="$DOCKER_USER/claude-dev"

# Check if we're in the right directory
if [ ! -f ".devcontainer/Dockerfile" ]; then
    echo "Error: .devcontainer/Dockerfile not found. Run this script from the project root."
    exit 1
fi

# Build the image
echo "Building $IMAGE_NAME:latest..."
docker build -t $IMAGE_NAME:latest -f .devcontainer/Dockerfile .devcontainer/

if [ $? -ne 0 ]; then
    echo "Error: Docker build failed"
    exit 1
fi

# Tag with version and date
VERSION=$(date +%Y%m%d)
docker tag $IMAGE_NAME:latest $IMAGE_NAME:$VERSION

echo "Tagged image as $IMAGE_NAME:$VERSION"

# Login to Docker Hub (will prompt for password if not already logged in)
echo "Checking Docker Hub login..."
if ! docker info | grep -q "Username:"; then
    echo "Logging in to Docker Hub..."
    docker login -u $DOCKER_USER
    if [ $? -ne 0 ]; then
        echo "Error: Docker Hub login failed"
        exit 1
    fi
fi

# Push both tags
echo "Pushing to Docker Hub..."
docker push $IMAGE_NAME:latest
if [ $? -ne 0 ]; then
    echo "Error: Failed to push latest tag"
    exit 1
fi

docker push $IMAGE_NAME:$VERSION
if [ $? -ne 0 ]; then
    echo "Error: Failed to push version tag"
    exit 1
fi

echo "Successfully pushed:"
echo "  - $IMAGE_NAME:latest"
echo "  - $IMAGE_NAME:$VERSION"
echo ""
echo "Image is now available at: https://hub.docker.com/r/$DOCKER_USER/claude-dev"