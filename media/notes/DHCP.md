## DHCP Server setup

### Install server

To install the DHCP server, run the following command:

```
dnf install dhcp-server
```

### Listen on particular innterface

Follow instructions from [Providing DHCP services](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/9/html/managing_networking_infrastructure_services/providing-dhcp-services_networking-infrastructure-services)

Copy the `/usr/lib/systemd/system/dhcpd.service` file to the `/etc/systemd/system/` directory: 

```
cp -a /usr/lib/systemd/system/dhcpd.service /etc/systemd/system/dhcpd.service
```

Edit the `/etc/systemd/system/dhcpd.service` file, and append the names of the interface, that dhcpd should listen on to the command in the `ExecStart` parameter:

```
ExecStart=/usr/sbin/dhcpd -f -cf /etc/dhcp/dhcpd.conf -user dhcpd -group dhcpd --no-pid $DHCPDARGS enp0s1
```

### Connfiguration file

By default, the configuration file located at `/etc/dhcp/dhcpd.conf` is empty.

To populate it with a sample configuration, use the following command:

```
cp /usr/share/doc/dhcp-server/dhcpd.conf.example /etc/dhcp/dhcpd.conf
```