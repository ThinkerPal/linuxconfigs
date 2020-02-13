#!/bin/sh

sudo useradd -m -s /bin/bash dhsuser
sudo apt install wget
wget https://raw.githubusercontent.com/ThinkerPal/dhslinuxconfigure/master/sources.list
sudo cp ./sources.list /etc/apt/

sudo rm /usr/share/applications/ubuntu-amazon-default.desktop
sudo rm -r /usr/share/ubuntu-web-launchers/amazon-launcher

wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
sudo sh -c 'echo "deb https://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'

curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

sudo apt-get update
sudo apt -y install net-tools  geany g++ python3-pip php7.2 apache2 nginx whois openssh-server git fish vim emacs npm vim  tmux libxss1 libappindicator1 libindicator7 libc++-dev google-chrome-stable npx nodejs apt-transport-https code

sudo snap install telegram-desktop

