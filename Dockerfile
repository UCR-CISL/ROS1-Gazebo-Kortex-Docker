# Use the official ROS Melodic base image
FROM osrf/ros:melodic-desktop-full

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

# Install necessary packages
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    git \
    python-rosdep \
    ros-melodic-moveit \
    ros-melodic-ros-controllers \
    ros-melodic-ros-control \
    && rm -rf /var/lib/apt/lists/*

# Install Conan
RUN python3 -m pip install conan==1.59

# Configure Conan
RUN conan config set general.revisions_enabled=1 && \
    conan profile new default --detect > /dev/null && \
    conan profile update settings.compiler.libcxx=libstdc++11 default

# Initialize rosdep if not already initialized
RUN if [ ! -f /etc/ros/rosdep/sources.list.d/20-default.list ]; then rosdep init; fi && rosdep update

# Create and setup catkin workspace
RUN mkdir -p /root/catkin_workspace/src && \
    cd /root/catkin_workspace/src && \
    git clone -b melodic-devel https://github.com/Kinovarobotics/ros_kortex.git && \
    cd /root/catkin_workspace && \
    /bin/bash -c "source /opt/ros/melodic/setup.bash && rosdep install --from-paths src --ignore-src -y"

# Source ROS setup.bash and build the workspace
RUN /bin/bash -c "source /opt/ros/melodic/setup.bash && cd /root/catkin_workspace && catkin_make"

# Set the default command to start a bash session
CMD ["bash"]

