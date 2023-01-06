#!/bin/bash

# modify sources.list of Ubuntu to ustc.edu.cn
sudo sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list

# apt-get install
sudo apt-get update
sudo apt-get install aptitude zsh vim tmux mate-terminal
sudo apt-get install gcc g++ gdb 

# backups
dir=backups_$(date +%y%m%d%H%M%S)
mkdir -p $dir
cp $HOME/.tmux.conf $dir 2>/dev/null
cp $HOME/.zshrc $dir 2>/dev/null
cp $HOME/.vimrc $dir 2>/dev/null
cp -r $HOME/scripts $dir 2>/dev/null

#  copy config & scripts
cp .tmux.conf $HOME
cp -r scripts $HOME

git clone https://github.com/wting/autojump.git ~/autojump
python ~/autojump/install.py

# vim config
echo "Please waitting (install vim) ......"
if [ ! -s $HOME/.vim/bundle/Vundle.vim ]; then
	rm -rf $HOME/.vim/bundle/Vundle.vim
fi
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
cp .vimrc $HOME
source $HOME/.vimrc 2>/dev/null
vim +PluginInstall +qall &> /dev/null &
echo "Install Finished."

# oh-my-zsh config
echo "Please waitting (install oh-my-zsh) ......"
rm -rf $HOME/.oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" &
sleep 5
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
wait
cp .zshrc $HOME
zsh
source .zshrc
echo "Install Finished."
