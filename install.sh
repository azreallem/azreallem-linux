#!/bin/bash

#sudo apt-get install zsh
#sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
#sudo apt-get install tmux
#asudo apt-get install vim

dir=backups_$(date +%y%m%d%H%M)
mkdir -p $dir
cp $HOME/script $dir 2>/dev/null
cp $HOME/.tmux.conf $dir 2>/dev/null
cp $HOME/.zshrc $dir 2>/dev/null
cp $HOME/.vimrc $dir 2>/dev/null

cp .tmux.conf $HOME
cp .zshrc $HOME
cp .vimrc $HOME
cp -r scripts $HOME
