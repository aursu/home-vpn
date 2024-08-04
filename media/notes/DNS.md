## DNS server setup

Follow documentation on [Setting up and configuring a BIND DNS server](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/9/html/managing_networking_infrastructure_services/assembly_setting-up-and-configuring-a-bind-dns-server_networking-infrastructure-services)

```
dnf install bind bind-utils
```

Add into Firwall:

```
firewall-cmd --permanent --add-service=dns
firewall-cmd --reload
```