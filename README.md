# azreallem-linux

Personal Linux configuration and environment setup scripts.

## Contents

- `.vimrc`: Vim configuration with Vundle plugin manager.
- `.zshrc`: Zsh configuration with Oh-My-Zsh.
- `.tmux.conf`: Tmux configuration.
- `scripts/`: Collection of useful shell scripts.
- `install-apt-get.sh`: Comprehensive installation script for Ubuntu/Debian.
- `install-config.sh`: Lightweight script to deploy configurations.

## Installation

### Full Environment Setup (Ubuntu/Debian)

This script will update your system, install necessary packages (vim, zsh, tmux, etc.), configure Oh-My-Zsh, Vundle, and deploy all configuration files.

```bash
chmod +x install-apt-get.sh
./install-apt-get.sh
```

### Deploy Configuration Only

If you already have the necessary packages installed and just want to deploy the configuration files:

```bash
chmod +x install-config.sh
./install-config.sh
```

## Directory Structure

```text
.
├── .tmux.conf
├── .vimrc
├── .zshrc
├── install-apt-get.sh
├── install-config.sh
├── scripts/
│   ├── ff.sh
│   └── gg.sh
└── backups/           # Created during installation to store old configs
```

## Features

- **Zsh**: Integrated with Oh-My-Zsh and autojump.
- **Vim**: Plugin management via Vundle, pre-configured for development.
- **Tmux**: Customized status bar and key bindings.
- **Backup**: Automatically backups existing configuration files before overwriting.