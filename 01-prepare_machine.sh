#!/bin/bash

### UPDATE UBUNTU REPOSITORY ###

apt-get update -y

### UPGRADE S.O PACKAGES ###

apt-get upgrade -y

### INSTALL BUILD ESSENTIALS FOR COMPILE NODE ###

apt-get install -y build-essential

### DOWNLOAD AND INSTALL LATEST NODEJS VERSION ###

cd /usr/src
wget https://nodejs.org/dist/v8.9.1/node-v8.9.1.tar.gz
tar xvf node-v8.9.1.tar.gz
cd node-v8.9.1
./configure && make && make install
cd ~

### CREATE SIMLINK ###
ln -s /usr/local/bin/npm /usr/bin/npm

### CREATE DEPLOY USER ###

useradd -s /bin/bash -m -d /home/deploy -c "deploy user" deploy
echo deploy:challenge2017 | chpasswd
usermod -aG sudo deploy 

### INSTALL PM2 DOR SECURE DEPLOY ###

npm install pm2 -g 
