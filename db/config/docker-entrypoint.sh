#!/bin/sh
. /config/config.ini

for i in /scripts/pre-init.d/*sh
do
        if [ -e "${i}" ]; then
                echo "[i] pre-init.d - processing $i"
                . "${i}"
        fi
done

if [ -d "/run/mysqld" ]; then
        echo "[i] mysqld already present, skipping creation"
        chown -R mysql:mysql /run/mysqld
else
        echo "[i] mysqld not found, creating...."
        mkdir -p /run/mysqld
        chown -R mysql:mysql /run/mysqld
fi

chown -R mysql:mysql /mysqltmp
if [ -d /var/lib/mysql/mysql ]; then
        echo "[i] MySQL directory already present, skipping creation"
        chown -R mysql:mysql /var/lib/mysql
else
        echo "[i] MySQL data directory not found, creating initial DBs"
        mysql_install_db --user=mysql --datadir='/var/lib/mysql' > /dev/null
        chown -R mysql:mysql /var/lib/mysql

        if [ "$MYSQL_ROOT_PASSWORD" = "" ]; then
                MYSQL_ROOT_PASSWORD=`teste123`
                echo "[i] MySQL root Password: $MYSQL_ROOT_PASSWORD"
        fi

        MYSQL_DATABASE=${MYSQL_DATABASE:-""}
        MYSQL_USER=${MYSQL_USER:-""}
        MYSQL_PASSWORD=${MYSQL_PASSWORD:-""}

        tfile=`mktemp`
        if [ ! -f "$tfile" ]; then
            return 1
        fi

        cat << EOF > $tfile
USE mysql;
FLUSH PRIVILEGES;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' identified by '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' identified by '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION;
UPDATE user SET password=PASSWORD("$MYSQL_ROOT_PASSWORD") WHERE user='root' AND host='localhost';
EOF

        if [ "$MYSQL_DATABASE" != "" ]; then
            echo "[i] Creating database: $MYSQL_DATABASE"
            echo "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\` CHARACTER SET utf8 COLLATE utf8_general_ci;" >> $tfile

            if [ "$MYSQL_USER" != "" ]; then
                echo "[i] Creating user: $MYSQL_USER with password $MYSQL_PASSWORD"
                echo "GRANT ALL ON \`$MYSQL_DATABASE\`.* to '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" >> $tfile
            fi
        fi

        /usr/bin/mysqld --user=mysql --bootstrap --verbose=0 < $tfile
        rm -f $tfile
fi

# execute any pre-exec scripts
for i in /scripts/pre-exec.d/*sh
do
        if [ -e "${i}" ]; then
                echo "[i] pre-exec.d - processing $i"
                . ${i}
        fi
done
exec /usr/bin/mysqld --user=mysql --console

