#!/bin/bash

# Update the package list and upgrade the installed packages
sudo apt-get update -y

sudo apt-get install -y ec2-instance-connect

# Install Docker
sudo apt-get install -y docker.io
