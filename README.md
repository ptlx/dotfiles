# dotfiles

## Temporary specification

This includes **installers directory** and **other directories**.
Installers directory consists of each installer file.
Others consist of init.sh, link.sh and other configuration files because
main installer (`dotfiles/installer.sh`) find init.sh and link.sh in every 
directory (installers file is excluded.) and run it.

### why

`installer.sh` script find files and directories using for. script move to every 
folder except **installers** and execute `bash link.sh` and `bash init.sh`


## Installation

```shell
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ptlx/dotfiles/master/installer.sh)"
```

