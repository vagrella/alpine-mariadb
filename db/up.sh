#!/bin/bash
. ../conf/config.ini

cp ../conf/config.ini config/

echo "Limpando todos os arquivos antigos do Banco de Dados em $DIR_DB_LOCAL"
rm -rf $DIR_DB_LOCAL
mkdir $DIR_DB_LOCAL
chmod -R g+w $DIR_DB_LOCAL

./build.sh

echo "Criando Rede $REDE"
../net/cria-net.sh

./run.sh


#Tem que verificar se o banco esta ativo antes de fazer o dump
CONTADOR=0
until netstat -anp | grep -w 3306
do
    echo "Banco nao esta ativo ainda. ["$CONTADOR"]"
    let CONTADOR=CONTADOR+1; 
    sleep 5
done

docker ps

echo "Recuperando a estrutura e dados Banco de Dados em $MYSQL_DATABASE. Aguardando $TEMPO_DB seg. antes da inicialização."
sleep $TEMPO_DB
./db_recover.sh

#Eh realizado aqui o log e nao no run, senao nao serah executado o script de dump
#docker logs $CONTAINER_DB -f
./exec.sh

chown -R root:docker $DIR_DB_LOCAL
