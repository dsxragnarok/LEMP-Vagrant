#!/bin/bash

echo "Provisioning Virtual Machine"

echo "Updating Ubuntu"
sudo apt-get update -y

echo "Installing Nginx"
sudo apt-get install nginx -y

echo "Updating PHP repository"
sudo apt-get install python-software-properties build-essential -y
sudo add-apt-repository ppa:ondrej/php5 -y
sudo apt-get update -y

echo "Installing PHP"
sudo apt-get install php5-common php5-dev php5-cli php5-fpm -y

echo "Installing PHP Extensions"
sudo apt-get install curl php5-curl php5-gd php5-mcrypt php5-mysql -y

echo "Preparing MySQL"
sudo apt-get install debconf-utils -y
debconf-set-selections <<< "mysql-server mysql-server/root_password password 1234"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password 1234"

echo "Installing MySQL"
sudo apt-get install mysql-server -y

echo "Configuring Nginx"
sudo cp /var/www/provision/config/nginx_vhost /etc/nginx/sites-available/vhost
sudo ln -s /etc/nginx/sites-available/vhost /etc/nginx/sites-enabled/

sudo rm -rf /etc/nginx/sites-available/default

# Restart Nginx
sudo service nginx restart

echo "Finished provisioning."
