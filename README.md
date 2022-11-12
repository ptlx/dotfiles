# dotfiles

## Temporary specification

This includes **installers directory** and **other directories**.
Installers directory consists of each installer file.
Others consist of init.sh, link.sh and other configuration files because
main installer (`dotfiles/installer.sh`) find init.sh and link.sh in every 
folder (installers file is excluded.) and run it.

## Installation

```shell
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ptlx/dotfiles/master/installer.sh)"
```

