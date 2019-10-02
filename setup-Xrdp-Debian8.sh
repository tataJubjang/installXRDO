#!/bin/bash
#------------------------------------------------
# Setup Debian8 with xRDP via MATE-Desktop
#------------------------------------------------
#

echo
/bin/echo -e "\e[1;57m   !-------------------------------------------------------------!\e[0m"
/bin/echo -e "\e[1;40m   !   Standard XRDP Installation Script  - Ver 1.0            !\e[0m"
/bin/echo -e "\e[1;48m   !   https://check-th.tk/SSD       !\e[0m"
/bin/echo -e "\e[1;39m  FB:ยลยุทธ วันชาติ \e [0m"
/bin/echo -e "\e[1;57m   !-------------------------------------------------------------!\e[0m"
echo

apt update -y
apt install -y git devscripts
apt-get build-dep -y libfltk1.3
apt install -y cmake
apt install ufw
chmod 777 ./
mkdir fltk
cd fltk
URL=http://archive.ubuntu.com/ubuntu/pool/universe/f/
wget http://archive.ubuntu.com/ubuntu/pool/universe/f/fltk1.3/fltk1.3_1.3.3.orig.tar.gz
wget http://archive.ubuntu.com/ubuntu/pool/universe/f/fltk1.3/fltk1.3_1.3.3-8.dsc
wget http://archive.ubuntu.com/ubuntu/pool/universe/f/fltk1.3/fltk1.3_1.3.3-8.debian.tar.xz
tar zxvf fltk1.3_1.3.3.orig.tar.gz
cd fltk-1.3.3/
tar xvf ../fltk1.3_1.3.3-8.debian.tar.xz
dpkg-buildpackage -us -uc
dpkg -i *.deb 
apt -f install -y ;  dpkg -i *.deb

echo
/bin/echo -e "\e[1;40m  พักแปปสาสเหนื่อย SERVR Woker !_.* \e[0m"

mkdir tigervnc
cd tigervnc
git clone https://github.com/TigerVNC/tigervnc
 cd /tigervnc
git checkout 044e2b87da7121ef6cbd59e88b101d7d8e282896 \ -b 044e2b87da7121ef6cbd59e88b101d7d8e282896
ln -s contrib/packages/deb/ubuntu-xenial/debian
sed -i -e 's/libjpeg-turbo8/libjpeg62-turbo/g' \
    -e 's/libgnutls30/libgnutls-deb0-28/g' \
    -e 's/libgnutls-dev/libgnutls28-dev/g' debian/control
apt install -y $(grep Build-Depends: debian/control | \ sed -e 's/Build-Depends://g' -e 's/([^\)]*)//g' -e 's/,//g')
rm debian/xorg-source-patches/xserver118-patch.patch 
touch debian/xorg-source-patches/xserver118-patch.patch
chmod a+x debian/rules 
fakeroot debian/rules binary
cd
dpkg -i *.deb 
 apt -f install -y ; dpkg -i *.deb)
vncpasswd
vncserver
apt install -y xrdp 
systemctl enable xrdp 
systemctl restart xrdp
echo
/bin/echo -e "\e[1;40m  เทสอยู่ค่ะ \e[0m"
