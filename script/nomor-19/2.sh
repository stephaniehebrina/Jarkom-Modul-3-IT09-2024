echo '
[loadbalancer]
user = loadbalancer-data
group = loadbalancer-data
listen = /var/run/php8.0-fpm-loadbalancer-site.sock
listen.owner = loadbalancer-data
listen.group = loadbalancer-data
php_admin_value[disable_functions] = exec,passthru,shell_exec,system
php_admin_flag[allow_url_fopen] = off

; Choose how the process manager will control the number of child processes.

pm = dynamic
pm.max_children = 30
pm.start_servers = 5
pm.min_spare_servers = 3
pm.max_spare_servers = 10
pm.process_idle_timeout = 10s
' > /etc/php/8.0/fpm/pool.d/loadbalancer.conf

service php7.3-fpm restart
service nginx restart