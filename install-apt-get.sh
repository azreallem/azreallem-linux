#!/bin/bash

# modify sources.list of Ubuntu to ustc.edu.cn
sudo sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list

# apt-get install
sudo apt-get update
sudo apt-get install aptitude zsh vim tmux autojump mate-terminal
sudo apt-get install gcc g++ gdb 

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
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
source $HOME/.vimrc 2>/dev/null
echo "=---------- vim install --------------="
echo "Please waitting ......"
vim +PluginInstall +qall &> /dev/null &
echo "=---------- vim finished --------------="

# oh-my-zsh config
echo "Please waitting (install oh-my-zsh) ......"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
echo "Install Finished."
cp .zshrc $HOME
source $HOME/.zshrc 2>/dev/null
zsh
