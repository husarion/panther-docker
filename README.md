# panther-docker
Docker images dedicated to Husarion Panther ROS system and simulation.

## Docker images

Docker images are automatically deployed to Docker Hub. Image tag includes information about the ROS distribution, the version of the [panther_ros](https://github.com/husarion/panther_ros/tree/ros1) repository, and the date of release. Stable image versions are additionally tagged with `stable` and are recommended for production use.
Below, you can find a list of available Docker images. To access the latest tag, simply follow provided links:

- [husarion/panther](https://hub.docker.com/r/husarion/panther) - ROS packages for Panther robot, 
- [husarion/panther-gazebo](https://hub.docker.com/r/husarion/panther-gazebo) - Simulation for Panther robot in Gazebo-classic.

## Updating Panther Software

> NOTE:
> latest Panther Docker images are compatible with Built-in computer OS version 1.1.0 and newer. If your operating system is older, please ensure you update it before proceeding. Follow [operating system reinstallation](https://husarion.com/manuals/panther/operating-system-reinstallation/) for more info. 
 
Connect to Panther Built-in computer:
```bash
ssh husarion@10.15.20.2
```

Edit compose file:
```bash
nano compose.yaml
```

Update docker tag:
```yaml
  panther_ros:
    image: husarion/panther:<newest-stable-tag> # example tag: noetic-1.0.0-20230324-stable
```

Restart docker containers:
```bash
docker compose up -d --force-recreate
```

## Running simulation

To give Docker access to your screen run:
```bash
xhost local:docker
```

Depending on your hardware configuration your `compose.yaml` file may differ. For Intel and AMD users you will need the following configuration: [compose.simulation.yaml](./demo/simulation/compose.simulation.yaml).
To launch the simulation, from the directory containing compose file run:
```bash
  docker compose -f compose.simulation.yaml up
```

Nvidia users have to install nvidia-docker2. Installation steps can be found [here](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html). With nvidia-docker2 installed following compose file will be needed: [compose.simulation-gpu.yaml](./demo/simulation/compose.simulation-gpu.yaml).
To launch the simulation, from the directory containing compose file run:
```bash
docker compose -f compose.simulation-gpu.yaml up
```

You can go to http://localhost:8000 on your browser and use joystick to drive Panther robot.

