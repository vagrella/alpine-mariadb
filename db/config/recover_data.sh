#!/bin/sh
. /config/config.ini

cd /config/
mysql -u $MYSQL_ROOT_USER -p$MYSQL_ROOT_PASSWORD < db.sql
chmod -R g+w $DIR_DB_SERVER
