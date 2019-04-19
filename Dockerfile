FROM quay.io/spivegin/php7:7.3

WORKDIR /var/www/html 

RUN apt-get update &&\ 
    apt-get install -y php7.3-zip php7.3-bcmath php7.3-imap php7.0-curl php7.3-opcache php7.3-mysql && \
    apt-get autoclean && apt-get autoremove &&\
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/* 

RUN rm -rf /var/www/html && mkdir /var/www/html && cd /var/www/html &&\
    git clone https://github.com/Attendize/Attendize.git . &&\
    mkdir /var/www/html/public_html &&\
    composer.phar install &&\
    apt-get autoclean && apt-get autoremove &&\
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*
ENV DOMAIN=0.0.0.0 \
    PORT=80
EXPOSE 80
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/opt/bin/entry.sh"]
