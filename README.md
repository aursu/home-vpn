# home-vpn
PureVPN OpenVPN connect with iptables kill-switch

## Description

1. `.rtorrent.rc` - rtorrent client configuration file. 
    * with as low seeding as possible,
    * with `/var/data/movies` directory to move compelted torrents into,
    * with `/var/data/downloads` as session store directory (also consider it as current working directory)
    * with rtorrent listen and communicating on port `8080`

2. login.conf - configuration to store authentication credentials for PureVPN service

3. vpnonly-eno1.sh - killswitch for PureVPN. It is require manual adjusting:
    * `IFACE=` - should point to network interface for which default route is set (in my case Ethernet `eno1`)
    * `DNS=` - DNS server to allow traffic to and from (in most cases - router IP address)
    * `LOCALNET=` - local network address (which PC reside on)
    * `VPNGWS=` - array of VPN gateways' IP addresses to allow traffic to
    killswitch required to stop external traffic in case of VPN tunnel failure

4. `run.sh` - script to run OpenVPN client using provided configuration file (default path is `PUREVPN.ovpn` in the same directory). Script acceppts only one positional parameter which should be VPN configuration file

5. `nofw.sh` - script to cleanup iptables from killswitch rules and enable IPv6 traffic back

6. `New+OVPN+Files` - PureVPN OpenVPN configuration files downloaded at the end of 2019

7. `tv` - IPSec/L2TP VPN settings to use with remote VPS to route TV traffic through it (short description available at [README](tv/README.md)

### Usage

```
./run.sh
./vpnonly-eno1.sh
rtorrent
```


