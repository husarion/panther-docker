#!/bin/bash
set -e

# source robot environment
source /run/husarion/robot_config.env

# Copy files to /config directory if the directory is empty except for .env file
if [ "$(ls /config | grep -v '^\.env$')" ]; then
  echo "Config directory is not empty, skipping file copy."
else
  echo "Config directory is empty, copying files."
  update_config_directory
fi
