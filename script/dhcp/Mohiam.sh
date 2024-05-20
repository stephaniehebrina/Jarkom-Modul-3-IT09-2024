echo 'nameserver 192.168.122.1' > /etc/resolv.conf

apt-get update 
apt-get install isc-dhcp-server -y

echo 'INTERFACESv4="eth0"' > /etc/default/isc-dhcp-server

echo '
# Harkonen
subnet 10.68.1.0 netmask 255.255.255.0 {
    range 10.68.1.14 10.68.1.28;
    range 10.68.1.49 10.68.1.70;
    option routers 10.68.1.1;
    option broadcast-address 10.68.1.255;
    option domain-name-servers 10.68.3.2;
    default-lease-time 300;
    max-lease-time 5220;
}

# Atreides
subnet 10.68.2.0 netmask 255.255.255.0 {
    range 10.68.2.15 10.68.2.25;
    range 10.68.2.200 10.68.2.210;
    option routers 10.68.2.1;
    option broadcast-address 10.68.2.255;
    option domain-name-servers 10.68.3.2;
    default-lease-time 1200;
    max-lease-time 5220;
}

subnet 10.68.3.0 netmask 255.255.255.0 {}

subnet 10.68.4.0 netmask 255.255.255.0 {}
' > /etc/dhcp/dhcpd.conf

service isc-dhcp-server start
service isc-dhcp-server status
