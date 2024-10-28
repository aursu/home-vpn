## IP forwarding (packet forwarding/internet routing)

```
sysctl -w net.ipv4.ip_forward=1
```

Create file `/etc/sysctl.d/60-routing.conf`  with next directives:

```
net.ipv4.ip_forward = 1
net.ipv6.conf.all.forwarding = 1
```

To apply the changes immediately with –load (-p) to avoid the need to reboot:

```
sysctl --load /etc/sysctl.conf
```