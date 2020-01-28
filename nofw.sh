#!/bin/bash

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
