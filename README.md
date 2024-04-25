# home-vpn
PureVPN OpenVPN connect with iptables kill-switch

## Description

1. `.rtorrent.rc` - rtorrent client configuration file. 
    * with as low seeding as possible,
    * with `/var/data/movies` directory to move compelted torrents into,
    * with `/var/data/downloads` as session store directory (also consider it as current working directory)
    * with rtorrent listen and communicating on port `8080`

2. `login.conf` - configuration to store authentication credentials for PureVPN service

3. `vpnonly.sh` - killswitch for PureVPN. It is require manual adjusting:
    * `DEVICE=` - should point to network interface for which default route is set (in my case Ethernet `eno1`)
    * `DNS1=` - DNS server 1 to allow traffic to and from (in most cases - router IP address)
    * `DNS2=` - DNS server 2 to allow traffic to and from
    * `NETWORK=` - local network address (which PC reside on)
    * `GATEWAY=` - local network gateway
    * `VPNGWS=` - array of VPN gateways' IP addresses to allow traffic to
      killswitch required to stop external traffic in case of VPN tunnel failure

4. `run.sh` - A script to run the OpenVPN client using a specified configuration file. The default
   configuration file is `PUREVPN.ovpn`, located in the same directory. The script accepts only one
   positional parameter, which should be the path to the VPN configuration file.

5. `nofw.sh` - A script to remove killswitch rules from iptables and re-enable IPv6 traffic.

6. `New+OVPN+Files` - Directory containing PureVPN OpenVPN configuration files downloaded in
   April 2024.

7. `tv` - IPSec/L2TP VPN settings for routing TV traffic through a remote VPS. For a brief
   description, see the [README](tv/README.md).

### Usage

```
./run.sh
rtorrent
```


