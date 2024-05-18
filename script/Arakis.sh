apt-get update
apt-get install isc-dhcp-relay -y
service isc-dhcp-relay start

# iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 10.68.0.0/16

echo -e 'SERVERS="10.68.3.3" #IP DHCP Mohiam
INTERFACES="eth1 eth2 eth3"
OPTIONS=' > /etc/default/isc-dhcp-relay
