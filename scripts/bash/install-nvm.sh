cd

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
curl -L https://raw.githubusercontent.com/nereumelo/setup-wsl/main/props/nvm -o nvm_props
cat nvm_props >> ~/.bashrc
rm nvm_props

source ~/.bashrc

nvm -v