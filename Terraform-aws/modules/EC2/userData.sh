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
sudo docker run -d \
    --name valheim-server \
    --cap-add=sys_nice \
    --stop-timeout 120 \
    -p 2456-2457:2456-2457/udp \
    -v /mnt/ebs_volume/valheim-server/config:/config \
    -v /mnt/ebs_volume/valheim-server/data:/opt/valheim \
    -e SERVER_NAME="Sancal" \
    -e WORLD_NAME="Sancal" \
    -e SERVER_PUBLIC="true" \
    -e SERVER_PASS="secretPassword" \
    -e STATUS_HTTP="true" \
    ghcr.io/lloesche/valheim-server

