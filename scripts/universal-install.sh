#!/bin/bash

#
# Universal SHdotfiles Installer
# Copyright (C) 2024-2025 Vladimir `rifux` Blinkov
#
# SPDX-License-Identifier: MIT
#
# This script automates the setup of Hyprland dotfiles across multiple Linux distributions
# Supports: openSUSE (Tumbleweed/Slowroll), Arch Linux, Ubuntu/Debian, Fedora
#

set -e  # Exit immediately if any command fails

# Environment variables
t="$HOME/.cache/universal-hyprland-installer"
c="$HOME/.config/"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Unified printing function
_log() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

# Detect distribution
_detect_distro() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        DISTRO_ID="$ID"
        DISTRO_VERSION="$VERSION_ID"
        DISTRO_CODENAME="$VERSION_CODENAME"
        
        case "$DISTRO_ID" in
            "opensuse-tumbleweed")
                DISTRO="opensuse-tumbleweed"
                PKG_MANAGER="zypper"
                ;;
            "opensuse-slowroll")
                DISTRO="opensuse-slowroll"
                PKG_MANAGER="zypper"
                ;;
            "opensuse-leap")
                DISTRO="opensuse-leap"
                PKG_MANAGER="zypper"
                ;;
            "arch")
                DISTRO="arch"
                PKG_MANAGER="pacman"
                ;;
            "ubuntu"|"debian")
                DISTRO="$DISTRO_ID"
                PKG_MANAGER="apt"
                ;;
            "fedora")
                DISTRO="fedora"
                PKG_MANAGER="dnf"
                ;;
            *)
                _error "Unsupported distribution: $DISTRO_ID"
                _log "Supported distributions: openSUSE (Tumbleweed/Slowroll/Leap), Arch Linux, Ubuntu, Debian, Fedora"
                exit 1
                ;;
        esac
        
        _log "Detected distribution: $DISTRO_ID ($DISTRO_VERSION)"
        _log "Package manager: $PKG_MANAGER"
    else
        _error "Cannot detect distribution. /etc/os-release not found."
        exit 1
    fi
}

# Package mapping across distributions
_get_packages() {
    case "$DISTRO" in
        "opensuse-tumbleweed"|"opensuse-slowroll"|"opensuse-leap")
            PACKAGES="fish starship neovim git foot kitty fuzzel brightnessctl gammastep grim slurp swappy wl-clipboard xdg-desktop-portal-hyprland hyprland hypridle waybar eww polkit-gnome pavucontrol playerctl cliphist swww ripgrep rsync curl wget unzip fontconfig jetbrains-mono-fonts npm python3-pip cargo cmake meson ninja gcc-c++ pkg-config wayland-devel wayland-protocols-devel cairo-devel pango-devel gdk-pixbuf2-devel gtk3-devel gtk4-devel libdrm-devel libxkbcommon-devel"
            ;;
        "arch")
            PACKAGES="fish starship neovim git foot kitty fuzzel brightnessctl gammastep grim slurp swappy wl-clipboard xdg-desktop-portal-hyprland hyprland hypridle waybar eww-wayland polkit-gnome pavucontrol playerctl cliphist swww ripgrep rsync curl wget unzip fontconfig ttf-jetbrains-mono npm python-pip rust cmake meson ninja gcc pkgconf wayland wayland-protocols cairo pango gdk-pixbuf2 gtk3 gtk4 libdrm libxkbcommon"
            ;;
        "ubuntu"|"debian")
            PACKAGES="fish starship neovim git foot kitty fuzzel brightnessctl gammastep grim slurp swappy wl-clipboard hyprland waybar polkit-gnome pavucontrol playerctl ripgrep rsync curl wget unzip fontconfig fonts-jetbrains-mono npm python3-pip cargo cmake meson ninja-build gcc g++ pkg-config libwayland-dev wayland-protocols libcairo2-dev libpango1.0-dev libgdk-pixbuf-2.0-dev libgtk-3-dev libgtk-4-dev libdrm-dev libxkbcommon-dev"
            ;;
        "fedora")
            PACKAGES="fish starship neovim git foot kitty fuzzel brightnessctl gammastep grim slurp swappy wl-clipboard hyprland waybar polkit-gnome pavucontrol playerctl ripgrep rsync curl wget unzip fontconfig jetbrains-mono-fonts npm python3-pip cargo cmake meson ninja-build gcc-c++ pkgconfig wayland-devel wayland-protocols-devel cairo-devel pango-devel gdk-pixbuf2-devel gtk3-devel gtk4-devel libdrm-devel libxkbcommon-devel"
            ;;
    esac
}

# Add repositories based on distribution
_add_repos() {
    case "$DISTRO" in
        "opensuse-tumbleweed")
            if ! zypper lr --alias home_rifux.dev &>/dev/null; then    
                _log "Adding home:rifux.dev repository for Tumbleweed"
                sudo zypper --gpg-auto-import-keys ar -f https://download.opensuse.org/repositories/home:/rifux.dev/openSUSE_Tumbleweed/home:rifux.dev.repo
                sudo zypper ref
            fi
            ;;
        "opensuse-slowroll")
            _warn "Slowroll detected - using Tumbleweed repositories (may cause compatibility issues)"
            if ! zypper lr --alias home_rifux.dev &>/dev/null; then    
                _log "Adding home:rifux.dev repository for Slowroll"
                sudo zypper --gpg-auto-import-keys ar -f https://download.opensuse.org/repositories/home:/rifux.dev/openSUSE_Tumbleweed/home:rifux.dev.repo
                sudo zypper ref
            fi
            ;;
        "opensuse-leap")
            _log "Adding repositories for openSUSE Leap"
            # Add Leap-specific repos if needed
            ;;
        "arch")
            _log "Updating package database for Arch Linux"
            sudo pacman -Sy
            ;;
        "ubuntu"|"debian")
            _log "Updating package database for $DISTRO"
            sudo apt update
            # Add PPAs if needed for newer packages
            if ! command -v starship &> /dev/null; then
                _log "Adding Starship install (not in default repos)"
            fi
            ;;
        "fedora")
            _log "Updating package database for Fedora"
            sudo dnf check-update || true
            # Enable RPM Fusion if needed
            ;;
    esac
}

# Install packages using appropriate package manager
_install_packages() {
    _get_packages
    
    case "$PKG_MANAGER" in
        "zypper")
            _log "Installing packages with zypper"
            sudo zypper in --no-confirm $PACKAGES
            ;;
        "pacman")
            _log "Installing packages with pacman"
            sudo pacman -S --noconfirm $PACKAGES
            ;;
        "apt")
            _log "Installing packages with apt"
            sudo apt install -y $PACKAGES
            ;;
        "dnf")
            _log "Installing packages with dnf"
            sudo dnf install -y $PACKAGES
            ;;
    esac
}

# Install distribution-specific packages that aren't available in main repos
_install_special_packages() {
    case "$DISTRO" in
        "ubuntu"|"debian")
            # Install Starship if not available in repos
            if ! command -v starship &> /dev/null; then
                _log "Installing Starship via installer script"
                curl -sS https://starship.rs/install.sh | sh -s -- --yes
            fi
            
            # Install eza if not available
            if ! command -v eza &> /dev/null; then
                _log "Installing eza via cargo"
                cargo install eza
            fi
            ;;
        "fedora")
            # Install packages from Copr if needed
            if ! command -v eza &> /dev/null; then
                _log "Installing eza via cargo"
                cargo install eza
            fi
            ;;
        "arch")
            # Install AUR packages if yay is available
            if command -v yay &> /dev/null; then
                _log "Installing AUR packages with yay"
                yay -S --noconfirm hyprpicker-git hypridle-git
            fi
            ;;
    esac
}

# Clean up temporary files and existing configurations
_cleanup() {
    if [ -d "$t" ]; then
        rm -rf "$t"
    fi

    _log "Backing up existing configurations"
    backup_dir="$HOME/.config-backup-$(date +%Y%m%d-%H%M%S)"
    mkdir -p "$backup_dir"
    
    for path in fish hypr waybar kitty foot fuzzel starship.toml; do
        if [ -e "$c/$path" ]; then
            _log "Backing up $c/$path to $backup_dir/"
            cp -r "$c/$path" "$backup_dir/"
        fi
    done
}

# Deploy dotfiles
_deploy_dotfiles() {
    _log "Deploying dotfiles"
    
    # Create necessary directories
    mkdir -p "$c"
    
    # Link config files
    if [ -d "$DOTFILES_DIR/config" ]; then
        for config_item in "$DOTFILES_DIR/config"/*; do
            if [ -e "$config_item" ]; then
                config_name=$(basename "$config_item")
                target="$c/$config_name"
                
                # Remove existing file/link
                if [ -e "$target" ] || [ -L "$target" ]; then
                    rm -rf "$target"
                fi
                
                # Create symlink
                ln -sf "$config_item" "$target"
                _log "Linked $config_name"
            fi
        done
    fi
    
    # Link home files
    if [ -d "$DOTFILES_DIR/home-files" ]; then
        for home_file in "$DOTFILES_DIR/home-files"/.*; do
            if [ -f "$home_file" ]; then
                filename=$(basename "$home_file")
                target="$HOME/$filename"
                
                # Skip . and ..
                if [[ "$filename" == "." || "$filename" == ".." ]]; then
                    continue
                fi
                
                # Backup existing file
                if [ -e "$target" ] && [ ! -L "$target" ]; then
                    cp "$target" "$backup_dir/$filename.bak" 2>/dev/null || true
                fi
                
                # Create symlink
                ln -sf "$home_file" "$target"
                _log "Linked $filename to home directory"
            fi
        done
    fi
}

# Build and install tools from source (universal)
_install_hypr_tools() {
    _log "Installing Hyprland ecosystem tools from source"
    mkdir -p "$t"
    cd "$t"
    
    # Tools that need to be built from source on most distros
    local tools=(
        "https://github.com/hyprwm/hyprutils.git"
        "https://github.com/hyprwm/hyprwayland-scanner.git"
        "https://github.com/hyprwm/hyprpicker.git"
        "https://github.com/hyprwm/hyprlock.git"
    )
    
    for tool_url in "${tools[@]}"; do
        tool_name=$(basename "$tool_url" .git)
        _log "Building $tool_name"
        
        if [ -d "$tool_name" ]; then
            rm -rf "$tool_name"
        fi
        
        git clone "$tool_url"
        cd "$tool_name"
        
        # Build using cmake
        cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local -B build
        cmake --build build -j$(nproc)
        sudo cmake --install build
        
        cd ..
        _success "Installed $tool_name"
    done
}

# Set up shell
_setup_shell() {
    _log "Setting up Fish shell"
    
    # Add fish to shells if not already there
    if ! grep -q "$(which fish)" /etc/shells; then
        echo "$(which fish)" | sudo tee -a /etc/shells
    fi
    
    # Ask user if they want to change default shell
    echo
    read -p "Do you want to set Fish as your default shell? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        chsh -s "$(which fish)"
        _success "Default shell changed to Fish"
    fi
}

# Main program execution
_main() {
    echo "=============================================="
    echo "    Universal SHdotfiles Installer"
    echo "=============================================="
    echo
    
    _detect_distro
    _cleanup
    _add_repos
    _install_packages
    _install_special_packages
    _deploy_dotfiles
    _install_hypr_tools
    _setup_shell
    
    echo
    echo "=============================================="
    _success "Installation completed!"
    echo "=============================================="
    echo
    _log "Your original configs have been backed up to: $backup_dir"
    _log "Please log out and log back in to apply all changes"
    _log "Or run: exec fish"
    echo
}

# Run main function
_main "$@"
