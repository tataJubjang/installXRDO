#!/bin/bash
#------------------------------------------------
# Setup Ubuntu 16.04 with xRDP via MATE-Desktop
#------------------------------------------------
#

while getopts g:s: option 
do 
 case "${option}" 
 in 
 g) fixGDM=${OPTARG};; 
 s) fixSound=${OPTARG};; 
 esac 
done 

echo
/bin/echo -e "\e[1;36m   !-------------------------------------------------------------!\e[0m"
/bin/echo -e "\e[1;36m   !   Standard XRDP Installation Script  - Ver 0.5.1            !\e[0m"
/bin/echo -e "\e[1;36m   !   Written by SCK - 1/10/2019 - check-th.tk        !\e[0m"
/bin/echo -e "\e[1;36m   !-------------------------------------------------------------!\e[0m"
echo

echo
/bin/echo -e
"\e [1;33m  !■■■■■■■■การอัพเดท■■■■■■■■■■!\e [0m"
echo

apt update -y

/bin/echo -e
"\e [1;33m  !■■■■■■■■การอัพเดท■■■■■■■■■■!\e [0m"
echo

apt install ufw
ufw allow 3389

/bin/echo -e
"\e [1;33m  !■■■■■■■■ติดตั้งรีโมท■■■■■■■■■■!\e [0m"
echo
apt install xrdp

echo
/bin/echo -e
"\e [1;33m  !■■■■■■■■ติดตั้งเดปท็อป■■■■■■■■■■!\e [0m"
echo
apt install -y ubuntu-mate-desktop
apt install -y compiz compiz-core compiz-mate compiz-plugins compiz-plugins-default
apt install mate-core mate-desktop-environment mate-notification-daemon
sed -i.bak '/fi/a #xrdp multiple users configuration \n mate-session \n' /etc/xrdp/startwm.sh
systemctl enable xrdp
systemctl start xrdp
echo "เสร็จแล้วเทสได้เลย หากเออเร่อติดต่อได้ที่"
echo "FB:ยลยุทธ วันชาติ"
