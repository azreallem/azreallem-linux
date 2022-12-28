#!/bin/bash

# modify sources.list of Ubuntu to ustc.edu.cn
if [ ! -z $(uname -r | grep -i "wsl") ] ; then
	sudo sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
fi

# apt-get install
sudo apt-get update
sudo apt-get install aptitude zsh vim tmux autojump mate-terminal
sudo apt-get install gcc g++ gdb python

# scripts & backups
dir=backups_$(date +%y%m%d%H%M%S)
mkdir -p $dir
cp $HOME/.tmux.conf $dir 2>/dev/null
cp $HOME/.zshrc $dir 2>/dev/null
cp $HOME/.vimrc $dir 2>/dev/null
cp -r $HOME/scripts $dir 2>/dev/null
cp -r scripts $HOME

# tmux configs
cp .tmux.conf $HOME

# vim config
cp .vimrc $HOME
if [ ! -e $HOME/.vim/bundle/Vundle.vim ]
then
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi
source $HOME/.vimrc 2>/dev/null
echo "=---------- vim install --------------="
echo "Please waitting ......"
vim +PluginInstall +qall &> /dev/null &
echo "=---------- vim finished --------------="

# zsh config
echo "Please waitting ......"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" &> /dev/null
echo "Install Finished."
if [ ! -e $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]
then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
fi
cp .zshrc $HOME
source $HOME/.zshrc 2>/dev/null
zsh
