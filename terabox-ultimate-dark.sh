#!/bin/bash

# ULTIMATE TeraBox Dark Mode - Forces EVERYTHING including web content
echo "🌚 ULTIMATE TeraBox Dark Mode - Maximum Force Applied!"

# Kill existing processes
pkill -f terabox 2>/dev/null || true
sleep 1

# Set ALL dark mode environment variables
export GTK_THEME=Adwaita:dark
export GTK_APPLICATION_PREFER_DARK_THEME=1
export GDK_THEME_VARIANT=dark
export QT_QPA_PLATFORMTHEME=gtk3

# Force dark mode for Chromium/Electron content
export FORCE_COLOR_PROFILE=dark
export ELECTRON_ENABLE_LOGGING=1

# Create TeraBox config directory if it doesn't exist
mkdir -p "$HOME/.config/TeraBox"

# Create custom CSS for web content
cat > "$HOME/.config/TeraBox/dark-mode.css" << 'EOF'
/* Force dark mode on ALL web content */
html, body {
    background-color: #1a1a1a !important;
    color: #e0e0e0 !important;
    filter: invert(1) hue-rotate(180deg) !important;
}

img, video, iframe, svg {
    filter: invert(1) hue-rotate(180deg) !important;
}
EOF

echo "✓ Web content dark mode CSS created"

# Launch with MAXIMUM dark mode arguments
echo "🚀 Launching TeraBox with ULTIMATE DARK MODE..."

/opt/TeraBox/terabox \
    --no-sandbox \
    --force-dark-mode \
    --enable-features=WebUIDarkMode,ForceDarkMode \
    --force-color-profile=srgb \
    --disable-features=TransparencyInTabStrip \
    --enable-blink-features=ForceDarkModeImagePolicy \
    --dark-mode-settings=ImagePolicy=2,PagePolicy=1,TextPolicy=1 \
    --user-data-dir="$HOME/.config/TeraBox" \
    "$@" &

echo "💥 ULTIMATE DARK MODE APPLIED! TeraBox should be COMPLETELY DARK!"
