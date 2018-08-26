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

# install gitkraken.deb
wget https://release.gitkraken.com/linux/gitkraken-amd64.deb
dpkg -i gitkraken-amd64.deb

rm -rf ./gitkraken-amd64.deb
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
sudo apt install steam

## install applications 
sudo apt-get update
sudo apt-get install -y \
    terminator
    vlc \
    emacs-nox \
    gnome-tweaks \

sudo apt update
sudo apt install -y \
    inkscape \
    corebird \ # twitter cliant
    evolution \ # mail and schduler
    brasero \  # write tool CD/DVD 
    rhythmbox-plugin-cdrecorder \ # copy music CD 
    easytag \ # easy edit music tags 
    clamtk \ # security software
    gparted gpart \ # tool of manege partition 
    install wine64 \ # wine

# using format type exfat]
sudo apt-get install exfat-fuse exfat-utils



    