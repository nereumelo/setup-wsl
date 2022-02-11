#!usr/bin/bash

# Installing ZSH
sudo apt-get install -y zsh
chsh -s $(which zsh)

# Installing OH-MY-ZSH
printf 'y\nexit\n' | source <(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)

# Installing zsh aliases
WIN_HOME="$(wslpath $(cmd.exe /c "<nul set /p=%UserProfile%" 2>/dev/null))"
echo "
alias start=explorer.exe
alias cdw='cd $WIN_HOME'" >> ~/.zshrc

sh -c "$(curl -fsSL https://raw.githubusercontent.com/nereumelo/setup-wsl/main/scripts/zsh/setup-zsh.sh)"
