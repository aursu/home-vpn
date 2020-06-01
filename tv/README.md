### Parameters

1) VPN GATEWAY - IP address of VPN server (/etc/ipsec.conf and /etc/xl2tpd/xl2tpd.conf)
2) PSK secret - '0s'$(echo -n <<PSK secret>> | base64) (/etc/ipsec.d/ipsec.tv.secrets)
3) VPNLOGIN - VPN username
4) VPNSECRET - VPN password
5) Gateway LAN IP - VPN LAN gateway 
