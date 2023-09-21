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
    echo "You selected the following items:"
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

print() {
  local sentence="$1"
  local color="${colors["${2:-reset}"]}"
  local reset="${colors["reset"]}"
  echo -e "$color$sentence$reset"
}

install_vim() {
  print "Installing VIM..." "red"
}

install_git() {
  print "Installing GIT..." "green"
}

install_nvm() {
  print "Installing NVM..." "yellow"
}

install_docker() {
  print "Installing Docker..." "blue"
}

install_zsh() {
  print "Installing ZSH..." "pink"
}

show_installation_dialog
