#!/bin/bash
sudo sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list

sudo apt-get update
sudo apt-get install aptitude zsh vim tmux autojump gcc g++ python3 gdb


if [ ! -e $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]
then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
fi

if [ ! -e $HOME/.vim/bundle/Vundle.vim ]
then
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

echo "=---------- vim install --------------="
echo "Please waitting ......"
vim +PluginInstall +qall &> /dev/null &
echo "=---------- vim finished --------------="

echo "Please waitting ......"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" &> /dev/null
echo "Install Finished."
