sudo useradd dhsuser
sudo cp ./sources.list /etc/apt/
sudo apt update
sudo apt -y purge libreoffice* gparted
sudo rm /usr/share/applications/ubuntu-amazon-default.desktop
sudo rm -r /usr/share/ubuntu-web-launchers/amazon-launcher

sudo apt -y install net-tools  geany g++ python3-pip php apache2 fish nginx openssh-server git vim emacs npm vim wget tmux libxss1 libappindicator1 libindicator7 libc++-dev libstdc++-7dev
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
sudo sh -c 'echo "deb https://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
sudo apt-get update
sudo apt-get -y install google-chrome-stable
sudo apt -y upgrade
