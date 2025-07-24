#!/bin/bash

# Enhanced TeraBox Dark Mode Launcher
# This script applies multiple methods to ensure dark mode

echo "🌙 Launching TeraBox with Enhanced Dark Mode..."

# Set GTK theme environment variables
export GTK_THEME=Adwaita:dark
export GTK2_RC_FILES=/usr/share/themes/Adwaita-dark/gtk-2.0/gtkrc

# Force dark theme preference
export GTK_APPLICATION_PREFER_DARK_THEME=1

# Add custom CSS
export GTK_DATA_PREFIX=/usr
export XDG_DATA_DIRS="/usr/share:/usr/local/share:$HOME/.local/share"

# Create temporary GTK settings
GTK_SETTINGS_DIR="$HOME/.config/gtk-3.0"
mkdir -p "$GTK_SETTINGS_DIR"

# Backup existing settings if they exist
if [ -f "$GTK_SETTINGS_DIR/settings.ini" ]; then
    cp "$GTK_SETTINGS_DIR/settings.ini" "$GTK_SETTINGS_DIR/settings.ini.backup.$(date +%s)"
fi

# Create/update GTK settings for dark theme
cat > "$GTK_SETTINGS_DIR/settings.ini" << EOF
[Settings]
gtk-application-prefer-dark-theme=true
gtk-theme-name=Adwaita-dark
gtk-icon-theme-name=Adwaita
gtk-font-name=Cantarell 11
gtk-cursor-theme-name=Adwaita
gtk-cursor-theme-size=24
gtk-toolbar-style=GTK_TOOLBAR_BOTH_HORIZ
gtk-toolbar-icon-size=GTK_ICON_SIZE_LARGE_TOOLBAR
gtk-button-images=true
gtk-menu-images=true
gtk-enable-event-sounds=true
gtk-enable-input-feedback-sounds=true
gtk-xft-antialias=1
gtk-xft-hinting=1
gtk-xft-hintstyle=hintfull
gtk-xft-rgba=rgb
gtk-decoration-layout=close,minimize,maximize:
EOF

echo "✓ GTK settings configured for dark theme"

# Apply custom CSS if it exists
if [ -f "$HOME/.config/gtk-3.0/terabox-dark.css" ]; then
    export GTK_CSS_FILE="$HOME/.config/gtk-3.0/terabox-dark.css"
    echo "✓ Custom CSS loaded"
fi

echo "🚀 Starting TeraBox..."

# Launch TeraBox with all dark mode settings
/opt/TeraBox/terabox --no-sandbox "$@"
