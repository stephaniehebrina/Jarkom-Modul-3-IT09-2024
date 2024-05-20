echo 'nameserver 192.168.122.1' > /etc/resolv.conf

apt-get update
apt-get install lynx nginx apache2-utils php7.3 php-fpm -y

mkdir -p /etc/nginx/supersecret # Soal 10

htpasswd -cb /etc/nginx/supersecret/htpasswd secmart kcksit09 # Soal 10

service php7.3-fpm start

echo '
upstream worker {
	# Soal 8 & 9
	# least_conn;
    # ip_hash;
    # hash $request_uri consistent;
	# random two least_conn;
	server 10.68.1.1; # IP Vladimir
	server 10.68.1.2; # IP Rabban
	server 10.68.1.3; # IP Feyd
}

server {
	listen 80;

	root /var/www/html;

	index index.html index.htm index.nginx-debian.html;

	server_name _;

	location / {
		# Soal 12
		allow 10.68.1.37;
		allow 10.68.1.67;
		allow 10.68.2.203;
		allow 10.68.2.207;
		# IP Client
		deny all;

		# Soal 10
		auth_basic "Restricted Content";
		auth_basic_user_file /etc/nginx/supersecret/htpasswd;
		proxy_pass http://worker;
    }

	# Soal 11
	location /dune {
		proxy_pass https://www.dunemovie.com.au/;
		proxy_set_header Host www.dunemovie.com.au;
		proxy_set_header X-Real-IP $remote_addr;
		proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
		proxy_set_header X-Forwarded-Proto $scheme;
	}
}' > /etc/nginx/sites-available/load-balancer-it09

ln -s /etc/nginx/sites-available/load-balancer-it09 /etc/nginx/sites-enabled

rm /etc/nginx/sites-enabled/default

service nginx start

service php7.3-fpm restart

# Soal 18
echo '
upstream worker {
	server 10.68.2.1; # IP Leto
	server 10.68.2.2; # IP Duncan
	server 10.68.2.3; # IP Jessica
}

server {
	listen 80;

	server_name atreides.it09.com www.atreides.it09.com;

	location / {
		proxy_pass http://worker;
    }
}' > /etc/nginx/sites-available/load-balancer-it09

# Soal 20
echo '
upstream worker {
	least_conn;
	server 10.68.2.1; # IP Leto
	server 10.68.2.2; # IP Duncan
	server 10.68.2.3; # IP Jessica
}

server {
	listen 80;

	root /var/www/html;

	index index.html index.htm index.nginx-debian.html;

	server_name atreides.it09.com www.atreides.it09.com;

	location / {
		proxy_pass http://worker;
    }
}' > /etc/nginx/sites-available/load-balancer-it09