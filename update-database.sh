#!/bin/bash

#Setting variables

[ -z "$1" ] && echo "No services folder directory supplied replaced by ""$HOME""/services" && SERVICES_DIRECTORY="${HOME}"/services || SERVICES_DIRECTORY="$1"

BACKEND_DIRECTORY=${SERVICES_DIRECTORY}/open-politica-backend
cd "${BACKEND_DIRECTORY}"/src/dbtools

#Configure the mysql_client
LOGIN=local
HOST=$(sudo docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' open-politica-backend_votu_backend_mariadb_1)

USER=root
PASS=op123%

# Prevent interative dialog for previous configurations
rm -rf ~/.mylogin.cnf
# Used to pass the password in simulating interactive mode
# Based on https://stackoverflow.com/a/50732126/5107192
unbuffer expect -c "
spawn mysql_config_editor set --login-path=$LOGIN --host=$HOST --user=$USER --password
expect -nocase \"Enter password:\" {send \"$PASS\r\"; interact}
"
#Prevent to reconfigure mysql_config_editor 
sed -i "s/mysql_config_editor/#mysql_config_editor/g" reset_mysql.sh
#Run the script to load the database
./reset_mysql.sh
