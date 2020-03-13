#!/usr/bin/env bash

if [[ "$(whoami)" != "root" ]]
then
    echo
    echo "*** MUST BE root TO RUN THIS SCRIPT ***"
    echo
    exit 1
fi

yum -y install \
    make compat-openssl10 freeglut mesa-libGLU python2 pygtk2 libcanberra-gtk2

ln -s /usr/bin/python2 /usr/bin/python

wget https://download.foldingathome.org/releases/public/release/fahclient/centos-6.7-64bit/v7.5/fahclient-7.5.1-1.x86_64.rpm
wget https://download.foldingathome.org/releases/public/release/fahcontrol/centos-6.7-64bit/v7.5/fahcontrol-7.5.1-1.noarch.rpm
wget https://download.foldingathome.org/releases/public/release/fahviewer/centos-6.7-64bit/v7.5/fahviewer-7.5.1-1.x86_64.rpm

rpm -i --nodeps fahclient-7.5.1-1.x86_64.rpm
rpm -i --nodeps fahviewer-7.5.1-1.x86_64.rpm
rpm -i --nodeps fahcontrol-7.5.1-1.noarch.rpm

# The FAHClient fails on startup.  Kill it and then run it manually.
pkill FAHClient

sleep 5

sudo -u $SUDO_USER mkdir -p /home/$SUDO_USER/fah
cd /home/$SUDO_USER/fah
sudo -u $SUDO_USER FAHClient &
sudo -u $SUDO_USER FAHControl &

echo
echo "************************************************************************"
echo 
echo When prompted for an identity, you can choose to configure one or just
echo fold anonymously. In your FAHControl window, set your Folding Power and
echo then press the Fold button. Click the Viewer button to watch the
echo progression of your work.
echo
echo "************************************************************************"
echo
