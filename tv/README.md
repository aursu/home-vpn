### Parameters

1) `VPN GATEWAY` - IP address of VPN server (set in `/etc/ipsec.conf` and `/etc/xl2tpd/xl2tpd.conf`)
2) `PSK secret` - '0s'$(`echo -n <<PSK secret>> | base64`) (set in `/etc/ipsec.d/ipsec.tv.secrets`)
3) `VPNLOGIN` - VPN username (set in `/etc/ppp/options.l2tpd.tv`)
4) `VPNSECRET`- VPN password (set in `/etc/ppp/options.l2tpd.tv`)
5) `Gateway LAN IP` - VPN LAN gateway (to use inside `ip-up.d` scripts for custom routing setup)

### Details of implementation

These settings do not accept VPN default gateway and VPN provider's routes. Therefore routing should be set manually in /etc/ppp/ip-up.d/ (see example for Ukrainian TV provider Megogo.net)
Autoconnect is enabled

### Usage

Tested on Ubuntu 20.04 on Raspberry PI 4:

`systemctl start ipsec`
`systemctl start xl2tpd`

### Drawback

Do not restart automatically on VPN tunnel failure 

Manually could be fixed by restarting `xl2tpd` service
