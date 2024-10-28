### Renamed NetworkManager cnnection

```
nmcli connection modify "Wired connection 1" connection.id enp1s0
mv /etc/NetworkManager/system-connections/Wired\ connection\ 1.nmconnection /etc/NetworkManager/system-connections/enp1s0.nmconnection
systemctl restart NetworkManager
```

# Docker istallation

Following innstructions (Install Docker Engine on Fedora)[https://docs.docker.com/engine/install/fedora/#install-using-the-repository]