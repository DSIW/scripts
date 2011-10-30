#!/bin/bash

# Installations-Skript
# Autor: DSIW <dsiw@privatdemail.net>
# Blog:  http://blog.dsiw-it.de/
# Datum: 2011-04-05

cd ~/dokumente/skripte/install-os

#######################
# INSTALLATION PACKAGES
#######################

./convertToInstall.sh install-os.sh packages.sort.list
sudo apt-get update && sudo apt-get -y upgrade
sudo apt-get install aptitude
xargs -a "packages.sort.list" sudo aptitude -y install 

# MANUAL INSTALLATION
# truecypt


#######################
# PPA
#######################

./convertToPpa.sh ppa.list paa.sort.list
xargs -a "paa.sort.list" sudo add-apt-repository
sudo apt-get update 

#######################
# CONFIG
#######################

# package: cups-pdf
#mkdir -p ~/pdf
sudo /etc/init.d/cups restart

# OTHER
#./configs/config-files.sh
#./images/config-images.sh

cd -
