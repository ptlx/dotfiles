#!/bin/bash

brew install fish
sudo echo /home/linuxbrew/.linuxbrew/bin/fish >> /etc/shells
sudo chsh -s $(which fish)