#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Variables (customize as needed)
NVM_VERSION="v0.40.1"
OH_MY_ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
LOG_FILE="$HOME/wsl_setup.log"
INSTALL_ZSH=true
INSTALL_NVM=true
INSTALL_DOCKER=true
INSTALL_GOLANG=true

# Trap function to catch errors
error_exit() {
    echo "Error on line $1"
    echo "Check the log file at $LOG_FILE for more details."
    exit 1
}
trap 'error_exit $LINENO' ERR

# Log all output to a file
exec > >(tee -i $LOG_FILE)
exec 2>&1

# Functions
update_system() {
    echo "Updating system packages..."
    sudo apt-get update -qq && sudo apt-get upgrade -qy
}

install_basic_packages() {
    echo "Installing basic packages..."
    sudo apt-get install -qy build-essential curl wget git zip unzip bat software-properties-common ca-certificates gnupg lsb-release

    if command -v batcat &>/dev/null; then
        mkdir -p ~/.local/bin
        ln -s /usr/bin/batcat ~/.local/bin/bat
    fi
}

prompt_user() {
    echo "This script will perform the following installations:"
    echo "1. Zsh and Oh-My-Zsh"
    echo "2. NVM and Node.js"
    echo "3. Golang"
    echo "4. Docker"
    read -p "Do you want to proceed with all installations? (y/n): " proceed
    if [[ "$proceed" != "y" && "$proceed" != "Y" ]]; then
        read -p "Install Zsh and Oh-My-Zsh? (y/n): " zsh_choice
        INSTALL_ZSH=$( [[ "$zsh_choice" == "y" || "$zsh_choice" == "Y" ]] && echo true || echo false )

        read -p "Install NVM and Node.js? (y/n): " nvm_choice
        INSTALL_NVM=$( [[ "$nvm_choice" == "y" || "$nvm_choice" == "Y" ]] && echo true || echo false )

        read -p "Install Golang? (y/n): " golang_choice
        INSTALL_GOLANG=$( [[ "$golang_choice" == "y" || "$golang_choice" == "Y" ]] && echo true || echo false )

        read -p "Install Docker? (y/n): " docker_choice
        INSTALL_DOCKER=$( [[ "$docker_choice" == "y" || "$docker_choice" == "Y" ]] && echo true || echo false )


    fi
}

install_zsh() {
    if $INSTALL_ZSH; then
        if ! command -v zsh &> /dev/null; then
            echo "Installing Zsh..."
            sudo apt-get install -y zsh
        else
            echo "Zsh is already installed."
        fi
    else
        echo "Skipping Zsh installation."
    fi
}

install_oh_my_zsh() {
    if $INSTALL_ZSH; then
        if [ ! -d "$HOME/.oh-my-zsh" ]; then
            echo "Installing Oh-My-Zsh..."
            RUNZSH=no KEEP_ZSHRC=yes CHSH=no sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        else
            echo "Oh-My-Zsh is already installed."
        fi
    fi
}

configure_zsh() {
    if $INSTALL_ZSH; then
        echo "Configuring Zsh..."

        # Set ZSH as the default shell
        echo "Changing default shell to Zsh..."
        if [ "$SHELL" != "$(which zsh)" ]; then
            chsh -s "$(which zsh)"
        else
            echo "Default shell is already Zsh."
        fi

        # Install Powerlevel10k theme
        echo "Configuring Zsh theme..."
        if [ ! -d "${OH_MY_ZSH_CUSTOM}/themes/powerlevel10k" ]; then
            git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${OH_MY_ZSH_CUSTOM}/themes/powerlevel10k"
            curl -LO https://github.com/nereumelo/setup-wsl/raw/refs/heads/develop/.p10k.zsh
            echo '# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.' >> ~/.zshrc && echo '[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh' >> ~/.zshrc
        fi

        # Set ZSH_THEME to "powerlevel10k/powerlevel10k" in .zshrc
        sed -i 's/^ZSH_THEME=".*"/ZSH_THEME="powerlevel10k\/powerlevel10k"/' "$HOME/.zshrc"

        echo "Configuring Zsh plugins..."
        # Install plugins
        [ ! -d "${OH_MY_ZSH_CUSTOM}/plugins/zsh-autosuggestions" ] && \
            git clone https://github.com/zsh-users/zsh-autosuggestions "${OH_MY_ZSH_CUSTOM}/plugins/zsh-autosuggestions"

        [ ! -d "${OH_MY_ZSH_CUSTOM}/plugins/zsh-syntax-highlighting" ] && \
            git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${OH_MY_ZSH_CUSTOM}/plugins/zsh-syntax-highlighting"

        [ ! -d "${OH_MY_ZSH_CUSTOM}/plugins/k" ] && \
            git clone https://github.com/supercrabtree/k "${OH_MY_ZSH_CUSTOM}/plugins/k"

        [ ! -d "${OH_MY_ZSH_CUSTOM}/plugins/zsh-bat" ] && \
            git clone https://github.com/fdellwing/zsh-bat.git "${OH_MY_ZSH_CUSTOM}/plugins/zsh-bat"

        # Enable plugins in .zshrc
        sed -i 's/^plugins=(.*)/plugins=(sudo git nvm z k node zsh-bat colored-man-pages zsh-autosuggestions zsh-syntax-highlighting)/' "$HOME/.zshrc"
        echo 'export PATH="$PATH:$HOME/.local/bin"' >> ~/.zshrc
        echo '# Start the ssh agent' >> ~/.zshrc && echo 'eval $(ssh-agent > /dev/null)' >> ~/.zshrc

    fi
}

install_nvm() {
    if $INSTALL_NVM; then
        if [ ! -d "$HOME/.nvm" ]; then
            echo "Installing NVM..."
            curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh | bash
        else
            echo "NVM is already installed."
        fi

        # Load NVM and install Node.js LTS
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
        nvm install --lts
    else
        echo "Skipping NVM installation."
    fi
}

install_golang() {
    if [ "$INSTALL_GOLANG" = true ]; then
        if command -v go &>/dev/null; then
            echo "Golang is already installed."
        else
            echo "Installing Golang..."

            # Remove any existing Go installation
            sudo rm -rf /usr/local/go* && sudo rm -rf /usr/local/go

            # Update package list
            echo "Updating package list..."
            sudo apt-get update

            # Install golang-go package
            echo "Installing golang-go package..."
            sudo apt-get install -y golang-go

            # Verify installation
            if command -v go &>/dev/null; then
                echo "Golang installed successfully."
                # Optionally, set up Go environment variables
                echo "Setting up Go environment variables..."
                echo "export PATH=\$PATH:/usr/local/go/bin" >> ~/.profile
                echo "export GOPATH=\$HOME/go" >> ~/.profile
                echo "export PATH=\$PATH:\$GOPATH/bin" >> ~/.profile
                source ~/.profile
            else
                echo "Golang installation failed."
                exit 1
            fi
        fi
    else
        echo "Skipping Golang installation."
    fi
}

install_docker() {
    if $INSTALL_DOCKER; then
        echo "Installing Docker..."
        # Remove old versions
        sudo apt-get remove -y docker docker-engine docker.io containerd runc || true

        # Use official Docker installation script
        curl -fsSL https://get.docker.com -o get-docker.sh
        sed -i 's/icrosoft\* ) true/icrosoft* ) false/g' get-docker.sh
        sudo sh get-docker.sh

        # Add the current user to the docker group
        if groups "$USER" | grep &>/dev/null '\bdocker\b'; then
            echo "User $USER is already in the docker group."
        else
            sudo usermod -aG docker "$USER"
            echo "Added $USER to the docker group."
        fi
    else
        echo "Skipping Docker installation."
    fi
}

enable_systemd_in_wsl() {
    echo "Enabling systemd in WSL..."
    sudo bash -c 'cat <<EOF > /etc/wsl.conf
[boot]
systemd=true
EOF'
}

main() {
    prompt_user
    update_system
    install_basic_packages
    install_zsh
    install_oh_my_zsh
    configure_zsh
    install_nvm
    install_golang
    install_docker
    enable_systemd_in_wsl

    echo "Installation complete."
    echo "Please restart WSL by running 'wsl --shutdown' in Windows Command Prompt or PowerShell, then restart your WSL terminal."
}

main "$@"
