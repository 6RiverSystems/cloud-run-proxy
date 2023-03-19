#!/bin/bash

# nginx config variable injection
# envsubst < nginx-basic-auth.conf > /etc/nginx/conf.d/default.conf

# htpasswd for basic authentication
htpasswd -c -b /etc/nginx/.htpasswd "$BASIC_USERNAME" "$BASIC_PASSWORD"

# sudo -u www-data /app/cloud-run-proxy "$@" &
nginx -g "daemon off;" 
