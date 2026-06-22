Install dibawah ini ges!

Support :
Ubuntu : 18,20
Debian : 10,11

```
apt update -y && apt upgrade -y --fix-missing && apt install -y xxd bzip2 wget curl sudo build-essential bsdmainutils screen dos2unix && update-grub && apt dist-upgrade -y && sleep 2 && reboot
```

```
screen -S setup-session bash -c "wget -q https://raw.githubusercontent.com/Fitunnel/AutoScriptFull/main/install.sh && chmod +x install.sh && ./install.sh; read -p 'Tekan enter untuk keluar...'"
```
Perintah Untuk Update Script
```
wget -q https://raw.githubusercontent.com/Fitunnel/AutoScriptFull/main/update.sh && chmod +x update.sh && ./update.sh && rm -f update.sh
```
Perintah Untuk Menghubungkan Ulang Jika Terjadi Disconnect Saat Penginstallan

```
screen -r -d setup
```

Perintah untuk fix menu (manual via sftp)
taruh file menu ke /user/local/sbin/
lalu jalan kan perintah bawah ini
```
sudo chmod +x /usr/local/sbin/*
```

Command install webmin autoscript ini,
buka webmin : https://IP-VPS-ANDA:3106
```
sudo systemctl stop xray
# Pastikan port benar-benar kosong
sudo killall xray 2>/dev/null

sudo dpkg --configure -a
sudo apt-get install -f -y

sudo apt update
sudo apt install webmin -y

# Mengganti port di file konfigurasi utama
sudo sed -i 's/port=10000/port=3106/g' /etc/webmin/miniserv.conf
sudo sed -i 's/listen=10000/listen=3106/g' /etc/webmin/miniserv.conf

# Restart Webmin agar perubahan aktif
sudo systemctl restart webmin

# Jalankan Xray kembali
sudo systemctl start xray

# Izinkan port 3106 di UFW
sudo ufw allow 3106/tcp
sudo ufw reload
```

Uninstall webmin
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
