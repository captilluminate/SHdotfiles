# TeraBox Dark Mode CSS Installation Guide

## Method 1: Using Stylus Extension (Recommended)

### Install Stylus:
- **Firefox**: https://addons.mozilla.org/en-US/firefox/addon/styl-us/
- **Chrome**: https://chrome.google.com/webstore/detail/stylus/clngdbkpkpeebahjckkjfobafhncgmne

### Apply the CSS:
1. Install Stylus extension
2. Navigate to terabox.com
3. Click the Stylus extension icon
4. Click "Write style for: terabox.com"
5. Copy the contents of `terabox_dark_mode.css` into the editor
6. Save the style
7. The dark mode should apply immediately

## Method 2: Browser Developer Tools (Temporary)

### Firefox:
1. Go to terabox.com
2. Press F12 to open Developer Tools
3. Go to the "Inspector" tab
4. Click the "+" icon next to "Filter Styles"
5. Paste the CSS from `terabox_dark_mode.css`
6. Press Enter to apply

### Chrome:
1. Go to terabox.com
2. Press F12 to open Developer Tools
3. Go to the "Elements" tab
4. Click on the `<head>` element
5. Right-click and select "Edit as HTML"
6. Add: `<style>` + CSS content + `</style>`

## Method 3: User Stylesheet (Permanent)

### Firefox:
1. Type `about:config` in address bar
2. Search for `toolkit.legacyUserProfileCustomizations.stylesheets`
3. Set it to `true`
4. Create folder: `~/.mozilla/firefox/[profile]/chrome/`
5. Create file: `userContent.css`
6. Add CSS with domain restriction:
```css
@-moz-document domain("terabox.com") {
    /* Paste CSS content here */
}
```

### Chrome:
Chrome doesn't support user stylesheets natively. Use Stylus extension instead.

## Troubleshooting

- If some elements aren't styled correctly, inspect them using F12 and adjust the CSS selectors
- TeraBox may update their interface, requiring CSS updates
- The CSS file can be modified to adjust colors and styling preferences
