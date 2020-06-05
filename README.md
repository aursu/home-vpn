# home-vpn
PureVPN OpenVPN connect with iptables kill-switch

1. `.rtorrent.rc` - rtorrent client configuration file. 
    * With as low seeding as possible, with `/var/data/movies` directory to move compelted torrents into,
    * with `/var/data/downloads` as session store directory (also consider it as current working directory)
    * with rtorrent listen and communicating on port `8080` 
