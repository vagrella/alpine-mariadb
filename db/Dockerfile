FROM alpine:3.8
LABEL maintainer "Vornei Augusto Grella <vagrella@unicamp.br>"

RUN apk --update upgrade

#Quando Necessario reiniciar servicos
#RUN apk add openrc --no-cache

RUN apk add mariadb mariadb-client pwgen tzdata && \
    rm -f /var/cache/apk/*

#Configuracao MariaDB
#COPY config/my.cnf /etc/mysql/my.cnf

ADD config/ /config/


EXPOSE 3306

ENTRYPOINT ["/config/docker-entrypoint.sh"]
