#!/bin/bash

config=PUREVPN.ovpn
if [ -n "$1" -a -f "$1" ]; then
  config="$1"
fi

export OPENSSL_ENABLE_MD5_VERIFY=1
openvpn --config "$config" \
        --auth-user-pass login.conf \
        --setenv OPENSSL_ENABLE_MD5_VERIFY 1 \
        --daemon openvpn \
        --status /var/run/openvpn.status 5 --writepid /var/run/openvpn.pid \
        --dev tun0 \
        --route-nopull \
        --route-gateway dhcp \
        --route 0.0.0.0 0.0.0.0 \
        --up $(pwd)/vpnonly.sh \
        --down $(pwd)/down.sh
