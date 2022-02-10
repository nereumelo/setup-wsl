#!usr/bin/bash

# Installing ZSH
sudo apt-get install -y zsh

# Installing OH-MY-ZSH
printf 'y\nexit\n' | source <(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)

# Installing zsh aliases
WIN_HOME="$(wslpath $(cmd.exe /c "<nul set /p=%UserProfile%" 2>/dev/null))"
echo "
alias start=explorer.exe
alias cdw='cd $WIN_HOME'" >> ~/.zshrc

zsh /mnt/c/Users/nereu.oliveira.melo/Desktop/projetos/setup-wsl/scripts/zsh/setup-zsh.sh 