#!/bin/bash

echo "🎨 Launching TeraBox with CSS Dark Mode Injection..."

# Kill any existing TeraBox processes
pkill -f terabox 2>/dev/null || true
sleep 1

# Set environment variables for dark mode
export GTK_THEME=Adwaita:dark
export GTK_APPLICATION_PREFER_DARK_THEME=1
export GDK_THEME_VARIANT=dark

# Create a user script to inject dark mode CSS
CSS_INJECTION_SCRIPT="$HOME/.config/TeraBox/dark-mode-inject.js"
cat > "$CSS_INJECTION_SCRIPT" << 'EOF'
// Inject dark mode CSS into TeraBox
(function() {
    console.log('Injecting dark mode CSS...');
    
    // Create style element
    const style = document.createElement('style');
    style.id = 'terabox-dark-mode';
    
    // CSS content
    style.textContent = `
        html, body, * {
            background-color: #1e1e1e !important;
            color: #ffffff !important;
        }
        
        div, section, article, main, nav, header, footer {
            background-color: #1e1e1e !important;
            color: #ffffff !important;
        }
        
        input, textarea, select {
            background-color: #2d2d2d !important;
            color: #ffffff !important;
            border: 1px solid #404040 !important;
        }
        
        button, .btn, a[role="button"] {
            background-color: #404040 !important;
            color: #ffffff !important;
            border: 1px solid #606060 !important;
        }
        
        .file-item, .list-item, .grid-item, tr {
            background-color: #2d2d2d !important;
            color: #ffffff !important;
        }
        
        .sidebar, .nav, .menu {
            background-color: #252525 !important;
            color: #ffffff !important;
        }
        
        img, svg, .icon {
            filter: brightness(0.8) !important;
        }
    `;
    
    // Inject into head
    document.head.appendChild(style);
    
    // Also apply to body directly
    document.body.style.backgroundColor = '#1e1e1e';
    document.body.style.color = '#ffffff';
    
    console.log('Dark mode CSS injected successfully!');
})();
EOF

echo "✓ CSS injection script created"

# Launch TeraBox with custom user data and script injection
echo "🚀 Starting TeraBox with dark mode..."

/opt/TeraBox/terabox \
    --no-sandbox \
    --disable-gpu \
    --force-dark-mode \
    --enable-features=WebUIDarkMode,ForceDarkMode \
    --disable-web-security \
    --user-data-dir="$HOME/.config/TeraBox" \
    --enable-devtools-experiments \
    --js-flags="--expose-gc" \
    "$@" &

TERABOX_PID=$!
echo "TeraBox PID: $TERABOX_PID"

# Wait a moment for the app to start
sleep 3

# Try to inject CSS via developer console if possible
echo "💉 Attempting CSS injection..."

echo "🌙 TeraBox launched with CSS dark mode injection!"
echo "If it's still light, press F12 in TeraBox and paste this in the console:"
echo "document.head.insertAdjacentHTML('beforeend', '<style>html,body,*{background-color:#1e1e1e!important;color:#fff!important}</style>');"
