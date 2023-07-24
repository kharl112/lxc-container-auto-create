#!/bin/bash

apt update
apt install curl -y

echo ===============================
echo ====== SETTING UP NODE ========
echo ===============================

curl -fsSL https://deb.nodesource.com/setup_current.x | sudo bash -

apt install nodejs

node -v
npm -v
