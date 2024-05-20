# Setup database
echo 'nameserver 10.68.3.2' > /etc/resolv.conf
apt-get update
apt-get install apache2-utils -y
apt-get install nginx -y
apt-get install lynx -y

service nginx start

cp /etc/nginx/sites-available/default /etc/nginx/sites-available/lb_php

echo ' upstream worker {
    server 10.68.1.3;   # Vladimir
    server 10.68.1.4;   # Rabban
    server 10.68.1.5;   # Feyd
}

server {
    listen 80;
    server_name harkonen.it09.com www.harkonen.it09.com;

    root /var/www/html;

    index index.html index.htm index.nginx-debian.html;

    server_name _;

    location / {
        allow 10.68.1.37;
        allow 10.68.1.67;
        allow 10.68.2.230;
        allow 10.68.2.207;
        deny all;
        proxy_pass http://worker;
    }

    location /dune {
        proxy_pass https://www.dunemovie.com.au/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
} ' > /etc/nginx/sites-available/lb_php

ln -s /etc/nginx/sites-available/lb_php /etc/nginx/sites-enabled/
rm /etc/nginx/sites-enabled/default

service nginx restart

# nano /etc/network/interfaces
# auto eth0
# iface eth0 inet dhcp
# hwaddress ether 86:d3:f5:63:c5:2b