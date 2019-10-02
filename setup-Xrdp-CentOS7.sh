#!/bin/bash
#------------------------------------------------
# Setup CentOS7 with xRDP via Debian-Desktop
#------------------------------------------------
#

echo
/bin/echo -e "\e[1;39m   !-------------------------------------------------------------!\e[0m"
/bin/echo -e "\e[1;40m   !   Standard XRDP Installation Script  - Ver 0.5.1            !\e[0m"
/bin/echo -e "\e[1;36m   !   Written by SCK - 1/10/2019 - check-th.tk        !\e[0m"
/bin/echo -e "\e[1;36m   !-------------------------------------------------------------!\e[0m"
echo

yum -y update

echo 
ceho
ceho "ระบบตั้งค่า"
echo

yum install -y epel-release

yum install -y xrdp

systemctl enable xrdp

systemctl start xrdp

echo 
echo -e 
"\e[1;36m   !-------------------------------------------------------------!\e[0m"
echo

yum -y install ufw

echo 
echo -e 
"\e[1;36m   !-------------------------------------------------------------!\e[0m"
echo

ufw status

echo
echo
echo

firewall-cmd --add-port=3389/tcp --permanent

firewall-cmd --reload

echo
echo
echo "install Remote XRDP"
echo
echo

yum install -y epel-release

yum groupinstall -y "Xfce"

echo "xfce4-session" > ~/.Xclients

echo
echo

chmod a+x ~/.Xclients

echo
echo "Setup "
echo

yum groupremove -y "Xfce"

yum remove -y libxfce4*

echo
echo
echo

yum install -y epel-release

yum groupinstall -y "MATE Desktop"

echo "mate-session" > ~/.Xclients

chmod a+x ~/.Xclients

echo
echo
echo

yum groupremove -y "MATE Desktop"

 yum autoremove -y

yum groupinstall "GNOME DESKTOP" -y

systemctl get-default

systemctl set-default graphical.target

systemctl isolate graphical.target

echo
echo
echo

yum groupremove -y "GNOME Desktop"
yum autoremove -y
yum install remmina remmina-plugins-*

echo "เสร็จแล้วทดสอบได้เลยหากเอ่อเรอติดต่อ"
echo "FB:ยลยุทธ วันชาติ"

