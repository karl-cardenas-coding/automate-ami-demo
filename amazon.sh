#!/bin/bash
sudo yum -y update
sudo amazon-linux-extras install docker
sudo service docker start
sudo usermod -a -G docker ec2-user
sudo docker info
echo "This is where you would add your customization!"
