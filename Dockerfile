FROM ros:noetic-ros-core

SHELL ["/bin/bash", "-c"]

WORKDIR /ros_ws

RUN apt-get update  && \
    apt-get install -y \
        git \
        python3-dev \
        python3-pip && \
    pip3 install \
        rosdep \
        vcstool && \
    git clone https://github.com/husarion/panther_ros.git src/panther_ros && \
    vcs import src < src/panther_ros/panther/panther.repos && \
    cd src/apa102-pi && sudo python3 setup.py install && \
    cd /ros_ws && \
    rosdep init && \
    rosdep update --rosdistro $ROS_DISTRO && \
    rosdep install --from-paths src -y -i && \
    source /opt/ros/$ROS_DISTRO/setup.bash && \
    catkin_make -DCATKIN_ENABLE_TESTING=0 -DCMAKE_BUILD_TYPE=Release && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY ./ros_entrypoint.sh / 
ENTRYPOINT ["/ros_entrypoint.sh"]