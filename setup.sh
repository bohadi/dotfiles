#!/bin/bash

dir=~/dotfiles                    
files="bashrc vimrc zshrc inputrc haskeline ghci gitconfig crawlrc tmux.conf"

cd $dir
for file in $files; do
    ln -s $dir/$file ~/.$file
done

cp -rf ~/dotfiles/xfce4 ~/.config/
cp -rf ~/dotfiles/fcitx ~/.config/
