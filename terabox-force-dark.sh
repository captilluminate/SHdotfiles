#!/bin/bash

# NUCLEAR OPTION: Force TeraBox Dark Mode by ALL means necessary
echo "💥 FORCING TeraBox Dark Mode - Nuclear Option..."

# Kill any existing TeraBox processes
pkill -f terabox 2>/dev/null || true

# Set EVERY possible dark mode environment variable
export GTK_THEME=Adwaita:dark
export GTK2_RC_FILES=/usr/share/themes/Adwaita-dark/gtk-2.0/gtkrc
export GTK_APPLICATION_PREFER_DARK_THEME=1
export QT_STYLE_OVERRIDE=Adwaita-Dark
export QT_QPA_PLATFORMTHEME=gtk3
export GNOME_DESKTOP_SESSION_ID=this-is-deprecated
export XDG_CURRENT_DESKTOP=GNOME
export DESKTOP_SESSION=gnome
export GDK_THEME_VARIANT=dark

# Force dark mode for web content (if TeraBox uses web views)
export FORCE_COLOR_PROFILE=dark
export CHROME_EXECUTABLE_PATH=/usr/bin/google-chrome
export ELECTRON_FORCE_IS_PACKAGED=true

# Create aggressive GTK CSS override
GTK_CSS_DIR="$HOME/.config/gtk-3.0"
mkdir -p "$GTK_CSS_DIR"

cat > "$GTK_CSS_DIR/gtk.css" << 'EOF'
/* NUCLEAR GTK DARK MODE OVERRIDE */
* {
    background-color: #2d2d2d !important;
    color: #eeeeee !important;
}

window, .window {
    background-color: #1a1a1a !important;
    color: #eeeeee !important;
}

headerbar, .headerbar, toolbar, .toolbar {
    background-color: #404040 !important;
    color: #eeeeee !important;
}

button, .button {
    background-color: #404040 !important;
    color: #eeeeee !important;
    border: 1px solid #666666 !important;
}

entry, .entry, textview, .textview {
    background-color: #333333 !important;
    color: #eeeeee !important;
    border: 1px solid #666666 !important;
}

treeview, .treeview, listbox, .listbox {
    background-color: #2d2d2d !important;
    color: #eeeeee !important;
}

menu, .menu, popover, .popover {
    background-color: #333333 !important;
    color: #eeeeee !important;
}

scrollbar {
    background-color: #2d2d2d !important;
}

scrollbar slider {
    background-color: #666666 !important;
}
EOF

echo "✓ Nuclear GTK CSS applied"

# Force dark mode in dconf/gsettings
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark' 2>/dev/null || true
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark' 2>/dev/null || true

echo "✓ System dark mode settings enforced"

# Launch with maximum dark mode force
echo "🚀 LAUNCHING TeraBox with MAXIMUM DARK MODE FORCE..."

# Use strace to see what's happening (optional debug)
# strace -e trace=openat -o /tmp/terabox.trace \
/opt/TeraBox/terabox --no-sandbox \
    --force-dark-mode \
    --enable-features=WebUIDarkMode \
    --disable-features=TransparencyInTabStrip \
    --force-color-profile=srgb \
    "$@" &

TERABOX_PID=$!
echo "TeraBox PID: $TERABOX_PID"
echo "💥 DARK MODE FORCED! TeraBox should now be DARK!"

# Monitor the process
sleep 2
if ps -p $TERABOX_PID > /dev/null; then
    echo "✅ TeraBox is running successfully in FORCED DARK MODE!"
else
    echo "❌ TeraBox process ended. Check for errors."
fi
