#!/bin/bash
apt update
apt install git openssh-server curl -y

#add user and pass
read -p "user for this container:" NEW_USER
useradd -m $NEW_USER
passwd $NEW_USER

