wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl1.0/libssl1.0.0_1.0.2n-1ubuntu5_amd64.deb
sudo dpkg -i libssl1.0.0_1.0.2n-1ubuntu5_amd64.deb

wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh
chmod +x ./dotnet-install.sh &&  ./dotnet-install.sh --channel 5.0

# export DOTNET_ROOT=$HOME/.dotnet
# export PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools

echo "$(curl -fsSL https://raw.githubusercontent.com/nereumelo/setup-wsl/main/props/dotnet)" >> ~/.bashrc
source ~/.bashrc

[[ -n $(dotnet -v) ]] 2> /dev/null && echo -e '\n\033[0;.NET ready to use\033[0m' || echo -e '\n\033[1;33mYou should reboot\033[0m'
