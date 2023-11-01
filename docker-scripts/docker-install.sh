#!/bin/bash

read -p "Do you want to upgrade Docker to the latest version? (y/n) " upgrade_docker

if [ "$upgrade_docker" == "y" ]; then
    
    echo "Upgrading Docker to version ..."

    sudo apt-get update

    sudo apt-get install \
        ca-certificates \
        curl \
        gnupg \
        lsb-release

    sudo mkdir -m 0755 -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    sudo apt-get update

    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
  

    echo "Docker  has been installed."


    read -p "Do you want to give the current user Docker permissions? (y/n) " docker_permissions

    if [ "$docker_permissions" == "y" ]; then
        sudo usermod -aG docker $USER
        newgrp docker
        echo "Docker permissions have been granted to the current user"
    fi

    echo "Done."
fi
