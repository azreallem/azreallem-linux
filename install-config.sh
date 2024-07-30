#!/bin/bash

dir=backups/backups_$(date +%y%m%d%H%M%S)
mkdir -p $dir
cp $HOME/.tmux.conf $dir 2>/dev/null
cp $HOME/.zshrc $dir 2>/dev/null
cp $HOME/.vimrc $dir 2>/dev/null
cp -r $HOME/scripts $dir 2>/dev/null

cp .tmux.conf $HOME
cp .zshrc $HOME
cp .vimrc $HOME
cp -r scripts $HOME

source $HOME/.zshrc 2>/dev/null
source $HOME/.vimrc 2>/dev/null
