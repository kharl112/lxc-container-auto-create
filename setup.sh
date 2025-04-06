#!/bin/bash
apt update
apt install git curl mc tmux -y

git clone https://github.com/kharl112/nvim-plugins-installation.git /apps/nvim-plugins-installation

cd /apps/nvim-plugins-installation
chmod +x install.sh
bash install.sh

#add user and pass
read -p "user for this container:" NEW_USER
useradd -m -d /home/$NEW_USER $NEW_USER
passwd $NEW_USER

usermod -aG root $NEW_USER
usermod -aG sudo $NEW_USER
