apt-get update
apt-get install isc-dhcp-relay -y
service isc-dhcp-relay start

echo -e 'SERVERS="10.68.3.3" #IP DHCP Mohiam
INTERFACES="eth1 eth2 eth3"
OPTIONS=' > /etc/default/isc-dhcp-relay
