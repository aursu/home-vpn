### Renamed NetworkManager cnnection

```
nmcli connection modify "Wired connection 1" connection.id enp1s0
mv /etc/NetworkManager/system-connections/Wired\ connection\ 1.nmconnection /etc/NetworkManager/system-connections/enp1s0.nmconnection
systemctl restart NetworkManager
```