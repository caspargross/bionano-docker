# vim:set ft=dockerfile:
FROM alpine:3.6

######################
# INSTALL POSTGRESQL #
######################

RUN apk add --no-cache postgresql bash su-exec

ENV PGUSER postgres
ENV PGDATABASE postgres
ENV PGPORT 5432
ENV PGDATA /var/lib/postgresql/data

RUN mkdir -p /run/postgresql && chown -R postgres:postgres /run/postgresql && chmod 2777 /run/postgresql
RUN mkdir -p "$PGDATA" && chown -R postgres:postgres "$PGDATA" && chmod 777 "$PGDATA"

RUN su-exec postgres pg_ctl init   
RUN sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /var/lib/postgresql/data/postgresql.conf
RUN su-exec postgres postgres && su-exec postgres psql -c "alter user postgres with password '1rysview';"
VOLUME /var/lib/postgresql/data

######################
# INSTALL NODE.JS    #
######################

RUN apk add --no-cache nodejs

######################
# INSTALL PERL       #
######################

RUN apk add --no-cache perl

######################
# INSTALL JAVA       #
######################

RUN apk add --no-cache openjdk8

EXPOSE 5432
