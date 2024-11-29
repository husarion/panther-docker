#!/bin/bash
set -e

# source robot environment
source /run/husarion/robot_config.env

# Copy files to /config directory if the directory is empty except for .env and cyclonedds.xml
if [ -z "$(find /config -type f | grep -v '/\.env$' | grep -v '/cyclonedds.xml$')" ]; then
  echo "Config directory is empty, copying files."
  update_config_directory
fi
