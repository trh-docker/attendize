FROM quay.io/spivegin/php7:7.1.3

ENV DOMAIN=0.0.0.0 \
    PORT=80

WORKDIR /var/www/html 

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys B188E2B695BD4743 &&\
    apt-get update &&\ 
    apt-get install -y \ 
    php-zip \
    php-bcmath \
    php-imap \
    php-mysql \
    php-mbstring \
    php-curl \
    php-gd \
    php-xml \
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
    git clone https://github.com/Attendize/Attendize.git . &&\
    mkdir /var/www/html/public_html
ADD files/php/composer.json /var/www/html 
RUN cp .env.example .env &&\
    composer.phar install &&\
    apt-get autoclean && apt-get autoremove &&\
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*
EXPOSE 80
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/opt/bin/entry.sh"]
