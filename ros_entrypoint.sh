#!/bin/bash
set -e

# setup ros environment
source "/opt/ros/$ROS_DISTRO/setup.bash"
source "/ros_ws/devel/setup.bash"

# source eeprom environemnt variables
set -a
source "/run/husarion/panther_config.env"

exec "$@"