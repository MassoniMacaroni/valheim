#!/bin/bash

# Update the package list and upgrade the installed packages
sudo yum update -y

# Install Docker
sudo yum install -y docker
sudo service docker start

sudo usermod -a -G docker ec2-user

sudo mkdir -p /mnt/ebs_volume
sudo mount /dev/xvdf /mnt/ebs_volume

#sudo mkdir -p /mnt/ebs_volume/valheim-server/config/worlds_local /mnt/ebs_volume/valheim-server/data
# copy existing world
cd /mnt/ebs_volume/valheim-server
sudo curl -o /mnt/ebs_volume/valheim-server/docker-compose.yaml https://raw.githubusercontent.com/MassoniMacaroni/valheim/main/docker-compose.yaml
sudo docker-compose up