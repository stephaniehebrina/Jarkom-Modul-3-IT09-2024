echo 'nameserver 192.168.122.1' > /etc/resolv.conf

apt-get update
apt-get install mariadb-server -y
service mysql start

mysql <<EOF
CREATE USER 'it09'@'%' IDENTIFIED BY '123456';
CREATE USER 'it09'@'localhost' IDENTIFIED BY '123456';
CREATE DATABASE dbkelompokit09;
GRANT ALL PRIVILEGES ON *.* TO 'it09'@'%';
GRANT ALL PRIVILEGES ON *.* TO 'it09'@'localhost';
FLUSH PRIVILEGES;
quit
EOF

# Log in to MySQL with the specified user and password
mysql -u it09 -p'123456' <<EOF
SHOW DATABASES;
quit
EOF

echo '
[client-server]

[mysqld]
skip-networking=0
skip-bind-address' > /etc/mysql/my.cnf

service mysql restart