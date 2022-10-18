#!/bin/bash

dir=backups_$(date +%y%m%d%H%M%S)
mkdir -p $dir
cp $HOME/.tmux.conf $dir 2>/dev/null
cp $HOME/.zshrc $dir 2>/dev/null
cp $HOME/.vimrc $dir 2>/dev/null
cp $HOME/scripts $dir 2>/dev/null

cp -i .tmux.conf $HOME
cp -i .zshrc $HOME
cp -i .vimrc $HOME
cp -ir scripts $HOME

source $HOME/.zshrc
source $HOME/.vimrc
