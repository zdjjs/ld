#!/bin/sh

echo 127.0.0.1 `sed -E -n 's/.*server_name[ ]*([^;]+);.*/\1/p' /etc/nginx/nginx.conf | tr '\n' ' '`
