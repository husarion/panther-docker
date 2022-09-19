FROM ros:noetic-ros-core

# Use bash instead of sh
SHELL ["/bin/bash", "-c"]

# Update Ubuntu Software repository
RUN apt update \
    && apt upgrade -y \
    && apt install -y git \
        openssh-server \
        python3-dev \
        python3-pip \
        python3-rospkg \
        python3-tf2-ros \
        python3-pil \
        ros-$ROS_DISTRO-imu-filter-madgwick \
        ros-$ROS_DISTRO-nodelet \
        ros-$ROS_DISTRO-phidgets-drivers \
        ros-$ROS_DISTRO-tf \
        ros-$ROS_DISTRO-actionlib-msgs 

# Python 3 dependencies
RUN pip3 install \
        rosdep \
        rospkg \
        canopen \
        RPi.GPIO \
        gpiozero \
        paramiko \
        numpy \
        imageio \
        vcstool

WORKDIR /ros_ws

RUN git clone https://github.com/byq77/apa102-pi.git src/apa102-pi  && \
    cd src/apa102-pi && sudo python3 setup.py install

RUN git clone --branch panther_ros https://github.com/husarion/panther_ros.git src/panther_ros  && \
    vcs import src < src/panther_ros/panther/panther.repos

RUN mkdir build && \
    source /opt/ros/$ROS_DISTRO/setup.bash && \
    rosdep init && \
    rosdep update --rosdistro $ROS_DISTRO && \
    catkin_make -DCATKIN_ENABLE_TESTING=0 -DCMAKE_BUILD_TYPE=Release

# Clear 
RUN apt clean \
    && rm -rf /var/lib/apt/lists/* 

COPY ./ros_entrypoint.sh / 
ENTRYPOINT ["/ros_entrypoint.sh"]

CMD ["bash"]