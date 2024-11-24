# Setup WSL

1. Open PowerShell as an administrator

2. Install WSL

   ```bash
   wsl --install
   ```

   > If you encounter issues running WSL2, refer to the [troubleshooting](https://github.com/nereumelo/setup-wsl#troubleshooting) section.

   <br>
   2.1. List the installed Linux distributions

   ```bash
   wsl -l -v
   ```

   > The WSL version and the running status of each distribution are also listed

   <br>
   2.2. List the available Linux distributions for installation

   ```bash
   wsl -l -o
   ```

   <br>
   2.3. Install a distribution

   ```bash
   wsl --install -d <DISTRO-NAME>
   ```

   <br>
   2.4. Run the installed distribution

   ```bash
   wsl -d <DISTRO-NAME>
   ```

   <br>

3. Configure the installed distribution

   ```bash
   bash <(curl -sL https://github.com/nereumelo/setup-wsl/raw/refs/heads/develop/install.sh)
   ```

## Troubleshooting

### If you encounter issues running WSL version 2

- Download the [Linux kernel update package for WSL](https://learn.microsoft.com/en-us/windows/wsl/install-manual#step-4---download-the-linux-kernel-update-package)

- Set WSL 2 as your default version

  ```bash
  wsl --set-default-version 2
  ```
