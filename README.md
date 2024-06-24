# ROS1-Gazebo-Kortex-Docker

This repository provides a Docker environment setup for ROS1 with Gazebo, including the necessary dependencies for the [`ros_kortex`](https://github.com/Kinovarobotics/ros_kortex)package.

## Steps to Set Up the Docker Environment
### 1. Prequisites
This setup assumes you have a working Docker installation and necessary permissions.  
Ensure you have the xhost command installed and configured to allow Docker containers to access your display.  
the ros_kortex repository and other dependencies are cloned and installed during the Docker build process.  
    
### 2. Build the Docker Image

Run the following command to build the Docker image:

```bash
docker build -t ros1-gazebo-kortex .
```

### 3. Run the Docker Container

Run the Docker container with the following commands:

```bash
xhost +local:docker
docker run -it --rm \
    --env="DISPLAY" \
    --env="QT_X11 NO MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    ros1-gazebo-kortex
```
### 4. Source the ROS Setup Files

Once inside the Docker container, source the ROS and Catkin workspace setup files:

```bash
source /opt/ros/melodic/setup.bash
source /root/catkin_workspace/devel/setup.bash
```
### 5. Navigate to the Workspace
Change the directory to your Catkin workspace:

```bash
cd /root/catkin_workspace
```

### 6. Launch the Robot in Gazebo

Use the appropriate launch file to start the robot in Gazebo. Based on the ros_kortex repository. for example :

```bash
roslaunch kortex_gazebo spawn_kortex_robot.launch
```

For any further assistance, feel free to create an issue in this repository.

   - If you are using a Git GUI client, add the `README.md` file to the repository and commit it with a message like "Add README file".

6. **Push your changes to GitHub**.

This will add the `README.md` file to your repository and make it available on GitHub.
