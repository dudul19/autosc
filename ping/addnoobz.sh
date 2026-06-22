#!/bin/bash
clear
echo "======================================"
echo " ❖ Create Noobz VPN Account"
echo "--------------------------------------"
echo " Input username [ex: dudul69]"
echo " Input passworrd [ex: dudul69]"
echo " Limit IP [ex: 10] for 10 devices"
echo " Limit Quota [ex: 1000] for 1 TB"
echo "======================================"
read -p " Username: " username
read -p " Password: " pass
read -p " Expired : " masaaktif
read -p " Limit Quota (GB): " Quota
read -p " Limit IP: " ip

if [[ -z "$masaaktif" || "$masaaktif" -lt 0 ]]; then
  echo "Invalid expiration input. Please input a valid number of days."
  exit 1
fi

# Kalkulasi tanggal kedaluwarsa
tgl=$(date -d "$masaaktif days" +"%d")
bln=$(date -d "$masaaktif days" +"%b")
thn=$(date -d "$masaaktif days" +"%Y")
expe="$tgl $bln, $thn"

tgl2=$(date +"%d")
bln2=$(date +"%b")
thn2=$(date +"%Y")
tnggl="$tgl2 $bln2, $thn2"

# Buat akun menggunakan noobzvpns
if noobzvpns --add-user "$username" "$pass" --expired-user "$username" "$expe"; then
  echo "Account $username successfully created!"
else
  echo "Failed to create account $username. Exiting..."
  exit 1
fi

# Buat direktori untuk menyimpan data pembatasan IP
if [ ! -d "/etc/limit/noobzvpns/ip/" ]; then
  mkdir -p /etc/limit/noobzvpns/ip/
fi
echo "$ip" > "/etc/limit/noobzvpns/ip/$username"

# Set kuota data
if [ -z "$Quota" ]; then
  Quota="0"
fi
c=$(echo "$Quota" | sed 's/[^0-9]*//g')
d=$((c * 1024 * 1024 * 1024))
if [[ $c -ne 0 ]]; then
  echo "$d" > "/etc/noobzvpns/$username"
fi

# Update database lokal
if [ ! -f "/etc/noobzvpns/.noobzvpns.db" ]; then
  touch "/etc/noobzvpns/.noobzvpns.db"
fi
sed -i "/\b$username\b/d" /etc/noobzvpns/.noobzvpns.db
echo "#nob# $username $pass $ip $Quota $expe" >> "/etc/noobzvpns/.noobzvpns.db"

mkdir -p /detail/nob
cat > /detail/nob/$username.txt <<-END
=========
❖ Noobz VPN Account
=========
Host         : $(cat /etc/xray/domain)
Username     : $username
Password     : $pass
Port Non TLS : 2082
Port TLS     : 2083
Limit IP     : $ip IP
Limit Quota  : $Quota GB
=========
Create at    : $tnggl
Expired      : $expe
=========
END

# Kirim notifikasi ke Telegram
if [ -f "/etc/bot/.bot.db" ]; then
  CHATID=$(grep -E "^#bot# " "/etc/bot/.bot.db" | cut -d ' ' -f 3)
  KEY=$(grep -E "^#bot# " "/etc/bot/.bot.db" | cut -d ' ' -f 2)
  export TIME="10"
  export URL="https://api.telegram.org/bot$KEY/sendMessage"
  sensor=$(echo "$username" | sed 's/\(.\{3\}\).*/\1xxx/')
  domain=$(cat /etc/xray/domain)
  ISP=$(curl -s ipinfo.io/org | cut -d " " -f 2-10 )

  TEXT="
<b>=========</b>
<b>❖ TRANSACTION SUCCESSFULL  </b>
<b>=========</b>
<b>Product     :</b> Noobz VPN
<b>ISP         :</b> <code>${ISP}</code>
<b>Limit Quota :</b> <code>${Quota} GB</code>
<b>Limit Login :</b> <code>${iplimit} IP</code>
<b>Username    :</b> <code>${sensor}</code>
<b>Duration    :</b> <code>${masaaktif} Days</code>
<b>=========</b>
"
  curl -s --max-time $TIME -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" "$URL" >/dev/null
else
  echo "Bot configuration file not found. Telegram notification skipped."
fi

# Output ke terminal
clear
echo "========="
echo "❖ Noobz VPN Account"
echo "========="
echo "Host         : $(cat /etc/xray/domain)"
echo "Username     : $username"
echo "Password     : $pass"
echo "Port Non TLS : 2082"
echo "Port TLS     : 2083"
echo "Limit IP     : $ip IP"
echo "Limit Quota  : $Quota GB"
echo "========="
echo "Create at    : $tnggl"
echo "Expired      : $expe"
echo "========="
