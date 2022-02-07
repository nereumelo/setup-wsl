# Setup WSL

1. Instalar a versão atual do terminal [PowerShell](https://github.com/PowerShell/PowerShell/#get-powershell)
2. Abrir o PowerShell como administrador

3. Instalar o WSL

   ```bash
   wsl --install
   ```

   > **Nota:** Caso encontre problemas para executar o WSL2, consulte a sessão de [troubleshooting](https://github.com/nereumelo/setup-wsl#troubleshooting)

   <br>
   3.1. Listar as distribuições Linux instaladas

   ```bash
   wsl -l -v
   ```

   > **Nota:** Também são listados a versão do WSL e o status de execução de cada distribuição

   <br>
   3.2. Listar as distribuições Linux disponíveis para instalação

   ```bash
   wsl -l -o
   ```

   <br>
   3.3. Instalar uma distribuição

   ```bash
   wsl --install -d <DISTRO-NAME>
   ```

   <br>
   3.4. Executar uma distribuição instalada

   ```bash
   wsl -d <DISTRO-NAME>
   ```

   <br>

4. Atualizar a distribuição

   4.1. Executar o comando abaixo no terminal da distribuição instalada

   ```bash
   sudo sh -c 'apt-get -y update && apt-get -y upgrade && apt-get -y dist-upgrade && apt-get -y autoremove && apt-get -y autoclean && if [ -f /var/run/reboot-required ]; then echo; echo "\033[1;33mYou should reboot\033[0m"; fi'
   ```

   <br>

   > **Nota:** Caso apareça a mensagem **'You should reboot'**, abra o terminal PowerShell e desligue as distribuições em execução. Após isso, basta abrir novamente o terminal da distribuição e prosseguir com o setup.

   ```bash
   wsl --shutdown
   ```

   <br>
   4.2. Instalar o Docker Engine

   ```bash
   sh -c "$(curl -fsSL https://raw.githubusercontent.com/nereumelo/setup-wsl/main/scripts/bash/install-docker.sh)"
   ```

   <br>
   4.3. (Opcional) Instalar o Node Version Manager (NVM)

   ```bash
   sh -c "$(curl -fsSL https://raw.githubusercontent.com/nereumelo/setup-wsl/main/scripts/bash/install-nvm.sh)"
   ```

   <br>

# Troubleshooting

### Caso encontre problemas para executar a versão 2 do WSL

- Baixar o [pacote de atualização do kernel Linux para o WSL](https://docs.microsoft.com/pt-br/windows/wsl/install-manual#step-4---download-the-linux-kernel-update-package)

- Definir o WSL 2 como a sua versão padrão
  ```bash
  wsl --set-default-version 2
  ```
