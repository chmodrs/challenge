#!/bin/bash

url=`curl ipinfo.io/ip`
status_code=$(curl -o /dev/null --silent --head --write-out '%{http_code}\n' $url)

if [ $status_code -ne "200" ]
then
	echo "stopping pm2 application"
        pm2 stop ecosystem.config.js
	echo "pm2 deploy application"
	pm2 deploy ecosystem.config.js production
	echo "reload nginx service"
	service nginx reload
        
fi
