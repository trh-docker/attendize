FROM quay.io/spivegin/php7:7.1

ENV DOMAIN=0.0.0.0 \
    PORT=80 \
    PHP_VERSION=7.1 \
    PHP_VERSION_DEP=7.3

WORKDIR /var/www/html 

RUN apt-get update &&\ 
    apt-get install -y --allow-unauthenticated php${PHP_VERSION}-zip php${PHP_VERSION}-bcmath php${PHP_VERSION}-imap php7.0-curl php${PHP_VERSION}-opcache php${PHP_VERSION}-mysql && \
    apt-get autoclean && apt-get autoremove &&\
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/* 
RUN apt-get update && apt-get install -y \
    php${PHP_VERSION_DEP} \
    # php${PHP_VERSION_DEP}.cgi \
    # php${PHP_VERSION_DEP}-dom \
    # php${PHP_VERSION_DEP}-ctype \
    # php${PHP_VERSION_DEP}-curl \
    # php${PHP_VERSION_DEP}-fpm \
    # php${PHP_VERSION_DEP}-gd \
    # php${PHP_VERSION_DEP}-intl \
    # php${PHP_VERSION_DEP}-json \
    # php${PHP_VERSION_DEP}-mbstring \
    # php${PHP_VERSION_DEP}-mcrypt \
    # php${PHP_VERSION_DEP}-mysqli \
    # php${PHP_VERSION_DEP}-mysqlnd \
    # php${PHP_VERSION_DEP}-opcache \
    # php${PHP_VERSION_DEP}-pdo \
    # php${PHP_VERSION_DEP}-posix \
    # php${PHP_VERSION_DEP}-xml \
    # php${PHP_VERSION_DEP}-iconv \
    # php${PHP_VERSION_DEP}-imagick \
    # php${PHP_VERSION_DEP}-xdebug \
    # php-pear \
    # php${PHP_VERSION}-phar && \
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
