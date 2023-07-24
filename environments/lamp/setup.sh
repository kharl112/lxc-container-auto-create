#!/bin/bash

apt update
apt upgrade

echo ===============================
echo ====== SETTING UP LAMP ========
echo ===============================

#NOTE: make sure dump all of your data before install mariadb again
apt install apache2 mariadb-server mariadb-client

#install deps
apt install php libapache2-mod-php php-mysql php-fpm php-cli php-xml php-xmlrpc curl php-curl lynx mc

# setup mysql 
mysql_secure_installation

#configure apache2
a2enmod php || true

#create a info page for php 
echo "<?php phpinfo(); ?>" > /var/www/html/pinfo.php

#fix permissions
chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html
