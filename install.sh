#!/bin/bash

dir=backups_$(date +%y%m%d)
mkdir -p $dir
cp $HOME/.tmux.conf $dir 2>/dev/null
cp $HOME/.zshrc $dir 2>/dev/null
cp $HOME/.vimrc $dir 2>/dev/null
cp $HOME/script $dir 2>/dev/null

cp .tmux.conf $HOME
cp .zshrc $HOME
cp .vimrc $HOME
cp -r scripts $HOME

source $HOME/.zshrc
source $HOME/.vimrc
