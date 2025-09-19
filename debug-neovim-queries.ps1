# Additional troubleshooting script for Neovim tree-sitter issues
# Run this if you're still getting query errors after copying the files

Write-Host "🔍 Checking Neovim query file locations..."

$nvimConfigDir = "$env:USERPROFILE\.config\nvim"
$queryDirs = @("$nvimConfigDir\queries\twoif", "$nvimConfigDir\queries\2if")

foreach ($dir in $queryDirs) {
    if (Test-Path $dir\highlights.scm) {
        Write-Host "✅ Found: $dir\highlights.scm"
        $content = Get-Content "$dir\highlights.scm" | Select-String "SHELL"
        if ($content.Count -eq 0) {
            Write-Host "   ✅ File looks good (no SHELL references)"
        } else {
            Write-Host "   ❌ File still contains SHELL references!"
            Write-Host "   Fixing..."
            Copy-Item "queries\highlights.scm" "$dir\highlights.scm" -Force
            Write-Host "   ✅ Fixed!"
        }
    } else {
        Write-Host "❌ Missing: $dir\highlights.scm"
        New-Item -Path $dir -ItemType Directory -Force | Out-Null
        Copy-Item "queries\highlights.scm" "$dir\highlights.scm" -Force
        Write-Host "✅ Created: $dir\highlights.scm"
    }
}

Write-Host ""
Write-Host "🎯 Next steps to fix the Neovim error:"
Write-Host "1. Close Neovim completely"
Write-Host "2. Clear any cached parsers/queries:"
Write-Host "   Delete: %LOCALAPPDATA%\nvim-data\lazy\nvim-treesitter\parser (if it exists)"
Write-Host "3. Restart Neovim"
Write-Host "4. In Neovim, run: :TSInstall twoif"
Write-Host "5. Open a .2if file and test"
Write-Host ""
Write-Host "If still having issues, in Neovim run:"
Write-Host "   :TSUninstall twoif"
Write-Host "   :TSInstall twoif"
Write-Host "   :edit (to reload current file)"