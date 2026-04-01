#!/bin/bash

apt update
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo bash -

apt-get install nodejs npm -y

node -v
npm -v
