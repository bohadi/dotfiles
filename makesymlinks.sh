#!/bin/bash

dir=~/dotfiles                    
files="vimrc zshrc inputrc haskeline gitconfig crawlrc tmux.conf Xresources xinitrc xmonad"

cd $dir
for file in $files; do
    ln -s $dir/$file ~/.$file
done
