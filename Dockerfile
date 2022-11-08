FROM ros:noetic-ros-core

SHELL ["/bin/bash", "-c"]

WORKDIR /ros_ws

RUN apt-get update  && \
    apt-get install -y \
        git \
        python3-dev \
        python3-pip \
        python3-pil && \
    pip3 install \
        rosdep \
        imageio \
        vcstool && \
    git clone https://github.com/byq77/apa102-pi.git src/apa102-pi  && \
    cd src/apa102-pi && sudo python3 setup.py install && \
    git clone https://github.com/husarion/panther_ros.git src/panther_ros  && \
    vcs import src < src/panther_ros/panther/panther.repos && \
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