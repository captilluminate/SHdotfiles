# SHdotfiles

Personal dotfiles for openSUSE Tumbleweed with Hyprland/Sway setup.

## Contents

- **home-files/**: Dotfiles that go in the home directory (~)
- **config/**: Configuration files that go in ~/.config/
- **scripts/**: Utility scripts and installers

## Key Components

### Window Manager & Desktop
- Hyprland configuration with Waybar
- Sway configuration as fallback
- EWW widgets
- Wlogout for logout menu
- Wofi launcher
- Fuzzel launcher

### Terminal & Shell
- Fish shell configuration
- Starship prompt
- Kitty terminal
- Foot terminal

### Development
- Neovim configuration with LazyVim
- Git configuration
- Various language-specific tools

### Theming
- Catppuccin theme integration
- Qt5/Qt6 theming
- GTK theming
- Material You colors integration

## Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/captilluminate/SHdotfiles.git
   cd SHdotfiles
   ```

2. Run the installation script:
   ```bash
   ./install.sh
   ```

3. Or manually link the files:
   ```bash
   # Link config files
   ln -sf $PWD/config/* ~/.config/
   
   # Link home files
   ln -sf $PWD/home-files/.bashrc ~/.bashrc
   ln -sf $PWD/home-files/.profile ~/.profile
   ln -sf $PWD/home-files/.gitconfig ~/.gitconfig
   # ... etc
   ```

## System Requirements

- openSUSE Tumbleweed (or similar Linux distribution)
- Hyprland or Sway window manager
- Fish shell
- Neovim
- Various dependencies (see scripts/install.sh)

## Notes

- Backup your existing configuration files before installation
- Some configurations may need adjustment for your specific system
- This setup is optimized for a Wayland environment
