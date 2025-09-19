# PowerShell script to copy highlight queries to Neovim config
# Run this script to install the corrected highlight queries

# Create directories if they don't exist
$nvimConfigDir = "$env:USERPROFILE\.config\nvim"
New-Item -Path "$nvimConfigDir\queries\twoif" -ItemType Directory -Force
New-Item -Path "$nvimConfigDir\queries\2if" -ItemType Directory -Force

# Copy the corrected highlight queries
Copy-Item "queries\highlights.scm" "$nvimConfigDir\queries\twoif\highlights.scm" -Force
Copy-Item "queries\highlights.scm" "$nvimConfigDir\queries\2if\highlights.scm" -Force

Write-Host "✅ Copied highlight queries to Neovim config directories:"
Write-Host "   $nvimConfigDir\queries\twoif\highlights.scm"
Write-Host "   $nvimConfigDir\queries\2if\highlights.scm"
Write-Host ""
Write-Host "Now restart Neovim and open a .2if file to test highlighting!"