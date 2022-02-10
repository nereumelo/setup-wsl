#!/usr/bin/zsh

# Installing spaceship theme
ZSH_THEMES_PATH="/home/nereu/.oh-my-zsh/themes"
sudo git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_THEMES_PATH/spaceship-prompt"
sudo ln -s "$ZSH_THEMES_PATH/spaceship-prompt/spaceship.zsh-theme" "$ZSH_THEMES_PATH/spaceship.zsh-theme"

sed -i 's/ZSH_THEME=.*/ZSH_THEME=spaceship/' ~/.zshrc
echo "$(curl -fsSL https://raw.githubusercontent.com/nereumelo/setup-wsl/main/props/zshrc_spaceship)" >> ~/.zshrc
source ~/.zshrc

# Installing zinit plugin
printf 'y\n' | sh -c "$(curl -fsSL https://git.io/zinit-install)"
echo "$(curl -fsSL https://raw.githubusercontent.com/nereumelo/setup-wsl/main/props/zinit)" >> ~/.zshrc
source ~/.zshrc

if [ -n $(docker ps) >/dev/null 2>&1 ]; 
  then
    echo "$(curl -fsSL https://raw.githubusercontent.com/nereumelo/setup-wsl/main/props/docker)" >> ~/.zshrc
    source ~/.zshrc
fi

if [ -n $(nvm -v) ]; 
  then
    echo "$(curl -fsSL https://raw.githubusercontent.com/nereumelo/setup-wsl/main/props/nvm)" >> ~/.zshrc
    source ~/.zshrc
fi
