#!/bin/bash

# Configuration
TIMESTAMP=$(date +%y%m%d%H%M%S)
BACKUP_DIR="backups/backups_$TIMESTAMP"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${GREEN}[INFO] Starting configuration restore...${NC}"

# 1. Backups
echo -e "${GREEN}[INFO] Backing up current configs to $BACKUP_DIR...${NC}"
mkdir -p "$BACKUP_DIR"
[ -f "$HOME/.tmux.conf" ] && cp "$HOME/.tmux.conf" "$BACKUP_DIR"
[ -f "$HOME/.zshrc" ] && cp "$HOME/.zshrc" "$BACKUP_DIR"
[ -f "$HOME/.vimrc" ] && cp "$HOME/.vimrc" "$BACKUP_DIR"
[ -d "$HOME/scripts" ] && cp -r "$HOME/scripts" "$BACKUP_DIR"

# 2. Deploy Configs
echo -e "${GREEN}[INFO] Deploying new configurations...${NC}"

if [ -f ".tmux.conf" ]; then
    cp .tmux.conf "$HOME"
else
    echo -e "${YELLOW}[WARN] .tmux.conf not found in current directory.${NC}"
fi

if [ -f ".zshrc" ]; then
    cp .zshrc "$HOME"
else
    echo -e "${YELLOW}[WARN] .zshrc not found in current directory.${NC}"
fi

if [ -f ".vimrc" ]; then
    cp .vimrc "$HOME"
else
    echo -e "${YELLOW}[WARN] .vimrc not found in current directory.${NC}"
fi

if [ -d "scripts" ]; then
    cp -r scripts "$HOME"
else
    echo -e "${YELLOW}[WARN] scripts directory not found.${NC}"
fi

echo -e "${GREEN}[INFO] Configuration restore finished.${NC}"
echo -e "${YELLOW}Note: Please restart your shell or source the config files manually (e.g., 'source ~/.zshrc') to apply changes.${NC}"

