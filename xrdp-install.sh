################################################################
# Script_Name : xrdp-install.sh
# Description : Perform an automated custom installation of xrdp
# on ubuntu 16.04 or later when systemd is used
# Date : April 2019
# written by : Griffon
# Web Site :Check-Th
# Version : 1.7
#
# Disclaimer : Script provided AS IS. Use it at your own risk....
#
##################################################################
 
##################################################################
#Step 1 - Install prereqs for compilation
##################################################################
 
echo "Installing prereqs for compiling xrdp..."
echo "----------------------------------------"

 apt-get -y install libx11-dev libxfixes-dev libssl-dev libpam0g-dev libtool libjpeg-dev flex bison gettext autoconf libxml-parser-perl libfuse-dev xsltproc libxrandr-dev python-libxml2 nasm xserver-xorg-dev fuse

#Install git 
echo "Installing git software..."
 apt-get -y install git 
 
 
##################################################################
#Step 2 - Install the desktop of you choice
################################################################## 
 
#Here, we are installing Mate Desktop environment 

echo "Installing alternate desktop to be used with xrdp..."
echo "----------------------------------------------------"
apt-get -y update
 apt-get -y install mate-core mate-desktop-environment mate-notification-daemon --force-yes
echo "Desktop Install Done"
 

##################################################################
#Step 3 - Obtain xrdp packages and xorgxrdp packages
################################################################## 
 
#-Go to your Download folder
echo "Moving to the ~/Download folders..."
echo "-----------------------------------"
cd ~/Downloads

#Download the xrdp latest files
echo "Ready to start the download of xrdp package"
echo "-------------------------------------------"
git clone https://github.com/neutrinolabs/xrdp.git

#move to xorgxrdp folder and download needed packages
cd xrdp/
git clone https://github.com/neutrinolabs/xorgxrdp.git
 
##################################################################
#Step 4 - compiling xorgxrdp packages
################################################################## 
cd xorgxrdp 
 ./bootstrap 
./configure 
make
 make install
cd ..

##################################################################
#Step 5 - Fallback scenario - using x11vnc sesman
################################################################## 
 
#Install the X11VNC
echo "Installing X11VNC..."
echo "----------------------------------------" apt-get -y install x11vnc

#Add/Remove Ubuntu xrdp packages (used to create startup service)

echo "Add/Remove xrdp packages..."
echo "---------------------------"
 apt-get -y install xrdp
 apt-get -y remove xrdp
 
##################################################################
#Step 6 - compiling xrdp packages
################################################################## 
 
#Compile and make xrdp

echo "Installing and compiling xrdp..."
echo "--------------------------------"

# needed because libtool not found in Ubuntu 15.04 and later
# Need to use libtoolize

 sed -i.bak 's/which libtool/which libtoolize/g' bootstrap

 ./bootstrap
 ./configure --enable-fuse --enable-jpeg
  make
  make install

#Final Post Setup configuration
echo "---------------------------"
echo "Post Setup Configuration..."
echo "---------------------------"

echo "Set Default xVnc-Sesman"
echo "-----------------------"

  sed -i.bak '/\[xrdp1\]/i [xrdp0] \nname=SessionManager-Griffon \nlib=libxup.so \nusername=ask \npassword=ask \nip=127.0.0.1 \nport=-1 \nxserverbpp=24 \ncode=20 \n' /etc/xrdp/xrdp.ini

echo "Symbolic links for xrdp"
echo "-----------------------"

  mv /etc/xrdp/startwm.sh /etc/xrdp/startwm.sh.backup
  ln -s /etc/X11/Xsession /etc/xrdp/startwm.sh
  mkdir /usr/share/doc/xrdp
  cp /etc/xrdp/rsakeys.ini /usr/share/doc/xrdp/rsakeys.ini

## Needed in order to have systemd working properly with xrdp
echo "-----------------------"
echo "Modify xrdp.service "
echo "-----------------------"

#Comment the EnvironmentFile - Ubuntu does not have sysconfig folder
  sed -i.bak 's/EnvironmentFile/#EnvironmentFile/g' /lib/systemd/system/xrdp.service

#Replace /sbin/xrdp with /sbin/local/xrdp as this is the correct location
  sed -i.bak 's/sbin\/xrdp/local\/sbin\/xrdp/g' /lib/systemd/system/xrdp.service
echo "-----------------------"
echo "Modify xrdp-sesman.service "
echo "-----------------------"

#Comment the EnvironmentFile - Ubuntu does not have sysconfig folder
  sed -i.bak 's/EnvironmentFile/#EnvironmentFile/g' /lib/systemd/system/xrdp-sesman.service

#Replace /sbin/xrdp with /sbin/local/xrdp as this is the correct location
  sed -i.bak 's/sbin\/xrdp/local\/sbin\/xrdp/g' /lib/systemd/system/xrdp-sesman.service

#Issue systemctl command to reflect change and enable the service
  systemctl daemon-reload
  systemctl enable xrdp.service

# Set keyboard layout in xrdp sessions
cd /etc/xrdp 
test=$(setxkbmap -query | awk -F":" '/layout/ {print $2}') 
echo "your current keyboard layout is.." $test
setxkbmap -layout $test
  cp /etc/xrdp/km-0409.ini /etc/xrdp/km-0409.ini.bak
  xrdp-genkeymap km-0409.ini

## Try configuring multiple users system 
  sed -i.bak '/set -e/a mate-session' /etc/xrdp/startwm.sh
 
echo "Restart the Computer"
echo "-------------เรียบร้อยครับ-------------"
reboot 