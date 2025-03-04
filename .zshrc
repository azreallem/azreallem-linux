# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export PATH="$PATH:$HOME/scripts:/usr/local/go/bin"
export TMUX_TMPDIR=$HOME/tmp
export LANG="zh_CN.UTF-8"
export LC_ALL="zh_CN.UTF-8"

# Set name of the theme to load --- if set to "random", it will load a random
# theme each time oh-my-zsh is loaded, in which case, to know which specific
# one was loaded, run: echo $RANDOM_THEME See
# https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="ys"
#ZSH_THEME="robbyrussell"
#ZSH_THEME="random"
#ZSH_THEME="peepcode"
#ZSH_THEME="geoffgarside"

# Set list of themes to pick from when loading at random Setting this variable
# when ZSH_THEME=random will cause zsh to load a theme from this variable
# instead of looking in $ZSH/themes/ If set to an empty array, this variable
# will have no effect.  ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster"
# )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for
# completion.  Caution: this setting can cause issues with multiline prompts
# (zsh 5.7.1 and newer seem to work) See
# https://github.com/ohmyzsh/ohmyzsh/issues/5765 COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.  DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.  You can set one of the optional
# three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd" or set a custom format
# using the strftime function format specifications, see 'man strftime' for
# details.  HIST_STAMPS="mm/dd/yyyy"
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?  Standard plugins can be found in
# $ZSH/plugins/ Custom plugins may be added to $ZSH_CUSTOM/plugins/ Example
# format: plugins=(rails git textmate ruby lighthouse) Add wisely, as too many
# plugins slow down shell startup.
# git clone https://github.com/wting/autojump.git
plugins=(zsh-syntax-highlighting autojump)
[[ -s $HOME/.autojump/etc/profile.d/autojump.sh ]] && source $HOME/.autojump/etc/profile.d/autojump.sh
autoload -U compinit && compinit -u

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=100000
SAVEHIST=100000
HISTFILE=~/.zsh_history

source $ZSH/oh-my-zsh.sh
#source /etc/profile.d/clash.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions if [[ -n $SSH_CONNECTION ]];
# then export EDITOR='vim' else export EDITOR='mvim' fi

# Compilation flags export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

setopt no_share_history
setopt no_nomatch



# -------------------------- alias --------------------------
alias rm="trash-put"
#trash-put           把文件或目录移动到回收站
#trash-empty         清空回收站
#trash-list          列出回收站文件
#trash-restore       恢复回收站文件
#trash-rm            删除回收站文件
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
alias clear="clear;tmux clear-history"

fg() {
    if [[ $# -eq 1 && $1 = - ]]; then
        builtin fg %-
    else
        builtin fg %"$@"
    fi
}

proxy_on() {
	export http_proxy=http://127.0.0.1:7890
	export https_proxy=http://127.0.0.1:7890
	export no_proxy=127.0.0.1,localhost
	export HTTP_PROXY=http://127.0.0.1:7890
	export HTTPS_PROXY=http://127.0.0.1:7890
	export NO_PROXY=127.0.0.1,localhost
	echo -e "\033[32m[√] proxy on finished.\033[0m"
}

proxy_off() {
	export http_proxy=
	export https_proxy=
	export no_proxy=
	export HTTP_PROXY=
	export HTTPS_PROXY=
	export NO_PROXY=
	echo -e "\033[32m[√] proxy off finished.\033[0m"
}

if [[ -d "/home/gaoliang/anaconda3" ]]; then
	# >>> conda initialize >>>
	# !! Contents within this block are managed by 'conda init' !!
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
	# <<< conda initialize <<<
fi

if [[ -f "/opt/ros/rolling/setup.zsh" ]]; then
	source /opt/ros/rolling/setup.zsh
fi

