# panther-docker

Docker images dedicated to Husarion Panther ROS system and simulation.

## Docker Images

Docker images are automatically deployed to Docker Hub. Image tag includes information about the ROS distribution, the version of the [panther_ros](https://github.com/husarion/panther_ros/tree/ros2-devel) repository, and the date of release. Additionally stable image versions are tagged with `stable` and recommended for production use.
Below, you can find a list of available Docker images. To access the latest tag, simply follow provided links:

- [husarion/panther](https://hub.docker.com/r/husarion/panther) - ROS packages for Panther robot,
- [husarion/panther-gazebo](https://hub.docker.com/r/husarion/panther-gazebo) - Simulation for Panther robot in Gazebo-classic.

## Updating Panther Software

> [!Note]
> Latest Panther Docker images are compatible with Built-in Computer OS version 2.0.0 and newer. If your operating system is older, please ensure you update it before proceeding. **[COMING SOON]** Follow [operating system reinstallation](ros2-os-instalation-link) for more info.

Connect to Panther's Built-in Computer:

```bash
ssh husarion@10.15.20.2
```

## Quick Start

Depending on your needs, you can run Docker to quickly launch the physical robot or run a simulation. To do this, clone this repository to your robot or computer.

```bash
git clone -b ros2 https://github.com/husarion/panther-docker.git
cd panther-docker/demo
```

### 🤖 Robot

1. Activate Panther

   ```bash
   docker compose -f compose.minimal-setup.yaml up
   ```

2. Launch Visualization on PC

   ```bash
   xhost local:root
   docker compose -f compose.rviz.yaml up
   ```

> [!NOTE]
> To use the latest version of the image, run the `docker compose pull` command and rerun above commands.

### 💻 Gazebo Simulation

To give Docker access to your screen run:

```bash
xhost local:docker
docker compose -f compose.simulation.yaml up
```

> [!NOTE]
> If you have an NVIDIA GPU, it is worth changing the compose configuration from cpu-config to gpu-config. For this purpose, it is necessary to install [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html). With NVIDIA Container Toolkit installed, modify following Docker compose file by replacing `*cpu-config` with `*gpu-config`: [compose.simulation.yaml](./demo/compose.simulation.yaml).
