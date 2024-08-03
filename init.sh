#!/bin/bash

# Enhanced Cross-platform Dotfiles Manager Script

# Configuration
DOTFILES_REPO="https://github.com/yourusername/dotfiles.git"
DOTFILES_DIR="$HOME/.dotfiles"
BACKUP_DIR="$HOME/.dotfiles_backup"
BUILD_DIR="$HOME/.dotfiles_build"


# Function to backup existing configs
backup_configs() {
    echo "Backing up existing configurations..."
    mkdir -p "$BACKUP_DIR"
    for config in alacritty configstore fish htop lsd neofetch nvim zellij; do
        if [ -d "$HOME/.config/$config" ]; then
            mv "$HOME/.config/$config" "$BACKUP_DIR/"
        fi
    done
}

# Function to install packages
install_packages() {
    local package=$1
    local git_repo=$2
    local build_commands=$3

    echo "Installing $package..."

    # Try to build from source
    if [ -n "$git_repo" ] && [ -n "$build_commands" ]; then
        mkdir -p "$BUILD_DIR"
        cd "$BUILD_DIR"
        if git clone "$git_repo" "$package" && cd "$package"; then
            if eval "$build_commands"; then
                echo "$package installed successfully from source."
                cd "$DOTFILES_DIR"
                return 0
            fi
        fi
        cd "$DOTFILES_DIR"
        echo "Failed to build $package from source. Trying package manager..."
    fi

    # Fall back to package manager
    if [ "$(uname)" == "Darwin" ]; then
        if ! command -v brew &> /dev/null; then
            echo "Homebrew not found. Installing Homebrew..."
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        fi
        brew install "$package"
    elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
        if command -v apt-get &> /dev/null; then
            sudo apt-get update
            sudo apt-get install -y "$package"
        else
            echo "Unsupported Linux distribution. Please install $package manually."
            return 1
        fi
    else
        echo "Unsupported operating system. Please install $package manually."
        return 1
    fi
}

# Function to install all required packages
install_all_packages() {
    # Neovim
    install_packages "neovim" "https://github.com/neovim/neovim.git" "make CMAKE_BUILD_TYPE=RelWithDebInfo && sudo make install"

    # fzf
    install_packages "fzf" "https://github.com/junegunn/fzf.git" "./install --all"

    # ripgrep
    install_packages "ripgrep" "https://github.com/BurntSushi/ripgrep.git" "cargo build --release && sudo cp target/release/rg /usr/local/bin/"

    # htop
    install_packages "htop" "https://github.com/htop-dev/htop.git" "./autogen.sh && ./configure && make && sudo make install"

    # fish
    install_packages "fish" "https://github.com/fish-shell/fish-shell.git" "cmake . && make && sudo make install"

    # alacritty
    install_packages "alacritty" "https://github.com/alacritty/alacritty.git" "cargo build --release && sudo cp target/release/alacritty /usr/local/bin/"

    # zellij
    install_packages "zellij" "https://github.com/zellij-org/zellij.git" "cargo install --path ."
}

create_symlinks() {
    echo "Creating symlinks..."
    for config in alacritty configstore fish htop lsd neofetch nvim zellij; do
        ln -sf "$DOTFILES_DIR/$config" "$HOME/.config/$config"
    done
}

# Function to handle sensitive data
handle_sensitive_data() {
    echo "Setting up sensitive data management..."
    if [ ! -f "$HOME/.config/fish/sensitive_config.fish" ]; then
        echo "# Add your sensitive configurations here" > "$HOME/.config/fish/sensitive_config.fish"
    fi
    echo "source $HOME/.config/fish/sensitive_config.fish" >> "$HOME/.config/fish/config.fish"
    echo "$HOME/.config/fish/sensitive_config.fish" >> "$DOTFILES_DIR/.gitignore"
}

# Main execution
main() {
    if [ ! -d "$DOTFILES_DIR" ]; then
        git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
    else
        cd "$DOTFILES_DIR" && git pull origin master
    fi

    backup_configs
    create_symlinks
    install_all_packages
    handle_sensitive_data

    echo "Dotfiles setup complete!"
}

main
