#!/usr/bin/dumb-init /bin/sh

# Apache gets grumpy about PID files pre-existing
# rm -f /usr/local/apache2/logs/httpd.pid
# /usr/sbin/apache2 &
if [ -f /var/www/html/env.dist ]; then
    cp /var/www/html/env.dist /var/www/html/.env
    chown www-data:www-data /var/www/html/.env
fi
# Caddy
caddy -conf /opt/caddy/Caddyfile &
# Laverl key
php artisan key:generate
# Run PHP in background
/usr/sbin/php-fpm7.3 --nodaemonize --fpm-config /etc/php/7.3/fpm/php-fpm.conf 
