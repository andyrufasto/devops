#/bin/bash -x

#Set environment variables
MYSQL_HOST=`sudo docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' open-politica-backend_votu_backend_mariadb_1`
MYSQL_USER=root
LOGIN=local

DATABASE_NAME=op
MYSQL_PWD=op123%
DATABASE_BACKUP_NAME=database.back.sql

#Create a copy for a modified database
#Column-statistics is disabled, otherwise will throw an error
mysqldump --skip-opt --column-statistics=0 --user=$MYSQL_USER --password=$MYSQL_PWD --host=$MYSQL_HOST --databases $DATABASE_NAME > $DATABASE_BACKUP_NAME
