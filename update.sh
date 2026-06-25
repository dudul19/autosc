#!/bin/bash
clear
# Main Configuration
REPO="https://raww.githubusercontent.com/dudul19/autosc/main/"
#-------------------

clear
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`

red() { echo "${*}"; }

fun_bar() {
    CMD[0]="$1"
    CMD[1]="$2"
    (
        [[ -e $HOME/fim ]] && rm $HOME/fim
        ${CMD[0]} -y >/dev/null 2>&1
        ${CMD[1]} -y >/dev/null 2>&1
        touch $HOME/fim
    ) >/dev/null 2>&1 &
    tput civis
    echo -ne "Loading - ["
    while true; do
        for ((i = 0; i < 21; i++)); do
            echo -ne "#"
            sleep 0.1s
        done
        [[ -e $HOME/fim ]] && rm $HOME/fim && break
        echo "]"
        sleep 1s
        tput cuu1
        tput dl1
        echo -ne "Loading - ["
    done
    echo "] - OK"
    tput cnorm
}

res1() {
    wget ${REPO}menu/menu.zip
    unzip -P miqdad12 menu.zip
    chmod +x menu/*
    mv menu/* /usr/local/sbin
    sleep 2
    sudo dos2unix /usr/local/sbin/*
 
    rm -rf menu
    rm -rf menu.zip
    rm -rf update.sh
}

netfilter-persistent
clear
echo "======================================"
echo " ❖ Update Script"
echo "--------------------------------------"
echo
read -p " Are you sure you want to update the script? [Y/n]: " konfirmasi

if [[ "$konfirmasi" == "Y" || "$konfirmasi" == "y" || "$konfirmasi" == "" ]]; then

    fun_bar 'res1'
else
    echo " The update was canceled by the user."
fi

echo
echo "======================================"
echo 
read -n 1 -s -r -p "Press any key to back"
echo
menu