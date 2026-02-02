#!/bin/bash

# Configuration
INSTALL_DIR="$PWD"
TIMESTAMP=$(date +%y%m%d%H%M%S)
BACKUP_DIR="$INSTALL_DIR/backups/backups_$TIMESTAMP"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

log_info() { echo -e "${GREEN}[INFO] $1${NC}"; }
log_warn() { echo -e "${YELLOW}[WARN] $1${NC}"; }
log_error() { echo -e "${RED}[ERROR] $1${NC}"; }

# Check sudo
if [ "$EUID" -ne 0 ]; then 
  log_warn "Please run as root or with sudo for package installation and root configuration."
fi

# 1. System Update & Package Installation
log_info "Updating system and installing packages..."
# modify sources.list of Ubuntu to ustc.edu.cn (Uncomment if needed)
# sudo sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list

if command -v apt-get >/dev/null; then
    sudo apt-get update -y
    sudo apt-get install -y aptitude zsh vim tmux curl wget net-tools ssh
    sudo apt-get install -y gcc g++ gdb cscope trash-cli git python3 python3-pip
else
    log_warn "apt-get not found. Skipping package installation."
fi

# Function to configure environment for a specific user
configure_user() {
    local TARGET_USER=$1
    local TARGET_HOME=$2
    
    log_info "Configuring environment for user: $TARGET_USER ($TARGET_HOME)..."

    # Backups (Skip backup for now as it's handled globally or simple overwrite)
    # mkdir -p "$TARGET_HOME/backups"

    # Copy Configs
    log_info "  - Deploying configurations..."
    cp .tmux.conf "$TARGET_HOME"
    cp -r scripts "$TARGET_HOME"
    
    # Fix permissions
    chown -R $TARGET_USER:$TARGET_USER "$TARGET_HOME/.tmux.conf" "$TARGET_HOME/scripts"

    # Vim Configuration (Vundle)
    log_info "  - Configuring Vim..."
    VUNDLE_DIR="$TARGET_HOME/.vim/bundle/Vundle.vim"
    if [ ! -d "$VUNDLE_DIR" ]; then
        git clone https://github.com/VundleVim/Vundle.vim.git "$VUNDLE_DIR"
        chown -R $TARGET_USER:$TARGET_USER "$TARGET_HOME/.vim"
    fi

    cp .vimrc "$TARGET_HOME"
    mkdir -p "$TARGET_HOME/.vim/doc"
    [ -d ".doc" ] && cp -r .doc/* "$TARGET_HOME/.vim/doc/"
    chown -R $TARGET_USER:$TARGET_USER "$TARGET_HOME/.vimrc" "$TARGET_HOME/.vim"

    log_info "  - Installing Vim plugins..."
    # Run vim plugin install as the target user
    sudo -u $TARGET_USER vim +PluginInstall +qall &>/dev/null &
    PID=$!
    wait $PID
    log_info "  - Vim plugins installed."

    # Oh-My-Zsh Installation
    log_info "  - Configuring Oh-My-Zsh..."
    if [ ! -d "$TARGET_HOME/.oh-my-zsh" ]; then
        # Unattended installation as target user
        # We use a temporary script to run install as user because sh -c "curl..." might run as root
        sudo -u $TARGET_USER sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    else
        log_info "  - Oh-My-Zsh already installed."
    fi

    cp .zshrc "$TARGET_HOME"
    chown $TARGET_USER:$TARGET_USER "$TARGET_HOME/.zshrc"

    # Change shell to zsh
    if [ "$(getent passwd $TARGET_USER | cut -d: -f7)" != "$(which zsh)" ]; then
        log_info "  - Changing default shell to zsh..."
        chsh -s "$(which zsh)" $TARGET_USER
    fi
}

# 2. Backups (Current User)
log_info "Backing up existing configurations for current user to $BACKUP_DIR..."
mkdir -p "$BACKUP_DIR"
[ -f "$HOME/.tmux.conf" ] && cp "$HOME/.tmux.conf" "$BACKUP_DIR"
[ -f "$HOME/.zshrc" ] && cp "$HOME/.zshrc" "$BACKUP_DIR"
[ -f "$HOME/.vimrc" ] && cp "$HOME/.vimrc" "$BACKUP_DIR"
[ -d "$HOME/scripts" ] && cp -r "$HOME/scripts" "$BACKUP_DIR"

# 3. Install Autojump (Global / User)
# Autojump is typically installed per-user or globally.
# Here we install it to the current directory (for source) and run install.py
if [ ! -d "$INSTALL_DIR/autojump" ]; then
    log_info "Downloading autojump..."
    git clone https://github.com/wting/autojump.git "$INSTALL_DIR/autojump"
    cd "$INSTALL_DIR/autojump" && ./install.py
    cd "$INSTALL_DIR"
else
    log_info "Autojump already downloaded."
    # Re-run install just in case
    cd "$INSTALL_DIR/autojump" && ./install.py
    cd "$INSTALL_DIR"
fi

# 4. Configure Current User
CURRENT_USER=$(whoami)
configure_user "$CURRENT_USER" "$HOME"

# 5. Configure Root (if running as root or sudo)
if [ "$EUID" -eq 0 ]; then
    # If we are root, configure root.
    # Note: If we are already root, CURRENT_USER is root, so step 4 covered it.
    # But if we ran with sudo, CURRENT_USER might be the sudoer? 
    # Actually 'whoami' under sudo returns root.
    # So we need to detect the 'real' user if invoked via sudo.
    
    REAL_USER=${SUDO_USER:-$USER}
    REAL_HOME=$(getent passwd $REAL_USER | cut -d: -f6)
    
    if [ "$REAL_USER" != "root" ]; then
        # We configured root in step 4 (because we are running as root).
        # Now we should also configure the real user.
        configure_user "$REAL_USER" "$REAL_HOME"
    fi
else
    log_warn "Not running as root. Root configuration skipped."
fi

log_info "Installation Finished! Please restart your terminal."
