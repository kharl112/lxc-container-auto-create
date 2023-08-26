#!/bin/bash
apt update
apt install git openssh-server curl -y

#add user and pass
read -p "user for this container:" NEW_USER
useradd -m -d /home/$NEW_USER $NEW_USER
passwd $NEW_USER

usermod -aG root $NEW_USER
usermod -aG sudo $NEW_USER
