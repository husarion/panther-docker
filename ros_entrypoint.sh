#!/bin/bash
set -e

# setup ros environment
source "/opt/ros/$ROS_DISTRO/setup.bash"
source "/ros2_ws/install/setup.bash"

if [ "$HUSARION_ROS_BUILD_TYPE" = "hardware" ]; then
  # source eeprom environment variables
  set -a
  source "/run/husarion/panther_config.env"
fi

exec "$@"
