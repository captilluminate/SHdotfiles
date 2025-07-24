#!/bin/bash

# TeraBox Dark Mode Launcher
# This script forces TeraBox to use dark theme

echo "🌙 Launching TeraBox in Dark Mode..."

# Method 1: GTK Theme Environment Variables
export GTK_THEME=Adwaita:dark
export GTK2_RC_FILES=/usr/share/themes/Adwaita-dark/gtk-2.0/gtkrc

# Method 2: Additional dark mode hints
export QT_STYLE_OVERRIDE=Adwaita-Dark
export GNOME_DESKTOP_SESSION_ID=this-is-deprecated

# Method 3: Force dark theme preference
export GTK_APPLICATION_PREFER_DARK_THEME=1

# Launch TeraBox with dark theme
/opt/TeraBox/terabox --no-sandbox "$@"
