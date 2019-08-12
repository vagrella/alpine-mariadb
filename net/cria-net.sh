#!/bin/bash
. ../conf/config.ini
docker network create --driver bridge $REDE
