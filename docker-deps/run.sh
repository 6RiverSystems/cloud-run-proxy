#!/bin/bash

# nginx config variable injection
# envsubst < nginx-basic-auth.conf > /etc/nginx/conf.d/default.conf

# htpasswd for basic authentication
htpasswd -c -b /etc/nginx/.htpasswd "$BASIC_USERNAME" "$BASIC_PASSWORD"

sleep 10 #Wait for metatdata server to be avaliable 
echo "Running: /app/cloud-run-proxy $@"
/app/cloud-run-proxy "$@" &
nginx -g "daemon off;" 
