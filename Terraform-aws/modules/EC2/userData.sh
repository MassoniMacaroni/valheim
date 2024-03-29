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
docker run -d \
    --name valheim-server \
    --cap-add=sys_nice \
    --stop-timeout 120 \
    -p 2456-2457:2456-2457/udp \
    -v /mnt/ebs_volume/valheim-server/config:/config \
    -v /mnt/ebs_volume/valheim-server/data:/opt/valheim \
    -e SERVER_NAME="My Server" \
    -e WORLD_NAME="Neotopia" \
    -e SERVER_PASS="secret" \
    -e STATUS_HTTP="true" \
    ghcr.io/lloesche/valheim-server

