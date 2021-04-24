#!/bin/sh
sudo apt install -y wget curl

wget https://raw.githubusercontent.com/ThinkerPal/dhslinuxconfigure/master/Focal-Fossia/focal-sources.list
sudo cp ./focal-sources.list /etc/apt/sources.list
sudo apt-get update
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -

sudo apt -y install net-tools g++ python3-pip php nginx whois openssh-server git fish vim tmux libxss1 libappindicator1 libindicator7 libc++-dev htop goaccess nodejs bat
sudo apt -y upgrade

curl -L https://get.oh-my.fish | fish