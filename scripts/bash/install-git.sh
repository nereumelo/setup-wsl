
getSaveMode () {
  while true; do
      read -p "Do you wish to save your credentials globally? [Y/n] " yn
      case $yn in
          [Yy]* ) saveMode="global"; break;;
          [Nn]* ) saveMode="local"; break;;
      esac
    done
}


sudo add-apt-repository ppa:git-core/ppa
sudo apt-get update -y
# sudo apt-get install -y curl git
sudo apt-get install -y git

git config --global init.defaultBranch main

echo -e "Enter your git credentials\n"
read -p "Username: " username
read -p "Email: " email

echo

if [[ -n "$username" && -n "$email"  ]]; 
  then
    getSaveMode
    
    git config --$saveMode user.name $username
    git config --$saveMode user.email $email
    
    if [[ "$saveMode" == "global" ]];   
      then
        echo -e "\033[0;32mSave globally\033[0m"
      else
        echo -e "\033[0;32mSave locally\033[0m"
    fi
  else 
    echo -e "\033[0;31mUnprocessable credentials \033[0m"
fi
