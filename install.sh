#!/bin/bash
current_directory=`pwd`
rm ~/.vimrc

rm -rf ~/.vim

ln -s $current_directory ~/.vim
ln -s $current_directory/vimrc ~/.vimrc
