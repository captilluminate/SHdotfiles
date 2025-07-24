# TeraBox Dark Mode Solutions

This repository contains multiple approaches to enable dark mode for TeraBox (both web and desktop versions).

## 🌐 Web Browser Dark Mode

### Method 1: Browser Extensions
- **Dark Reader**: Universal dark mode extension
- **Stylus**: Custom CSS injection extension

Run the installer:
```bash
./install_dark_extensions.sh
```

### Method 2: Custom CSS
Apply the custom CSS using Stylus extension or browser developer tools:
- `terabox_dark_mode.css` - Complete dark mode CSS for TeraBox web interface
- `css_installation_guide.md` - Detailed installation guide

## 🖥️ Desktop Application Dark Mode

### Quick Solutions
1. **Basic Dark Mode**: `./terabox-dark.sh`
2. **Enhanced Dark Mode**: `./terabox-dark-enhanced.sh` (Recommended)
3. **Force Dark Mode**: `./terabox-force-dark.sh`
4. **Ultimate Dark Mode**: `./terabox-ultimate-dark.sh`
5. **CSS Injection**: `./terabox-css-dark.sh`

### Manual Console Injection (Most Reliable)
If automated scripts don't work:

1. Launch TeraBox normally: `/opt/TeraBox/terabox --no-sandbox &`
2. Press F12 in TeraBox to open Developer Tools
3. Go to Console tab
4. Paste the code from `dark-mode-console-command.js`
5. Press Enter

This will force dark mode immediately and keep reapplying it.

## 📁 File Structure

```
├── install_dark_extensions.sh      # Browser extension installer
├── terabox_dark_mode.css          # Web CSS dark mode
├── css_installation_guide.md      # CSS installation guide
├── terabox-dark.sh               # Basic desktop dark mode
├── terabox-dark-enhanced.sh      # Enhanced desktop dark mode
├── terabox-force-dark.sh         # Nuclear desktop dark mode
├── terabox-ultimate-dark.sh      # Ultimate desktop dark mode
├── terabox-css-dark.sh           # CSS injection desktop mode
└── dark-mode-console-command.js  # Manual console injection
```

## 🚀 Quick Start

### For Desktop TeraBox:
```bash
# Try the enhanced version first
./terabox-dark-enhanced.sh

# If that doesn't work, use manual console injection
# Launch TeraBox, press F12, paste console command
```

### For Web TeraBox:
```bash
# Install browser extensions
./install_dark_extensions.sh

# Or use custom CSS with Stylus extension
```

## 🛠️ System Requirements

- **OS**: Linux (tested on openSUSE Tumbleweed)
- **Desktop**: Works with Sway/Wayland and X11
- **TeraBox**: Desktop version installed in `/opt/TeraBox`
- **Browsers**: Firefox, Chrome/Chromium supported

## 🌙 Features

- ✅ GTK theme integration
- ✅ Custom CSS styling
- ✅ Web content dark mode
- ✅ Persistent dark mode settings
- ✅ Multiple fallback methods
- ✅ Console injection for stubborn interfaces
- ✅ Browser extension support

## 📝 Notes

- The desktop app may require manual console injection for complete dark mode
- Web versions work best with browser extensions
- Scripts are optimized for Sway window manager but work on other WMs
- CSS can be customized by editing the `.css` files

Created: 2025-07-24
