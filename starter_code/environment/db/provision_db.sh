#!/bin/bash

# Update and upgrade any packages
sudo apt-get update
sudo apt-get upgrade

# import a public GPG Key for MongoDB specifiying the version
wget -qO - https://www.mongodb.org/static/pgp/server-3.2.asc | sudo apt-key add -

# Create 3.2 list file for Ubuntu 18.04 (Bionic. HOWEVER: )
echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list

sudo apt-get update

sudo apt-get install -y mongodb-org=3.2.20 mongodb-org-server=3.2.20 mongodb-org-shell=3.2.20 mongodb-org-mongos=3.2.20 mongodb-org-tools=3.2.20

echo "mongodb-org hold" | sudo dpkg --set-selections
echo "mongodb-org-server hold" | sudo dpkg --set-selections
echo "mongodb-org-shell hold" | sudo dpkg --set-selections
echo "mongodb-org-mongos hold" | sudo dpkg --set-selections
echo "mongodb-org-tools hold" | sudo dpkg --set-selections

sudo sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf

sudo systemctl start mongod
sudo systemctl enable mongod