sudo useradd  -m -s /bin/bash dhsuser
sudo apt install wget
wget https://raw.githubusercontent.com/ThinkerPal/dhslinuxconfigure/master/Bionic-Beaver/bionic-sources.list
sudo cp ./sources.list /etc/apt/
sudo rm /usr/share/applications/ubuntu-amazon-default.desktop
sudo rm -r /usr/share/ubuntu-web-launchers/amazon-launcher
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
sudo sh -c 'echo "deb https://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
sudo apt-get update
sudo apt -y install net-tools  geany g++ python3-pip php apache2 nginx whois openssh-server git fish vim emacs npm vim  tmux libxss1 libappindicator1 libindicator7 libc++-dev google-chrome-stable
sudo apt -y upgrade
sudo apt -y purge thunderbird* libreoffice* gparted gnome-disk-utility

