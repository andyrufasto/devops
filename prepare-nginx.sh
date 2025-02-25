#!/bin/bash

#Setting variables

[ -z "$1" ] && echo "No root folder directory supplied replaced by $HOME" && ROOT_DIRECTORY="${HOME}" || ROOT_DIRECTORY="$1"

[ -z "$1" ] && echo "No services folder name supplied replaced by services" &&  SERVICES_DIRECTORY_NAME=services || SERVICES_DIRECTORY_NAME="$2"


cd "${ROOT_DIRECTORY}"
git clone https://github.com/kassambara/nginx-multiple-https-websites-on-one-server.git

mv nginx-multiple-https-websites-on-one-server "${SERVICES_DIRECTORY_NAME}"
cd "${SERVICES_DIRECTORY_NAME}"
# Deleting unsed directories
rm -rf .git
rm -rf your-website-one.com
rm -rf your-website-two.com

#As recommended by the author of repository, download last version of nginx template
curl -s https://raw.githubusercontent.com/jwilder/nginx-proxy/master/nginx.tmpl> "${ROOT_DIRECTORY}"/"${SERVICES_DIRECTORY_NAME}"/nginx-proxy/nginx.tmpl

cd nginx-proxy
sudo docker network create nginx-proxy
sudo docker-compose up -d
