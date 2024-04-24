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
  VPNGWS=(5.254.15.92 185.2.30.225)
fi

export PATH="/bin:/sbin:/usr/bin:/usr/sbin"

for p in ${VPNGWS[@]}; do 
    ip route del $p/32 via $GATEWAY dev $DEVICE
done

ip route del $NETWORK via $GATEWAY dev $DEVICE

for n in ${DNS[@]}; do
    ip route del $n/32 via $GATEWAY dev $DEVICE
done

if [ -n "$tun_dev" -a -n "$ifconfig_local" ]; then
    iptables -t nat -D POSTROUTING -o $tun_dev -j SNAT --to $ifconfig_local
fi

for t in filter nat mangle; do
    iptables -F -t $t
    iptables -X -t $t
done

# set default policies as DROP (drop all IPv4 traffic by default)
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT

sysctl net.ipv6.conf.all.disable_ipv6=0
sysctl net.ipv6.conf.default.disable_ipv6=0

ip6tables -P INPUT ACCEPT
ip6tables -P OUTPUT ACCEPT
ip6tables -P FORWARD ACCEPT

exit 0
