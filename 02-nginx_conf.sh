#!/bin/bash

apt-get install -y nginx

cat > /etc/nginx/sites-available/default <<EOL
server {
 server_name your.domain.com;
  listen 80;

  location / {
    proxy_pass http://127.0.0.1:3000;
    proxy_redirect off;
  }
}
EOL
nginx  -s reload
