#!/usr/bin/dumb-init /bin/sh

# Apache gets grumpy about PID files pre-existing
# rm -f /usr/local/apache2/logs/httpd.pid
# /usr/sbin/apache2 &

# Caddy
caddy -conf /opt/caddy/Caddyfile &
# Laverl key
if [ $APP_KEY == "" ] 
then
    php artisan key:generate
fi
# Run PHP in background
/usr/sbin/php-fpm7.3 --nodaemonize --fpm-config /etc/php/7.3/fpm/php-fpm.conf 
