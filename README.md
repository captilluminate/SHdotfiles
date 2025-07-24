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
- Ghostty terminal

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

### Universal Installer (Recommended)

The universal installer works across multiple Linux distributions:

1. Clone this repository:
   ```bash
   git clone https://github.com/captilluminate/SHdotfiles.git
   cd SHdotfiles
   ```

2. Run the universal installation script:
   ```bash
   ./scripts/universal-install.sh
   ```

**Supported Distributions:**
- openSUSE Tumbleweed
- openSUSE Slowroll  
- openSUSE Leap
- Arch Linux
- Ubuntu/Debian
- Fedora

### Legacy Installer (openSUSE Tumbleweed only)

For openSUSE Tumbleweed users, you can still use the original installer:

```bash
./scripts/install.sh
```

### Manual Installation

You can also manually link the files:

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

### Supported Distributions
- openSUSE (Tumbleweed, Slowroll, Leap)
- Arch Linux
- Ubuntu/Debian
- Fedora

### Core Dependencies
- Hyprland or Sway window manager
- Fish shell
- Starship prompt
- Neovim
- Wayland display server

### Additional Tools
- Terminal emulators: Kitty, Foot, Ghostty
- Launchers: Fuzzel, Wofi
- Status bars: Waybar, EWW
- Screenshot tools: Grim, Slurp, Swappy
- Various Wayland utilities (see scripts/universal-install.sh)

## Notes

- Backup your existing configuration files before installation
- Some configurations may need adjustment for your specific system
- This setup is optimized for a Wayland environment
