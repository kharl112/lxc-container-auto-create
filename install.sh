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
PROJECT_DIR=`pwd | grep -o "\/[A-Z|a-z|0-9|\-]*" | tail -n 1`
CONTAINER_HOME=/home/apps
CONTAINER_DIR=/var/lib/lxc/$CONTAINER_NAME/rootfs$CONTAINER_HOME

lxc-stop $CONTAINER_NAME || true
lxc-destroy $CONTAINER_NAME || true

lxc-create -t download -n $CONTAINER_NAME -- -d ubuntu -r jammy -a amd64
lxc-start $CONTAINER_NAME

mkdir -p $CONTAINER_DIR 
cp $PWD $CONTAINER_DIR -R  

#execute setup
lxc-attach -n $CONTAINER_NAME -- $CONTAINER_HOME/$PROJECT_DIR/setup.sh

if [ -z "$2" ]
  then
    echo "No directory supplied for project or executable"
  else
    echo "executing setup.sh from your supplied directory"
    PR=`echo $2 | grep -o "\/[A-Z|a-z|0-9|\-]*" | tail -n 1`
    cp $2 $CONTAINER_DIR -R
    lxc-attach -n $CONTAINER_NAME -- $CONTAINER_HOME/$PR/setup.sh
fi

echo end time: `date`
