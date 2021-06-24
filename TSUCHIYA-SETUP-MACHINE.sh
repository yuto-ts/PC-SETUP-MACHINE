#!/bin/bash

################################################################################

# Disable sudo password timeout so longer scripts can run until completion.
if ! sudo grep -q "Defaults.*env_reset.*timestamp_timeout=.*" /etc/sudoers; then
  sudo sed -i "s/\(Defaults.*env_reset\)/\1,timestamp_timeout=-1/g" /etc/sudoers
fi

############################### Install git. ###############################

# Install git #
sudo apt-get install -y git

# Initialize and download Git submodules.
# https://git-scm.com/book/en/v2/Git-Tools-Submodules
git submodule init
git submodule update

############################### Install Docker CE. ###############################

# refer to https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/

# Remove older versions of Docker ('docker', 'docker-engine') if any.
sudo apt-get remove docker docker-engine docker.io containerd runc

# Install required packages.
sudo apt-get update
sudo apt-get install -y \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg-agent \
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
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Add current user to 'docker' group to run Docker without sudo.
# Logging out and back in is required for the group change to take effect.
sudo usermod -aG docker $USER
sudo mkdir /sys/fs/cgroup/systemd
sudo mount -t cgroup -o none,name=systemd cgroup /sys/fs/cgroup/systemd

# Test installation.
sudo docker version
sudo docker run hello-world

################################################################################

# Install Docker Compose.
# https://docs.docker.com/compose/install/s
# https://github.com/docker/compose/releases

# Install Docker Compose from GitHub.
sudo curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
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

## install google chrome in command line 
sudo gdeit /etc/apt/sources.list
deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main # Press CTRL+S to save the file and Close it. Now Enter the Following command in Terminal and Press Enter
wget https://dl.google.com/linux/linux_signing_key.pub
sudo apt-key add linux_signing_key.pub
# Now update the package list and install the stable version of Google Chrome.
sudo apt updates
sudo apt install google-chrome-stable

## install virtual box in command line
# First, we need to import the GPG keys of the Oracle VirtualBox repository to our system using the following commands:

wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
# Both commands should output OK which means that the keys are successfully imported and packages from this repository will be considered trusted.

# Next, add the VirtualBox repository with the add-apt-repository command as shown bellow:
sudo add-apt-repository "deb http://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib"

sudo apt update
sudo apt virtualbox-5.2

## install vscode in command line 
url https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

sudo apt-get update
sudo apt-get install code # or code-insiders

## install steam in command line 
sudo add-apt-repository multiverse
sudo apt-get update
sudo apt-get install steam

## install applications 
sudo apt-get update
sudo apt-get install -y \
    terminator \
    vlc \
    emacs-nox \
    gnome-tweaks 

sudo apt-get update
sudo apt-get install -y \
    inkscape \
    corebird \
    evolution \
    brasero \
    rhythmbox-plugin-cdrecorder \
    easytag \
    clamtk \
    gparted gpart \
    install wine64  

# using format type exfat]
sudo apt-get install exfat-fuse exfat-utils
##################################################################################

# create Symbolic link
ln -s /mnt/c/Users/yuto-tsu/prog ~

##################################################################################

# install python on pyenv
# https://qiita.com/hasepyon/items/45ea509c64a6469ca5b6
sudo apt-get update

sudo apt-get install -y \
    build-essential \
    libffi-dev \
    libssl-dev \
    zlib1g-dev \
    liblzma-dev \
    libbz2-dev libreadline-dev libsqlite3-dev

git clone https://github.com/pyenv/pyenv.git ~/.pyenv
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init -)"' >> ~/.bashrc
source ~/.bashrc
# check pyenv installaion
pyenv --version
# pyenv install --list

# install pip
sudo apt-get update
sudo apt-get install -y python3-pip
sudo pip install --upgrade pip
sudo pip3 install --upgrade pip


##################################################################################

# install golaung
# https://qiita.com/notchi/items/5f76b2f77cff39eca4d8
# https://golang.org/dl/
wget https://golang.org/dl/go1.15.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.15.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
# check go installaion
go version


##################################################################################

# install fish
sudo apt-add-repository ppa:fish-shell/release-3
sudo apt-get -y update
sudo apt-get -y install fish

# install fisher and custimeze terminal
curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisher
fisher add oh-my-fish/theme-bobthefish             # install fonts
git clone https://github.com/powerline/fonts.git

fisher add 0rax/fish-bd

##################################################################################

## nvidia-docker on WSL2
# https://docs.nvidia.com/cuda/wsl-user-guide/index.html#installing-wsl2
# requrement linux kernel 4.19.121+ is installed and Ensure that you install Build version 20145 or higher.
# You can check your build version number by running winver via the Windows Run command.
# check the version number by running the following command in PowerShell:
# $ wsl cat /proc/version

# Setting up CUDA Toolkit

# It is recommended to use the Linux package manager to install the CUDA for the Linux distributions supported under WSL 2. Follow these instructions to install the CUDA Toolkit.
# First, set up the CUDA network repository. The instructions shown here are for Ubuntu 18.04. See the CUDA Linux Installation Guide for more information on other distributions.
sudo apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub
sudo sh -c 'echo "deb http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64 /" > /etc/apt/sources.list.d/cuda.list'

# Now install CUDA. Note that for WSL 2, you should use the cuda-toolkit-<version> meta-package to avoid installing the NVIDIA driver that is typically bundled with the toolkit. You can also install other components of the toolkit by choosing the right meta-package.(https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html#package-manager-metas)
# Do not choose the cuda, cuda-11-0, or cuda-drivers meta-packages under WSL 2 since these packages will result in an attempt to install the Linux NVIDIA driver under WSL 2.
sudo apt-get update
sudo apt-get install -y cuda-toolkit-11-0

# Install NVIDIA Container Toolkit
# Now install the NVIDIA Container Toolkit (previously known as nvidia-docker2). WSL 2 support is available starting with nvidia-docker2 v2.3 and the underlying runtime library (libnvidia-container >= 1.2.0-rc.1).
# For brevity, the installation instructions provided here are for Ubuntu 18.04 LTS.
# Setup the stable and experimental repositories and the GPG key. The changes to the runtime to support WSL 2 are available in the experimental repository.
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
curl -s -L https://nvidia.github.io/libnvidia-container/experimental/$distribution/libnvidia-container-experimental.list | sudo tee /etc/apt/sources.list.d/libnvidia-container-experimental.lis

# Install the NVIDIA runtime packages (and their dependencies) after updating the package listing.
sudo apt-get update
sudo apt-get install -y nvidia-docker2

# Open a separate WSL 2 window and start the Docker daemon again using the following commands to complete the installation.
sudo service docker stop
sudo service docker start

echo "alias docker_stop='sudo service docker stop'" >> ~/.bashrc
echo "alias docker_start='sudo service docker start'" >> ~/.bashrc
source ~/.bashrc

##### Running CUDA Containers
# Simple CUDA Containers
# docker run --gpus all nvcr.io/nvidia/k8s/cuda-sample:nbody nbody -gpu -benchmark
# docker run -it --gpus all -p 8888:8888 tensorflow/tensorflow:latest-gpu-py3-jupyter

##################################################################################

# install ffmpeg
sudo apt install ffmpeg
