#!/bin/bash

# update and install lxc (if doesn't exists)
apt update
apt install -y lxc

echo starting time: `date`

#generate container name 
ADJECTIVE=`shuf adjectives.txt | head -n 1`
ANIMAL=`shuf animals.txt | head -n 1`
CONTAINER_NAME="${1:-$ADJECTIVE-$ANIMAL}"

echo CONTAINER-NAME: $CONTAINER_NAME

#set -ex
PROJECT_DIR=`pwd | grep -o "\w*$"`
CONTAINER_HOME=/home/apps
CONTAINER_DIR=/var/lib/lxc/$CONTAINER_NAME/rootfs$CONTAINER_HOME

lxc-stop $CONTAINER_NAME || true
lxc-destroy $CONTAINER_NAME || true

lxc-create -t download -n $CONTAINER_NAME -- -d ubuntu -r lunar -a amd64
lxc-start $CONTAINER_NAME

mkdir -p $CONTAINER_DIR 
cp $PWD $CONTAINER_DIR -R  

lxc-attach -n $CONTAINER_NAME -- $CONTAINER_HOME/$PROJECT_DIR/setup.sh
echo end time: `date`
