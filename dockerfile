FROM  ubuntu:18.04 AS build

WORKDIR /app
RUN apt-get install wget zip tar -y

RUN wget https://download.dokuwiki.org/src/dokuwiki/dokuwiki-stable.tgz
RUN tar xzf dokuwiki-stable.tgz --strip-components=1
RUN rm dokuwiki-stable.tgz

FROM php:8-apache-bullseye

COPY --from=build /app ./var/www/html

RUN chown -R www-data:www-data /var/www/
