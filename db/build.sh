#!/bin/bash
. ../conf/config.ini

echo "Criando Imagem $DOMINIO/$IMAGEM_DB para o Container $CONTAINER_DB"

docker stop $CONTAINER_DB
docker system prune --all
docker build --tag "$DOMINIO/$IMAGEM_DB" -f Dockerfile .
