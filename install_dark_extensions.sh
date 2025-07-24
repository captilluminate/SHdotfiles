#!/bin/bash

echo "=== Browser Dark Mode Extensions Installation Guide ==="
echo ""

echo "🦊 FIREFOX - Dark Reader Extension:"
echo "1. Open Firefox"
echo "2. Go to: https://addons.mozilla.org/en-US/firefox/addon/darkreader/"
echo "3. Click 'Add to Firefox'"
echo "4. Enable the extension and configure it for TeraBox"
echo ""

echo "🌐 GOOGLE CHROME - Dark Reader Extension:"
echo "1. Open Google Chrome"
echo "2. Go to: https://chrome.google.com/webstore/detail/dark-reader/eimadpbcbfnmbkopoojfekhnkhdbieeh"
echo "3. Click 'Add to Chrome'"
echo "4. Enable the extension and configure it for TeraBox"
echo ""

echo "📋 Alternative Extensions:"
echo "- Stylus: For custom CSS (more advanced)"
echo "- Turn Off the Lights: Another dark mode option"
echo ""

echo "⚙️  Dark Reader Configuration for TeraBox:"
echo "1. Navigate to terabox.com"
echo "2. Click the Dark Reader extension icon"
echo "3. Toggle it ON for the site"
echo "4. Adjust brightness/contrast if needed"
echo ""

# Open the extension pages
read -p "Would you like me to open the extension installation pages? (y/n): " choice
if [[ $choice == "y" || $choice == "Y" ]]; then
    echo "Opening Firefox Dark Reader page..."
    firefox "https://addons.mozilla.org/en-US/firefox/addon/darkreader/" &
    sleep 2
    echo "Opening Chrome Dark Reader page..."
    google-chrome "https://chrome.google.com/webstore/detail/dark-reader/eimadpbcbfnmbkopoojfekhnkhdbieeh" &
fi
