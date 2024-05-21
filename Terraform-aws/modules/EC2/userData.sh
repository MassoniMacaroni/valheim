#!/bin/bash

# Update the package list and upgrade the installed packages
sudo yum update -y

# Install Docker
sudo yum install -y docker
sudo mkdir -p /usr/local/lib/docker/cli-plugins/
sudo curl -SL https://github.com/docker/compose/releases/latest/download/docker-compose-linux-x86_64 -o /usr/local/lib/docker/cli-plugins/docker-compose
sudo chmod +x /usr/local/lib/docker/cli-plugins/docker-compose
sudo service docker start

sudo usermod -a -G docker ec2-user

UUID_TO_CHECK="0e84958a-2d10-41db-9d61-7f73e91f7de7"
# Get the filesystem type of the device with the specified UUID
FS_TYPE=$(blkid -o value -s TYPE $(blkid -U $UUID_TO_CHECK))

sudo mkdir -p /mnt/ebs_volume

if [ "$FS_TYPE" == "ext4" ]; then
    sudo mount UUID=0e84958a-2d10-41db-9d61-7f73e91f7de7 /mnt/ebs_volume
else
    # Get the device name from the UUID
    DEVICE=$(blkid -U $UUID_TO_CHECK)
    # Reformat the device to ext4
    sudo mkfs.ext4 $DEVICE
    sudo mount UUID=0e84958a-2d10-41db-9d61-7f73e91f7de7 /mnt/ebs_volume
fi

DIR1="/mnt/ebs_volume/valheim-server/config/worlds_local"
DIR2="/mnt/ebs_volume/valheim-server/data"

# Check if DIR1 exists
if [ ! -d "$DIR1" ]; then
    sudo mkdir -p "$DIR1"
fi

# Check if DIR2 exists
if [ ! -d "$DIR2" ]; then
    sudo mkdir -p "$DIR2"
fi

# copy existing world
cd /mnt/ebs_volume/valheim-server
ENVFILE="/mnt/ebs_volume/valheim-server/valheim.env"

#!/bin/bash

ENVFILE="/mnt/ebs_volume/valheim-server/valheim.env"

if [ ! -f "$ENVFILE" ]; then
    # File does not exist
    sudo bash -c "cat > '$ENVFILE' <<EOF
SERVER_NAME=Jonos Server
WORLD_NAME=Dedicated
SERVER_PASS=JonoSecret
SERVER_PUBLIC=true
EOF"
fi

sudo curl -o /mnt/ebs_volume/valheim-server/docker-compose.yaml https://raw.githubusercontent.com/MassoniMacaroni/valheim/main/docker-compose.yaml
sudo docker compose up -d