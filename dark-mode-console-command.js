// PASTE THIS IN TERABOX CONSOLE (F12 -> Console tab)
(function(){
    console.log('🌙 Injecting DARK MODE...');
    
    // Remove existing dark mode styles
    const existing = document.getElementById('terabox-force-dark');
    if(existing) existing.remove();
    
    // Create and inject dark mode CSS
    const style = document.createElement('style');
    style.id = 'terabox-force-dark';
    style.innerHTML = `
        /* FORCE EVERYTHING DARK */
        html, body, * {
            background-color: #1a1a1a !important;
            color: #ffffff !important;
        }
        
        /* Containers */
        div, section, main, nav, header, footer, article {
            background-color: #1a1a1a !important;
            color: #ffffff !important;
        }
        
        /* Input fields */
        input, textarea, select {
            background-color: #2d2d2d !important;
            color: #ffffff !important;
            border: 1px solid #444 !important;
        }
        
        /* Buttons */
        button, .btn, a {
            background-color: #404040 !important;
            color: #ffffff !important;
            border: 1px solid #666 !important;
        }
        
        /* List items and file entries */
        .file-item, .list-item, li, tr, td {
            background-color: #2d2d2d !important;
            color: #ffffff !important;
            border-bottom: 1px solid #444 !important;
        }
        
        /* Sidebar */
        .sidebar, .menu, .nav {
            background-color: #252525 !important;
            color: #ffffff !important;
        }
        
        /* Make images/icons visible */
        img, svg, .icon {
            filter: brightness(0.9) contrast(1.1) !important;
        }
        
        /* Override any white/light backgrounds */
        [style*="background-color: white"],
        [style*="background-color: #fff"],
        [style*="background-color: #ffffff"],
        [style*="background: white"],
        [style*="background: #fff"] {
            background-color: #1a1a1a !important;
        }
        
        /* Override any black text */
        [style*="color: black"],
        [style*="color: #000"],
        [style*="color: #000000"] {
            color: #ffffff !important;
        }
    `;
    
    document.head.appendChild(style);
    
    // Also apply directly to body
    document.body.style.setProperty('background-color', '#1a1a1a', 'important');
    document.body.style.setProperty('color', '#ffffff', 'important');
    
    console.log('✅ DARK MODE APPLIED! TeraBox should now be dark!');
    
    // Keep applying every 2 seconds in case content loads dynamically
    setInterval(() => {
        document.body.style.setProperty('background-color', '#1a1a1a', 'important');
        document.body.style.setProperty('color', '#ffffff', 'important');
    }, 2000);
    
})();
