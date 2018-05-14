# A basic apache server. To use either add or bind mount content under /var/www
FROM ubuntu:16.04

RUN useradd -ms /bin/bash fmpub

RUN apt-get update && apt-get install -y apache2 && apt-get clean && rm -rf /var/lib/apt/lists/*

ENV APACHE_RUN_USER root
ENV APACHE_RUN_GROUP root
ENV APACHE_LOG_DIR /var/log/apache2

COPY files/platform.oms.test.conf /etc/apache2/sites-available/platform.oms.test.conf
COPY files/test.test.conf /etc/apache2/sites-available/test.test.conf
COPY files/index.html /home/fmpub/test/index.html

RUN a2enmod rewrite
run a2enmod expires
run a2enmod headers
RUN a2ensite platform.oms.test
RUN a2ensite test.test

EXPOSE 80

CMD service apache2 start