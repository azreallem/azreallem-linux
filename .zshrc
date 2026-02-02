# ==============================================================================
# Environment Variables
# ==============================================================================
export ZSH="$HOME/.oh-my-zsh"
export PATH="$PATH:$HOME/scripts:/usr/local/go/bin"
export TMUX_TMPDIR="$HOME/tmp"
export EDITOR="vim"
export LANG="zh_CN.UTF-8"

# ==============================================================================
# Oh-My-Zsh Settings
# ==============================================================================
ZSH_THEME="frisk"
DISABLE_AUTO_UPDATE="true"
ENABLE_CORRECTION="true"

# History Settings
HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE=~/.zsh_history
HIST_STAMPS="yyyy-mm-dd"
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE

# Plugins
# Note: Ensure these are installed in $ZSH/custom/plugins/
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    autojump
)

source "$ZSH/oh-my-zsh.sh"

# ==============================================================================
# Aliases
# ==============================================================================

# File Safety
alias rm="trash-put" # Requires trash-cli
alias cp="cp -i"
alias mv="mv -i"

# Listing
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Networking
alias port="netstat -tulnp"
alias ssh="ssh -X"
alias myip="curl http://ipecho.net/plain; echo"

# Development
alias grepc="grep -Inr --include=*.{cpp,c,h,hpp,py}"
alias vimrc="vim $HOME/.vimrc"
alias zshrc="vim $HOME/.zshrc"
alias tmux.conf="vim $HOME/.tmux.conf"

# Misc
alias out="tee ./tmp_$(date +"%y%m%d_%H%M%S").log"
alias echopath="tr ':' '\n' | nl"
alias c="clear"

# Tmux Shortcuts
for i in {0..9}; do
    alias tmux$i="tmux a -d -t $i"
done

# ==============================================================================
# Functions
# ==============================================================================

# Vim Wrapper: Opens file:line (e.g. vim main.c:10)
vim() {
    local args=()
    local file line
    for arg in "$@"; do
        if [[ $arg =~ :[0-9]+$ ]]; then
            file=${arg%:*} 
            line=${arg##*:} 
            args+=("$file" "+$line")
        else
            args+=("$arg")
        fi
    done
    command vim "${args[@]}"
}

# Proxy Settings
proxy_on() {
    export http_proxy="http://127.0.0.1:7890"
    export https_proxy="http://127.0.0.1:7890"
    export no_proxy="127.0.0.1,localhost"
    export HTTP_PROXY="http://127.0.0.1:7890"
    export HTTPS_PROXY="http://127.0.0.1:7890"
    export NO_PROXY="127.0.0.1,localhost"
    echo -e "\033[32m[√] Proxy On (127.0.0.1:7890)\033[0m"
}

proxy_off() {
    unset http_proxy https_proxy no_proxy HTTP_PROXY HTTPS_PROXY NO_PROXY
    echo -e "\033[32m[√] Proxy Off\033[0m"
}

# Background Job Management
fg() {
    if [[ $# -eq 1 && $1 = - ]]; then
        builtin fg %-
    else
        builtin fg %"$@"
    fi
}

# ==============================================================================
# Initialization
# ==============================================================================
setopt nonomatch
#proxy_on

# Gemini CLI
alias gemini="gemini -y"
