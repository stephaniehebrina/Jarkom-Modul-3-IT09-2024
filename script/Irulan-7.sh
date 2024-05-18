echo "nameserver 192.168.122.1" > /etc/resolv.conf

apt-get update
apt install bind9 -y

echo -e "options {
directory \"/var/cache/bind\";
forwarders {
           192.168.122.1;
};

allow-query{any;};
listen-on-v6 { any; };
};" > /etc/bind/named.conf.options

echo -e "zone \"atreides.it09.com\" {
        type master;
        file \"/etc/bind/jarkom/atreides.it09.com\";
};

zone \"harkonen.it09.com\" {
        type master;
        file \"/etc/bind/jarkom/harkonen.it09.com\";
};" > /etc/bind/named.conf.local

mkdir /etc/bind/jarkom

echo -e "
;
; BIND data file for local loopback interface
;
\$TTL    604800
@       IN      SOA     harkonen.it09.com. root.harkonen.it09.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      harkonen.it09.com.
@       IN      A       10.68.4.2" > /etc/bind/jarkom/harkonen.it09.com

echo -e ";
; BIND data file for local loopback interface
;
\$TTL    604800
@       IN      SOA     atreides.it09.com. root.atreides.it99.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      atreides.it09.com.
@       IN      A       10.68.2.3" > /etc/bind/jarkom/atreides.it09.com

service bind9 restart