#!/bin/bash

# Show usage if no argument or --help is passed
if [ -z "$1" ] || [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
  echo "Usage: $0 <docker-container-name>"
  echo ""
  echo "Copies Jenkins libs and plugins from a Docker container into ~/jenkins_libs/"
  echo ""
  echo "You can find your container name by running:"
  echo "  docker ps"
  exit 1
fi

CONTAINER="$1"

mkdir -p ~/jenkins_libs/lib ~/jenkins_libs/plugins

echo "Copying libs from $CONTAINER..."
docker cp "$CONTAINER":/var/jenkins_home/war/WEB-INF/lib/. ~/jenkins_libs/lib/

echo "Copying plugins from $CONTAINER..."
docker cp "$CONTAINER":/var/jenkins_home/plugins/. ~/jenkins_libs/plugins/

echo "Done. Files copied to ~/jenkins_libs/"
