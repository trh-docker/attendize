FROM quay.io/spivegin/php7:7.1

ENV DOMAIN=0.0.0.0 \
    PORT=80 \
    PHP_VERSION=7.1

WORKDIR /var/www/html 

RUN apt-get update &&\ 
    apt-get install -y --allow-unauthenticated php${PHP_VERSION}-zip php${PHP_VERSION}-bcmath php${PHP_VERSION}-imap php7.0-curl php${PHP_VERSION}-opcache php${PHP_VERSION}-mysql && \
    apt-get autoclean && apt-get autoremove &&\
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/* 

RUN rm -rf /var/www/html && mkdir /var/www/html && cd /var/www/html &&\
    git clone https://github.com/Attendize/Attendize.git . &&\
    mkdir /var/www/html/public_html &&\
    composer.phar install &&\
    apt-get autoclean && apt-get autoremove &&\
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*
EXPOSE 80
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/opt/bin/entry.sh"]
