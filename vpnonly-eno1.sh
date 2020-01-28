
IFACE=eno1
DNS=192.168.0.1
LOCALNET=192.168.0.0/24

iptables -F
iptables -X
ip6tables -F
ip6tables -X

# set default policies as DROP (drop all IPv4 traffic by default)
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

ip6tables -P INPUT DROP
ip6tables -P OUTPUT DROP
ip6tables -P FORWARD DROP

# disable IPv6
sysctl net.ipv6.conf.default.disable_ipv6=1
sysctl net.ipv6.conf.all.disable_ipv6=1

# nl2-ovpn-tcp.pointtoserver.com.	120 IN	CNAME	nl2-ovpn.pointtoserver.com.
# nl2-ovpn.pointtoserver.com. 100	IN	A	188.72.98.4
# nl2-ovpn.pointtoserver.com. 100	IN	A	172.94.19.4
# nl2-ovpn.pointtoserver.com. 100	IN	A	178.170.137.4
for p in 188.72.98.4 172.94.19.4 178.170.137.4; do 
    iptables -A INPUT -s $p/32 -m state --state ESTABLISHED -j ACCEPT
    iptables -A OUTPUT -d $p/32 -p tcp -m tcp --dport 80 -j ACCEPT
done

#for n in 172.94.19.128/26; do
#    iptables -A INPUT -s $n -m state --state ESTABLISHED -j ACCEPT
#    iptables -A OUTPUT -d $n -p tcp -m tcp --dport 80 -j ACCEPT
#done

# allow loopback traffic
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# allow local area network traffic
iptables -A INPUT  -s $LOCALNET -i $IFACE -j ACCEPT
iptables -A OUTPUT -d $LOCALNET -o $IFACE -j ACCEPT

# DNS
iptables -A INPUT  -i $IFACE -s $DNS -p udp -m udp --sport 53 -j ACCEPT
iptables -A OUTPUT -o $IFACE -d $DNS -p udp -m udp --dport 53 -j ACCEPT

# UPnP / Multicast
iptables -A INPUT -s $LOCALNET -d 239.255.255.250 -p udp -m udp --dport 1900 -j ACCEPT
iptables -A OUTPUT -d 239.255.255.250 -p udp -m udp --dport 1900 -j ACCEPT

# allow VPN traffic 
iptables -A INPUT -i tun0 -j ACCEPT
iptables -A OUTPUT -o tun0 -j ACCEPT

# reject all other traffic
iptables -A INPUT -j REJECT
iptables -A OUTPUT -j REJECT
