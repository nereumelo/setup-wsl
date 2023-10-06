#!/bin/bash

# Define an associative array to represent the object
declare -A colors

# Add properties (colors) to the object
colors["red"]="\x1b[31m"
colors["green"]="\x1b[32m"
colors["yellow"]="\x1b[33m"
colors["blue"]="\x1b[34m"
colors["pink"]="\x1b[35m"
colors["reset"]="\x1b[0m" # Reset text color

print() {
  local sentence="$1"
  local color="${colors["${2:-reset}"]}"
  local reset="${colors["reset"]}"
  echo -e "$color$sentence$reset"
}

install_vim() {
  print "Installing VIM..." "red"
  sudo update-alternatives --set editor /usr/bin/vim.basic
}

install_git() {
  print "Installing GIT..." "green"
  bash <(curl -fsSL https://raw.githubusercontent.com/nereumelo/setup-wsl/main/scripts/bash/install-git.sh)
}

install_nvm() {
  print "Installing NVM..." "yellow"
  bash <(curl -fsSL https://raw.githubusercontent.com/nereumelo/setup-wsl/main/scripts/bash/install-nvm.sh)
}

install_docker() {
  print "Installing Docker..." "blue"
  bash <(curl -fsSL https://raw.githubusercontent.com/nereumelo/setup-wsl/main/scripts/bash/install-docker.sh)
}

install_zsh() {
  print "Installing ZSH..." "pink"
  bash <(curl -fsSL https://raw.githubusercontent.com/nereumelo/setup-wsl/main/scripts/zsh/install-zsh.sh)
}

show_installation_dialog() {
  # Create a checklist using dialog
  local choices=$(dialog --stdout --title "Checklist" \
    --ok-label "Confirm" \
    --checklist 'Select items to install' 0 50 0 \
      "VIM" "Default editor" "OFF" \
      "GIT" "Source version control" "OFF" \
      "NVM" "Node version control" "OFF" \
      "DOCKER" "Container management" "OFF" \
      "ZSH" "Improved shell" "OFF")

  # Check the exit status to determine user input
  clear
  if [ ${#choices} -gt 0 ]; then
    for choice in $choices; do
      case $choice in
        "VIM") install_vim;;
        "GIT") install_git;;
        "NVM") install_nvm;;
        "DOCKER") install_docker;;
        "ZSH") install_zsh;;
      esac
    done
  fi
}

setup() {
  print "Initial setup..."
  bash <(curl -fsSL https://raw.githubusercontent.com/nereumelo/setup-wsl/main/scripts/setup.sh)
  sudo apt-get install dialog
}

setup
show_installation_dialog
