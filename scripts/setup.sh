
sudo add-apt-repository ppa:git-core/ppa

sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y dist-upgrade
sudo apt-get -y autoremove
sudo apt-get -y autoclean

if [ -f /var/run/reboot-required ]; 
  then
    echo -e "\n\033[1;33mYou should reboot\033[0m"
fi
