# challenge

Requirements: Ubuntu 16.04 LTS

Steps

### Create APP Directory ###

mkdir /app

### Download script files ###

git clone https://github.com/chmodrs/challenge.git

### Move to challenge directory and exec 01-prepare-machine.sh ###
### "01-prepare-machine.sh is a script that installs all S.O dependencies and compile NodeJS" ###
### This script intall PM2 for secure deploy and rollback node apps ###

mv challenge
./01-prepare-machine.sh

### Exec 02-nginx-conf.sh for install nginx and configure to reverse proxy ###
### After nginx install, the service listen 3000 port for node apps ###
### run pm2 deploy in app directory for run node application ###

pm2 deploy production
