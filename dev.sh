#!/bin/bash
# Launch Claude Code development container
# Usage: ./dev.sh [project-directory]

PROJECT_DIR="${1:-$(pwd)}"
IMAGE_NAME="realaiengineering/claude-dev:latest"

# Validate project directory
if [ ! -d "$PROJECT_DIR" ]; then
  echo "Error: Directory $PROJECT_DIR does not exist"
  exit 1
fi

# Check if required directories exist
if [ ! -d "$HOME/.claude" ]; then
  echo "Warning: ~/.claude directory not found"
fi

if [ ! -f "$HOME/.claude.json" ]; then
  echo "Warning: ~/.claude.json file not found"
fi

if [ ! -d "$HOME/.ssh" ]; then
  echo "Warning: ~/.ssh directory not found"
fi

# Pull latest image from Docker Hub
echo "Pulling latest image from Docker Hub..."
if ! docker pull $IMAGE_NAME; then
  echo "Failed to pull image from Docker Hub. Building locally..."
  docker build -t $IMAGE_NAME -f .devcontainer/Dockerfile .devcontainer/
fi

# Run container with mounts
echo "Starting container with project: $PROJECT_DIR"
docker run -it --rm \
  --name claude-dev-container \
  --cap-add=NET_ADMIN \
  --cap-add=NET_RAW \
  -v "$PROJECT_DIR:/workspace" \
  -v "$HOME/.claude:/home/node/.claude" \
  -v "$HOME/.claude.json:/home/node/.claude.json" \
  -v "$HOME/.claude.json.backup:/home/node/.claude.json.backup" \
  -v "$HOME/.ssh:/home/node/.ssh:ro" \
  -v "claude-bashhistory:/commandhistory" \
  \
  -e NODE_OPTIONS="--max-old-space-size=4096" \
  -e POWERLEVEL9K_DISABLE_GITSTATUS=true \
  -w /workspace \
  $IMAGE_NAME \
  /bin/zsh #    -e CLAUDE_CONFIG_DIR=/home/node/.claude \

