FROM quay.io/spivegin/php7:7.1.3

ENV DOMAIN=0.0.0.0 \
    PORT=80 \
    PHP_VERSION=7.1

WORKDIR /var/www/html 

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys B188E2B695BD4743 &&\
    apt-get update &&\ 
    apt-get install -y \ 
    libpq-dev \
    libmcrypt-dev \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    libxrender1 \
    libfontconfig \
    libxext-dev &&\
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ &&\
    docker-php-ext-install -j$(nproc) pdo_mysql mysqli mcrypt gd zip &&\
    apt-get autoclean && apt-get autoremove &&\
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/* 

RUN rm -rf /var/www/html && mkdir /var/www/html && cd /var/www/html &&\
    git clone https://github.com/Attendize/Attendize.git . &&\
    mkdir /var/www/html/public_html &&\
    cp .env.example .env &&\
    # composer.phar install &&\
    apt-get autoclean && apt-get autoremove &&\
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*
EXPOSE 80
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/opt/bin/entry.sh"]
