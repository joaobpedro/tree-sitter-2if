# PowerShell script to copy Tree-sitter queries to Neovim config
# Run this script to install the queries for syntax highlighting, comment toggling, and text objects

# Create directories if they don't exist
$nvimConfigDir = "$env:USERPROFILE\.config\nvim"
New-Item -Path "$nvimConfigDir\queries\twoif" -ItemType Directory -Force
New-Item -Path "$nvimConfigDir\queries\2if" -ItemType Directory -Force

# Copy all query files
Copy-Item "queries\highlights.scm" "$nvimConfigDir\queries\twoif\highlights.scm" -Force
Copy-Item "queries\highlights.scm" "$nvimConfigDir\queries\2if\highlights.scm" -Force

Copy-Item "queries\injections.scm" "$nvimConfigDir\queries\twoif\injections.scm" -Force
Copy-Item "queries\injections.scm" "$nvimConfigDir\queries\2if\injections.scm" -Force

Copy-Item "queries\textobjects.scm" "$nvimConfigDir\queries\twoif\textobjects.scm" -Force
Copy-Item "queries\textobjects.scm" "$nvimConfigDir\queries\2if\textobjects.scm" -Force

Write-Host "✅ Copied Tree-sitter queries to Neovim config directories:"
Write-Host "   highlights.scm  - Syntax highlighting"
Write-Host "   injections.scm  - Comment toggling support"
Write-Host "   textobjects.scm - Comment text objects"
Write-Host ""
Write-Host "Files copied to both:"
Write-Host "   $nvimConfigDir\queries\twoif\"
Write-Host "   $nvimConfigDir\queries\2if\"
Write-Host ""
Write-Host "⚠️  IMPORTANT: To enable comment toggling, you also need to:"
Write-Host "1. Add the contents of 'neovim-config.lua' to your Neovim configuration"
Write-Host "   (usually ~/.config/nvim/init.lua or a separate plugin file)"
Write-Host "2. Restart Neovim completely"
Write-Host "3. Open a .2if file and test with 'gcc' or 'gc' in visual mode"
Write-Host ""
Write-Host "The neovim-config.lua file contains the comment string configuration"
Write-Host "that tells Neovim to use '#' for comments in .2if files."