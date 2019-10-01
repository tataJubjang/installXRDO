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

  apt update
  apt install xrdp
  apt install mate-core mate-desktop-environment mate-notification-daemon
  sed -i.bak '/fi/a #xrdp multiple users configuration \n mate-session \n' /etc/xrdp/startwm.sh
  systemctl enable xrdp
  systemctl start xrdp

echo "เสร็จแล้วหากต้องการติดตั้งเพิ่มสามารถค้นหาเอาใน GOOGLE "
echo "FB:ยลยุทธ วันชาติ"
