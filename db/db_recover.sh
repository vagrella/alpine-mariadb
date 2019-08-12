#!/bin/bash
. ../conf/config.ini

docker exec -i $CONTAINER_DB /config/recover_data.sh

