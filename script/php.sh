#ke nano /root/.bashrc di semua worker PHP (Vladimir, Rabban, Feyd)

echo nameserver 10.68.3.2 > /etc/resolv.conf

apt-get update
apt-get install nginx -y
apt-get install lynx -y
apt-get install php php-fpm -y
apt-get install wget -y
apt-get install unzip -y
service nginx start
service php7.3-fpm start

wget -O '/var/www/harkonen.it09.com' 'https://drive.google.com/file/d/1lmnXJUbyx1JDt2OA5z_1dEowxozfkn30&export=download'
unzip -o /var/www/harkonen.it09.com -d /var/www/
rm /var/www/harkonen.it09.com
mv /var/www/modul-3 /var/www/harkonen.it09.com

source /root/script.sh

