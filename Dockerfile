FROM ros:noetic-ros-core

# Use bash instead of sh
SHELL ["/bin/bash", "-c"]

# Update Ubuntu Software repository
RUN apt-get update  && \
    apt-get upgrade -y && \
    apt-get install -y \
        git \
        python3-dev \
        python3-pip \
        python3-pil && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Python 3 dependencies
RUN pip3 install \
        rosdep \
        imageio \
        vcstool

WORKDIR /ros_ws

RUN git clone https://github.com/byq77/apa102-pi.git src/apa102-pi  && \
    cd src/apa102-pi && sudo python3 setup.py install

RUN git clone https://github.com/husarion/panther_ros.git src/panther_ros  && \
    vcs import src < src/panther_ros/panther/panther.repos

RUN apt-get update  && \
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