#!/bin/sh

curl -fLo ~/.local/share/nvim/site/pack/jetpack/opt/vim-jetpack/plugin/jetpack.vim --create-dirs https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim
ln -snfv ~/dotfiles/nvim/init.lua ~/.config/nvim/init.lua
