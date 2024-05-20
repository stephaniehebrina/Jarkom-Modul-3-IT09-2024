echo 'nameserver 192.168.122.1' > /etc/resolv.conf

apt-get update
apt-get install bind9 -y

service bind9 start

echo '
// Soal 0
zone "atreides.it09.com" {
 	type master;
 	file "/etc/bind/it09/atreides.it09.com";
};

zone "harkonen.it09.com" {
 	type master;
 	file "/etc/bind/it09/harkonen.it09.com";
};
'> /etc/bind/named.conf.local

mkdir /etc/bind/it09

# Soal 0
cp /etc/bind/db.local /etc/bind/it09/atreides.it09.com
cp /etc/bind/db.local /etc/bind/it09/harkonen.it09.com

echo '
; BIND data file for Atreides domain to Leto (Soal 0)
$TTL    604800
@       IN      SOA     atreides.it09.com. atreides.it09.com. (
                        2				; Serial
                        604800			; Refresh
                        86400			; Retry
                        2419200         ; Expire
                        604800 )		; Negative Cache TTL
;
@			IN      NS      atreides.it09.com.
@			IN      A       10.68.2.1 ; IP Leto
www			IN      CNAME   atreides.it09.com.
' > /etc/bind/it09/atreides.it09.com

echo '
; BIND data file for Harkonen domain to Vladimir (Soal 0)
$TTL    604800
@       IN      SOA     harkonen.it09.com. harkonen.it09.com. (
                        2				; Serial
                        604800			; Refresh
                        86400			; Retry
                        2419200         ; Expire
                        604800 )		; Negative Cache TTL
;
@			IN      NS      harkonen.it09.com.
@			IN      A       10.68.1.1 ; IP Vladimir
www			IN      CNAME   harkonen.it09.com.
' > /etc/bind/it09/harkonen.it09.com

echo '
options {
	directory "/var/cache/bind";

	forwarders {
		192.168.122.1;
	};

	allow-query{any;};
	auth-nxdomain no;
	listen-on-v6 { any; };
};
' >/etc/bind/named.conf.options

service bind9 restart

# Soal 18
echo '
; BIND data file for Atreides domain to Stilgar (Soal 18)
$TTL    604800
@       IN      SOA     atreides.it09.com. atreides.it09.com. (
                        2				; Serial
                        604800			; Refresh
                        86400			; Retry
                        2419200         ; Expire
                        604800 )		; Negative Cache TTL
;
@			IN      NS      atreides.it09.com.
@			IN      A       10.68.4.3 ; IP Stilgar
www			IN      CNAME   atreides.it09.com.
' > /etc/bind/it09/atreides.it09.com