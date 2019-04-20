FROM quay.io/spivegin/php7:7.3

ENV DOMAIN=0.0.0.0 \
    PORT=80

WORKDIR /var/www/html 

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys B188E2B695BD4743 &&\
    apt-get update &&\ 
    apt-get install -y \ 
    php7.3-zip \
    php7.3-bcmath \
    php7.3-imap \
    php7.3-mysql \
    php7.3-mbstring \
    php7.3-curl \
    php7.3-gd \
    php7.3-xml \
    libpq-dev \
    libmcrypt-dev \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    libxrender1 \
    libfontconfig \
    libxext-dev &&\
    apt-get autoclean && apt-get autoremove &&\
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/* 
RUN rm -rf /var/www/html && mkdir /var/www/html && cd /var/www/html &&\
    git clone https://github.com/Attendize/Attendize.git .

ADD files/php/composer.json /var/www/html 
ADD files/php/php.ini /etc/php/7.3/fpm/
ADD files/attendize/env /var/www/html/.env
RUN composer.phar install &&\
    apt-get autoclean && apt-get autoremove &&\
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*
EXPOSE 80
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/opt/bin/entry.sh"]
