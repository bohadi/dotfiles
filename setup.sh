#!/bin/bash

dir=~/dotfiles                    
files="bashrc vimrc zshrc inputrc haskeline ghci gitconfig crawlrc tmux.conf"

cd $dir
for file in $files; do
    ln -s $dir/$file ~/.$file
done

