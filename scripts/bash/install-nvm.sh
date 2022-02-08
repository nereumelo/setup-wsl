cd

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

source ~/.bashrc

# Checking if NVM is ready to use
[[ -n $(nvm -v) ]] 2> /dev/null && echo -e '\n\033[0;32mNVM ready to use\033[0m' || echo -e '\n\033[1;33mYou should reboot\033[0m'