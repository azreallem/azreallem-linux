#!/bin/bash

# modify sources.list of Ubuntu to ustc.edu.cn
#sudo sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list

# apt-get install
sudo apt-get update
sudo apt-get install aptitude zsh vim tmux curl wget net-tools ssh
sudo apt-get install gcc g++ gdb cscope

# backups
install_dir=$PWD
backup_dir=backups/backups_$(date +%y%m%d%H%M%S)
mkdir -p $backup_dir
cp $HOME/.tmux.conf $backup_dir 2>/dev/null
cp $HOME/.zshrc $backup_dir 2>/dev/null
cp $HOME/.vimrc $backup_dir 2>/dev/null
cp -r $HOME/scripts $backup_dir 2>/dev/null

#  copy config & scripts
cp .tmux.conf $HOME
cp -r scripts $HOME

git clone https://github.com/wting/autojump.git $install_dir/autojump
cd autojump && ./install.py
cd $install_dir

# vim config
echo "Please waitting (install vim) ......"
if [ ! -s $HOME/.vim/bundle/Vundle.vim ]; then
	rm -rf $HOME/.vim/bundle/Vundle.vim
fi
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
cp .vimrc $HOME
source $HOME/.vimrc 2>/dev/null
vim +PluginInstall +qall &> /dev/null &
mkdir ~/.vim/doc && cp -r .doc/* ~/.vim/doc/*
echo "Install Finished."

# oh-my-zsh config
echo "Please waitting (install oh-my-zsh) ......"
rm -rf $HOME/.oh-my-zsh
sh -c "$(curl -fsSL https://install.ohmyz.sh/)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
cp .zshrc $HOME
zsh
chsh -s /usr/bin/zsh
source .zshrc
echo "Install Finished."
