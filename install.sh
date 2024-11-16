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

set -ex
PROJECT_DIR=`pwd | grep -o "\/[A-Z|a-z|0-9|\-]*" | tail -n 1`
CONTAINER_HOME=/apps
CONTAINER_DIR=/var/lib/lxc/$CONTAINER_NAME/rootfs$CONTAINER_HOME

lxc-stop $CONTAINER_NAME || true
lxc-destroy $CONTAINER_NAME || true

lxc-create -t download -n $CONTAINER_NAME -- -d ubuntu -r noble -a amd64
echo "lxc.apparmor.profile=unconfined" >> /var/lib/lxc/$CONTAINER_NAME/config
echo "lxc.start.auto = 1" >> /var/lib/lxc/$CONTAINER_NAME/config
lxc-start $CONTAINER_NAME

mkdir -p $CONTAINER_DIR 
cp $PWD $CONTAINER_DIR -R  

#execute setup
lxc-attach -n $CONTAINER_NAME -- $CONTAINER_HOME/$PROJECT_DIR/setup.sh

EDIR=environments
OPTIONS=(`find $PWD/$EDIR/ -type d -exec basename {} \; | grep -v $EDIR` 'NONE')
echo SELECT TECH STACK:
select opt in "${OPTIONS[@]}"
do
  if [[ "$opt" == "NONE" ]]; then
    echo No techstack selected
    break
  else
    echo selected: $opt
    lxc-attach -n $CONTAINER_NAME -- $CONTAINER_HOME/$PROJECT_DIR/$EDIR/$opt/setup.sh
    break
  fi
done

echo end time: `date`
