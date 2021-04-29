#!/bin/sh

sudo apt install -y wget curl

wget https://raw.githubusercontent.com/ThinkerPal/dhslinuxconfigure/master/Focal-Fossia/focal-sources.list
sudo cp ./focal-sources.list /etc/apt/sources.list
sudo rm /usr/share/applications/ubuntu-amazon-default.desktop
sudo rm -r /usr/share/ubuntu-web-launchers/amazon-launcher


wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
sudo sh -c 'echo "deb https://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
sudo apt-get update

curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -

sudo apt -y install net-tools g++ python3-pip php nginx whois openssh-server git fish vim tmux libxss1 libappindicator1 libindicator7 libc++-dev google-chrome-stable code htop goaccess vlc nodejs bat
sudo apt -y upgrade
sudo apt -y purge thunderbird* 

curl -L https://get.oh-my.fish | fish