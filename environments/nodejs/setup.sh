#!/bin/bash

apt update
apt-get install -y ca-certificates curl gnupg

echo ===============================
echo ====== SETTING UP NODE ========
echo ===============================

mkdir -p /etc/apt/keyrings
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg

NODE_MAJOR=16
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list


apt-get update
apt-get install nodejs npm -y

node -v
npm -v
