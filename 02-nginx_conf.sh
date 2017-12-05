#!/bin/bash

cat > /etc/nginx/sites-available/default <<EOL
server {
 server_name your.domain.com;
  listen 80;

  location / {
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header Host $http_host;
    proxy_set_header X-NginX-Proxy true;
    proxy_pass http://127.0.0.1:3000;
    proxy_redirect off;
  }
}
EOL
nginx  -s reload