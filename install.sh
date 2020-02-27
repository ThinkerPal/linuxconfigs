#!/bin/sh

sudo apt install -y wget curl
wget https://raw.githubusercontent.com/ThinkerPal/dhslinuxconfigure/master/sources.list
sudo cp ./sources.list /etc/apt/

wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
sudo sh -c 'echo "deb https://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'

curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

sudo apt-get update
sudo apt -y install net-tools gparted lxde geany g++ python3-pip php7.2 apache2 nginx whois openssh-server git fish vim emacs npm tmux libxss1 libappindicator1 libindicator7 libc++-dev google-chrome-stable  nodejs apt-transport-https code htop goaccess vlc

wget http://192.168.1.8/tsetup.1.9.14.tar.xz -O tele.tar.xz
tar -xvf tele.tar.xz
mv Telegram/ ~/Desktop/

wget https://raw.githubusercontent.com/ThinkerPal/dhslinuxconfigure/master/sync-project.sh -O sync-project.sh
mv sync-project.sh /sync-project.sh

sudo touch /etc/cron.d/gitrefresh
*/3 * * * * /sync-project.sh >> /etc/cron.d/gitrefresh

sudo apt-get upgrade -y

rm tele.tar.xz
rm install.sh
