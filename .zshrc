# -------------------------- export env -----------------------

export ZSH="$HOME/.oh-my-zsh"
export PATH="$PATH:$HOME/scripts:/usr/local/go/bin"
export TMUX_TMPDIR="$HOME/tmp"
export EDITOR="vim"
export LANG="en_US.UTF-8"

# -------------------------- Configs --------------------------

# Set Zsh theme
ZSH_THEME="jonathan"

# Disable auto-updates for Oh My Zsh
DISABLE_AUTO_UPDATE="true"

# Enable automatic command correction
ENABLE_CORRECTION="true"

# Configure command history
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history
HIST_STAMPS="yyyy-mm-dd"

# Load Oh My Zsh
source "$ZSH/oh-my-zsh.sh"

# -------------------------- Plugins --------------------------

if [[ -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]]; then
    source "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi
[[ -s $HOME/.autojump/etc/profile.d/autojump.sh ]] && source "$HOME/.autojump/etc/profile.d/autojump.sh"

# -------------------------- Aliases --------------------------

alias rm="trash-put"
alias cp="cp -i"
alias ssh="ssh -X"
alias grepc="grep -Inr --include=*.{cpp,c,h,hpp,py}"
alias find.="find . -name"
alias vim:="vv.sh"
alias ifconfig="/sbin/ifconfig"
alias vimrc="vim $HOME/.vimrc"
alias zshrc="vim $HOME/.zshrc"
alias tmux.conf="vim $HOME/.tmux.conf"
alias diffvimrc="vimdiff $HOME/.vimrc .vimrc"
alias diffzshrc="vimdiff $HOME/.zshrc .zshrc"
alias difftmux.conf="vimdiff $HOME/.tmux.conf .tmux.conf"
alias out="tee ./tmp_$(date +"%y%m%d_%H%M%S").log"
alias echopath="tr ':' '\n' | nl"
alias readme="vim ~/README.md"
alias port="netstat -tulnp"
for i in {0..9}; do
    alias tmux$i="tmux a -d -t $i"
done

# -------------------------- Functions ------------------------

fg() {
    if [[ $# -eq 1 && $1 = - ]]; then
        builtin fg %-
    else
        builtin fg %"$@"
    fi
}

proxy_on() {
    export http_proxy="http://127.0.0.1:7890"
    export https_proxy="http://127.0.0.1:7890"
    export no_proxy="127.0.0.1,localhost"
    export HTTP_PROXY="http://127.0.0.1:7890"
    export HTTPS_PROXY="http://127.0.0.1:7890"
    export NO_PROXY="127.0.0.1,localhost"
}

proxy_off() {
    unset http_proxy https_proxy no_proxy HTTP_PROXY HTTPS_PROXY NO_PROXY
    echo -e "\033[32m[√] Proxy has been turned off.\033[0m"
}

# -------------------------- Loading -----------------------------

# Load Conda if available
if [[ -d "/home/gaoliang/anaconda3" ]]; then
    __conda_setup="$('/home/gaoliang/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/home/gaoliang/anaconda3/etc/profile.d/conda.sh" ]; then
            . "/home/gaoliang/anaconda3/etc/profile.d/conda.sh"
        else
            export PATH="/home/gaoliang/anaconda3/bin:$PATH"
        fi
    fi
    unset __conda_setup
fi

# Load ROS environment if available
if [[ -f "/opt/ros/rolling/setup.zsh" ]]; then
    source /opt/ros/rolling/setup.zsh
fi

# -------------------------- Start -------------------------------
proxy_on

