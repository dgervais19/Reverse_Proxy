#!/bin/bash

# Update the sources list
sudo apt-get update -y

# upgrade any packages available
sudo apt-get upgrade -y

# assign the DB_HOST environment to the correct ip address and put it in the .bashrc file
echo "export DB_HOST='192.168.10.150'" >> ~/.bashrc
source ~/.bashrc


# install git
sudo apt-get install git -y

# install nodejs
sudo apt-get install python-software-properties -y
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt-get install nodejs -y

# install pm2
sudo npm install pm2 -g

sudo apt-get install nginx -y

# Unlink default configuration file
sudo unlink /etc/nginx/sites-enabled/default
sudo rm /etc/nginx/sites-available/default 

# Create a new configuration file
# cd /etc/nginx/sites-available
# sudo touch reverse_proxy.conf


# source /etc/nginx/sites-available/reverse_proxy.config
sudo cp /home/ubuntu/nginx_config/reverse_proxy.conf /etc/nginx/sites-available/reverse_proxy.conf

sudo ln -s /etc/nginx/sites-available/reverse_proxy.conf /etc/nginx/sites-enabled/reverse_proxy.conf



# finally, restart the nginx service so the new config takes hold
sudo systemctl restart nginx.service

cd /home/ubuntu/app

sudo npm install

pm2 start app.js