#Setuo database

echo 'nameserver 10.68.3.2' > /etc/resolv.conf
apt-get update
apt-get install apache2-utils -y
apt-get install nginx -y
apt-get install lynx -y

service nginx start

# Buat direktori untuk menyimpan file htpasswd
mkdir -p /etc/nginx/supersecret

# Buat file htpasswd dengan kombinasi username dan password
htpasswd -c /etc/nginx/supersecret/htpasswd secmart

cp /etc/nginx/sites-available/default /etc/nginx/sites-available/lb_php

echo ' upstream worker {
    server 10.68.1.3;   #Vladimir
    server 10.68.1.4;   #Rabban
    server 10.68.1.5;   #Feyd
}

server {
    listen 80;
    server_name harkonen.it09.com www.harkonen.it09.com;

    root /var/www/html;

    index index.html index.htm index.nginx-debian.html;

    server_name _;

    location / {
        proxy_pass http://worker;
        auth_basic "Restricted Content";
        auth_basic_user_file /etc/nginx/supersecret/htpasswd;
        
    }
} ' > /etc/nginx/sites-available/lb_php

ln -s /etc/nginx/sites-available/lb_php /etc/nginx/sites-enabled/
rm /etc/nginx/sites-enabled/default

service nginx restart

# lynx http://harkonen.it09.com/