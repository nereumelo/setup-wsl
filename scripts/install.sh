
makeDecision () {
  while true; do
    read -p "$1" yn
    case $yn in
        [Yy]* ) 
          if [[ -n "$3" ]]
            then 
              source <($2)
            else
              $2
          fi
          break;;
        [Nn]* ) 
          break;;
    esac
  done
}


echo -e "\n>>> Initial setup"
source <(curl -fsSL https://raw.githubusercontent.com/nereumelo/setup-wsl/main/scripts/setup.sh)

application=vim
echo -e "\n>>> $application"
makeDecision "Do you wish to set $application as your default text editor? [Y/n] " "sudo update-alternatives --set editor /usr/bin/vim.basic"

application=git
echo -e "\n>>> $application"
makeDecision "Do you wish to setup $application? [Y/n] " "curl -fsSL https://raw.githubusercontent.com/nereumelo/setup-wsl/main/scripts/bash/install-$application.sh" "source"

application=docker
echo -e "\n>>> $application"
makeDecision "Do you wish to setup $application? [Y/n] " "curl -fsSL https://raw.githubusercontent.com/nereumelo/setup-wsl/main/scripts/bash/install-$application.sh" "source"

application=nvm
echo -e "\n>>> $application"
makeDecision "Do you wish to setup $application? [Y/n] " "curl -fsSL https://raw.githubusercontent.com/nereumelo/setup-wsl/main/scripts/bash/install-$application.sh" "source"

application=zsh
echo -e "\n>>> $application"
makeDecision "Do you wish to setup $application? [Y/n] " "curl -fsSL https://raw.githubusercontent.com/nereumelo/setup-wsl/main/scripts/zsh/install-$application.sh" "source"

if [ -f /var/run/reboot-required ]; 
  then
    echo -e "\n\033[1;33mYou should reboot\033[0m"
fi
