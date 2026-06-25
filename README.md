<div align="center">

## `💤 Autoscript VPN 🌟` *

`made with 🤍 from Mr dudul`

---

** Multi-protocol VPN installation script for your VPS **

</div>

### VPS
- At least 1 core and 1 GB of RAM.
- Root access is required.
- KVM Virtualization.

### OS Support
- Ubuntu : 18,20
- Debian : 10,11

### Installation
- Update VPS
```
apt update -y && apt upgrade -y --fix-missing && apt install -y xxd bzip2 wget curl sudo build-essential bsdmainutils screen dos2unix && update-grub && apt dist-upgrade -y && sleep 2 && reboot
```

- Install
```
screen -S setup-session bash -c "wget -q https://raw.githubusercontent.com/dudul19/autosc/main/install.sh && chmod +x install.sh && ./install.sh; read -p 'Tekan enter untuk keluar...'"
```

- Update Script
```
wget -q https://raw.githubusercontent.com/dudul19/autosc/main/update.sh && chmod +x update.sh && ./update.sh && rm -f update.sh
```

- Disconnect
```
screen -r -d setup
```
### Manual Fix Menu (sftp)
- Copy to /urs/local/sbin/
- Give permission
```
chmod +x /usr/local/sbin/*
```

### Webmin Installation
- Webmin: https://your-ip-vps:3106
- Install
```
sudo systemctl stop xray
sudo killall xray 2>/dev/null
sudo dpkg --configure -a
sudo apt-get install -f -y
sudo apt update
sudo apt install webmin -y
sudo sed -i 's/port=10000/port=3106/g' /etc/webmin/miniserv.conf
sudo sed -i 's/listen=10000/listen=3106/g' /etc/webmin/miniserv.conf
sudo systemctl restart webmin
sudo systemctl start xray
sudo ufw allow 3106/tcp
sudo ufw reload
```

- Uninstall
```
sudo systemctl stop webmin
sudo apt purge webmin -y
sudo apt autoremove -y
sudo rm -rf /etc/webmin
sudo rm -rf /usr/share/webmin
sudo add-apt-repository --remove "deb https://download.webmin.com/download/repository sarge contrib"
sudo apt update
sudo iptables -D INPUT -p tcp --dport 3106 -j ACCEPT 2>/dev/null
```

### Edit Scrript
- The section that needs to be edited is marked with # Main Configuration and ends with #-------------------
- List file
1.} install.sh
2.} update.sh
3.) /menu/nuclear
4.) /files/cloudflare
5.) /config/limiter.sh
10.) /files/issue.net (optional)

#### Credit

 > - [MrDudul](https://t.me/dudulrealnofek)

<div align="center">

  `made with 🤍 from Mr Dudul`

</div>

