#!/bin/bash
sudo apt install -y curl wget apt-utils
wget https://raw.githubusercontent.com/ThinkerPal/dhslinuxconfigure/master/jetbot-bionic/sources.list
sudo cp ./sources.list /etc/apt/
sudo apt-get update
sudo apt -y install net-tools g++ python3-pip php nginx whois openssh-server firefox git fish vim emacs npm tmux libxss1 libappindicator1 libindicator7 libc++-dev cmake make zip htop python3
sudo apt -y upgrade

# Installs TF and its stuff
sudo apt-get install -y libhdf5-serial-dev hdf5-tools libhdf5-dev zlib1g-dev zip libjpeg8-dev
sudo -H python3 -m pip install numpy grpcio absl-py py-cpuinfo psutil portpicker six mock requests gast h5py astor termcolor protobuf keras-applications keras-preprocessing wrapt google-pasta setuptools testresources
sudo -H python3 -m pip install tensorflow_gpu-1.13.1+nv19.3-cp36-cp36m-linux_aarch64.whl
sudo -H python3 -m pip install torch-1.0.0a0+18eef1d-cp36-cp36m-linux_aarch64.whl
sudo -H python3 -m pip install torchvision

# Install Jupyter
curl -fsSL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt-get install -y nodejs npm
sudo -H python3 -m pip install jupyter jupyterlab
sudo jupyter labextension install @jupyter-widgets/jupyterlab-manager
# sudo jupyter labextension install @jupyterlab/statusbar
jupyter lab --generate-config

unzip jetbot.zip
cd jetbot
sudo python3 setup.py install
cd utils
python3 ./create_stats_service.py
sudo mv jetbot_stats.service /etc/systemd/system/jetbot_stats.service
sudo systemctl enable jetbot_stats && sudo systemctl start jetbot_stats
python3 create_jupyter_service.py
sudo mv jetbot_jupyter.service /etc/systemd/system/jetbot_jupyter.service
sudo systemctl enable jetbot_jupyter && sudo systemctl start jetbot_jupyter

mkdir ~/.torch
mkdir ~/.torch/models
cp *.pth ~/.torch/models/

sudo -H python3 -m pip install jetson-stats
sudo apt autoremove -y
