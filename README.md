# Linux Gym Docker Image Setup Guide

This guide will help you set up and use a Docker container with a Debian-based Linux environment for practice. The container will have persistent storage, allowing you to save your work and continue where you left off.

## Prerequisites

- Docker installed on your machine. You can download and install Docker from [here](https://docs.docker.com/get-docker/).

### Note for Windows Users

On Windows, you will need to install [Docker Desktop](https://www.docker.com/products/docker-desktop). Docker Desktop includes Docker Engine, Docker CLI client, Docker Compose, Docker Content Trust, Kubernetes, and Credential Helper. It also requires the WSL 2 (Windows Subsystem for Linux 2) feature enabled for better performance.

### Note for Linux Users

On Linux, Docker commands might require `sudo` unless your user has been added to the `docker` group. To add your user to the `docker` group and avoid using `sudo` with Docker commands, you can run:

```sh
sudo usermod -aG docker $USER
```

After running this command, log out and log back in for the changes to take effect.

## Step 1: Create a Directory for Persistent Storage

To ensure your data persists between sessions, create a directory on your host machine that will be mounted to the Docker container:

### On Linux or macOS:

```sh
mkdir -p ~/linux-practice-data
sudo chown $(id -u):$(id -g) ~/linux-practice-data
```

### On Windows:

1. Open PowerShell or Command Prompt.
2. Create a directory (no need for permission changes):
   ```sh
   mkdir C:\linux-practice-data
   ```

## Step 2: Pull the Docker Image

First, open your terminal and pull the Docker image from Docker Hub:

```sh
docker pull mikersays/linuxgym
```

## Step 3: Run the Docker Container

Run the Docker container with the persistent storage directory mounted. This will allow you to have a consistent workspace that persists between container runs:

### On Linux or macOS:

```sh
docker run -it -v ~/linux-practice-data:/home/user --hostname linuxgym mikersays/linuxgym
```

### On Windows:

```sh
docker run -it -v C:\linux-practice-data:/home/user --hostname linuxgym mikersays/linuxgym
```

Replace `linuxgym` with the hostname you want to set for the container.

### Explanation:

- `docker run` starts a new container.
- `-it` opens an interactive terminal session.
- `-v ~/linux-practice-data:/home/user` (Linux/macOS) or `-v C:\linux-practice-data:/home/user` (Windows) mounts the directory from your host machine to `/home/user` in the container.
- `--hostname linuxgym` sets the container's hostname to `linuxgym`.

## Step 4: Use the Linux Environment

After running the above command, you'll be logged into the container as the `user` user with a bash shell. You can now practice Linux commands and explore the environment.

**Example session:**

```sh
user@linuxgym:~$ ls
user@linuxgym:~$ pwd
/home/user
user@linuxgym:~$ touch myfile.txt
user@linuxgym:~$ ls
myfile.txt
```

Any changes you make in `/home/user` will be saved in your persistent storage directory on your host machine, ensuring they persist across container restarts.

### Username and Password

- **Username:** `user`
- **Password:** `password`

#### Customizing Username and Password

If you want to set your own username and password, you can do so by modifying the Dockerfile or running a script after starting the container. To change the username and password at runtime:

1. Start the container with an interactive terminal:
   ```sh
   docker run -it -v ~/linux-practice-data:/home/user --hostname linuxgym mikersays/linuxgym
   ```

2. Change the username (e.g., to `myuser`):
   ```sh
   sudo usermod -l myuser user
   sudo usermod -d /home/myuser -m myuser
   ```

3. Change the password:
   ```sh
   echo 'myuser:mynewpassword' | sudo chpasswd
   ```

These changes won't break anything in the container and will allow you to customize your environment.

## Step 5: Exit and Restart the Container

To exit the container, simply type `exit` or press `Ctrl+D`. Your data will be saved in the persistent storage directory on your host machine.

To restart the container and continue practicing, run the following command:

### On Linux or macOS:

```sh
docker run -it -v ~/linux-practice-data:/home/user --hostname linuxgym mikersays/linuxgym
```

### On Windows:

```sh
docker run -it -v C:\linux-practice-data:/home/user --hostname linuxgym mikersays/linuxgym
```

## Additional Tips

- **Updating the Image:** If you want to update the Docker image to the latest version, you can pull the latest image again:

  ```sh
  docker pull mikersays/linuxgym
  ```

- **Multiple Sessions:** You can open multiple terminals and start separate containers if you want to run different sessions concurrently. Just ensure they all mount the same persistent storage directory if you want to share data between them.

- **Cleaning Up:** If you ever want to remove all Docker containers and images, you can use the following commands (use with caution):

  ```sh
  docker rm $(docker ps -a -q)  # Remove all containers
  docker rmi $(docker images -q)  # Remove all images
  ```

By following these instructions, you can use the Docker container to practice Linux commands and explore the environment with the confidence that your data will persist between sessions. Enjoy your Linux workouts!

### Note for Linux Users:

If you encounter permission issues with Docker commands, you might need to prepend `sudo` to the commands or add your user to the `docker` group as mentioned in the prerequisites.
