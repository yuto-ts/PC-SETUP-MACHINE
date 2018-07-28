#!/bin/bash

################################################################################

# Disable sudo password timeout so longer scripts can run until completion.
if ! sudo grep -q "Defaults.*env_reset.*timestamp_timeout=.*" /etc/sudoers; then
  sudo sed -i "s/\(Defaults.*env_reset\)/\1,timestamp_timeout=-1/g" /etc/sudoers
fi

################################################################################
# git 
sudo apt-get install -y git

# Initialize and download Git submodules.
# https://git-scm.com/book/en/v2/Git-Tools-Submodules
git submodule init
git submodule update

################################################################################

# Install Docker CE.
# https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/

# Remove older versions of Docker ('docker', 'docker-engine') if any.
sudo apt-get remove docker docker-engine docker.io

# Install required packages.
sudo apt-get update
sudo apt-get install -y \
  apt-transport-https \
  ca-certificates \
  curl \
  software-properties-common

# Add official Docker GPG key and display it.
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88

# Setup the Docker CE repository (stable).
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable"

# Update the package index.
sudo apt-get update

# Install the latest version of Docker CE.
# Any existing installation will be replaced.
sudo apt-get install -y docker-ce

# Test installation.
sudo docker version
sudo docker run hello-world

################################################################################

# Add current user to 'docker' group to run Docker without sudo.
# Logging out and back in is required for the group change to take effect.
sudo usermod -a -G docker ${USER}

################################################################################

# Install Docker Compose.
# https://docs.docker.com/compose/install/#install-compose
# https://github.com/docker/compose/releases

# Install Docker Compose from GitHub.
sudo curl -L https://github.com/docker/compose/releases/download/1.20.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Test installation.
sudo docker-compose version

################################################################################

# Setup the Bash shell environment with .bashrc.

# Set default Docker runtime to use in docker-compose.yml.
if ! grep -q "export DOCKER_RUNTIME" ~/.bashrc; then
  echo "\n# Set default Docker runtime to use in docker-compose.yml." >> ~/.bashrc
fi

################################################################################

# install applications 
sudo apt-get install -y \
    terminator
    vlc \
    emacs-nox \
    gnome-tweaks \
    