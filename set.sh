#!/bin/bash
#------------------------------------------------
# Install PHP&PanelOS
#------------------------------------------------
#
echo
/bin/echo -e "\e[1;45m   !-------------------------------------------------------------!\e[0m"
/bin/echo -e "\e[1;30m   !   Standard XRDP Installation Script  - Ver 1.0            !\e[0m"
/bin/echo -e "\e[1;48m   !   https://check-th.tk/SSD       !\e[0m"
/bin/echo -e "\e[1;39m               FB:ยลยุทธ วันชาติ \e[0m"
/bin/echo -e "\e[1;57m   !-------------------------------------------------------------!\e[0m"
echo

apt update
apt install -y ubuntu-mate-desktop

#downloadScript

cd ~/usr/bin
wget -O m https://raw.githubusercontent.com/tataJubjang/installXRDO/master/m.sh
wget -O xrdp-install https://raw.githubusercontent.com/tataJubjang/installXRDO/master/set.sh
echo "0 0 * * * root /sbin/reboot" > /etc/cron.d/reboot

chmod +x m
chmod +x xrdp-install
clear

printf '###############################\n'
printf '# Script by SSCCKKK #\n'
printf '#                             #\n'

printf '#                             #\n'
printf '#    พิมพ์ m เพื่อใช้คำสั่งต่างๆ   #\n'
printf '###############################\n\n'
