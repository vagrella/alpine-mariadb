#!/bin/bash
. ../conf/config.ini

docker stop $CONTAINER_DB
docker rm $CONTAINER_DB
#docker run --name $CONTAINER_DB --network $REDE -e TZ=America/Sao_Paulo -p 3306:3306 -v $DIR_DB_LOCAL:$DIR_DB_SERVER -e MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD -e MYSQL_DATABASE=$MYSQL_DATABASE -d $DOMINIO/$IMAGEM_DB
docker run --name $CONTAINER_DB --network $REDE -e TZ=America/Sao_Paulo -p 3306:3306 -e MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD -e MYSQL_DATABASE=$MYSQL_DATABASE -d $DOMINIO/$IMAGEM_DB

#Se habilitar o docker log aqui, nao iremos ver sera executada os passos de dump do banco
#docker logs $CONTAINER_DB -f
