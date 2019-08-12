#!/bin/sh
. /config/config.ini

docker stop dac-db
service mariadb start
mysqldump --force --opt -u $MYSQL_ROOT_USER --password=$MYSQL_ROOT_PASSWORD --all-databases > db.sql
service mariadb stop
docker start dac-db
