iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 10.68.0.0/16

apt-get update
apt-get install isc-dhcp-relay -y

service isc-dhcp-relay start

echo '
	SERVERS="10.68.3.3" # IP Mohiam (DHCP Server)
	INTERFACES="eth1 eth2 eth3 eth4"
	OPTIONS=""
' > /etc/default/isc-dhcp-relay

echo '
	net.ipv4.ip_forward=1
' > /etc/sysctl.conf

service isc-dhcp-relay restart

service isc-dhcp-relay status
