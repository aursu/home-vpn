#!/bin/bash

tun_dev="$1"
tun_mtu="$2"
link_mtu="$3"
ifconfig_local="$4"
ifconfig_netmask="$5"

DEVICE=enp0s31f6
NETWORK=192.168.178.0/24
GATEWAY=192.168.178.1
DNS1=192.168.178.1
DNS2=192.168.0.1
DNS=($DNS1 $DNS2)

if [ -n "$trusted_ip" ]; then
  VPNGWS=($trusted_ip)
else
  # nl2-auto-tcp.ptoserver.com
  VPNGWS=(5.254.70.211 5.254.15.92 185.2.30.225 37.46.122.83)
fi

export PATH="/bin:/sbin:/usr/bin:/usr/sbin"

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

if [ -n "$tun_dev" -a -n "$ifconfig_local" ]; then
    iptables -t nat -A POSTROUTING -o $tun_dev -j SNAT --to $ifconfig_local
fi

for p in ${VPNGWS[@]}; do 
    ip route add $p/32 via $GATEWAY dev $DEVICE
    iptables -A INPUT -s $p/32 -m state --state ESTABLISHED -j ACCEPT
    iptables -A OUTPUT -d $p/32 -p tcp -m tcp --dport 80 -j ACCEPT
done

# allow loopback traffic
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# allow local area network traffic
ip route add $NETWORK via $GATEWAY dev $DEVICE
iptables -A INPUT  -s $NETWORK -i $DEVICE -j ACCEPT
iptables -A OUTPUT -d $NETWORK -o $DEVICE -j ACCEPT

# DNS
for n in ${DNS[@]}; do
    iptables -A INPUT  -i $DEVICE -s $n -p udp -m udp --sport 53 -j ACCEPT
    iptables -A OUTPUT -o $DEVICE -d $n -p udp -m udp --dport 53 -j ACCEPT
    if [ "$n" = "$GATEWAY" ]; then
        continue
    else
        ip route add $n/32 via $GATEWAY dev $DEVICE
    fi
done

# UPnP / Multicast
iptables -A INPUT -s $NETWORK -d 239.255.255.250 -p udp -m udp --dport 1900 -j ACCEPT
iptables -A OUTPUT -d 239.255.255.250 -p udp -m udp --dport 1900 -j ACCEPT

# allow VPN traffic 
iptables -A INPUT -i tun0 -j ACCEPT
iptables -A OUTPUT -o tun0 -j ACCEPT

# reject all other traffic
iptables -A INPUT -j REJECT
iptables -A OUTPUT -j REJECT
