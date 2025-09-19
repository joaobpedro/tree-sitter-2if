# Comprehensive Neovim tree-sitter query file finder and fixer
# This will find ALL query files that might contain the problematic SHELL reference

Write-Host "🔍 Searching for ALL query files that might contain SHELL references..."

# Common locations where query files might be stored
$searchPaths = @(
    "$env:USERPROFILE\.config\nvim",
    "$env:LOCALAPPDATA\nvim-data", 
    "$env:LOCALAPPDATA\nvim",
    "$env:APPDATA\nvim",
    "$env:USERPROFILE\AppData\Local\nvim-data",
    "C:\Program Files\Neovim"
)

$foundFiles = @()

foreach ($basePath in $searchPaths) {
    if (Test-Path $basePath) {
        Write-Host "Searching in: $basePath"
        try {
            $files = Get-ChildItem -Path $basePath -Recurse -Filter "*.scm" -ErrorAction SilentlyContinue
            foreach ($file in $files) {
                if ($file.Name -eq "highlights.scm") {
                    $content = Get-Content $file.FullName -ErrorAction SilentlyContinue
                    if ($content -match '"SHELL"') {
                        $foundFiles += $file.FullName
                        Write-Host "❌ Found SHELL reference in: $($file.FullName)" -ForegroundColor Red
                    } else {
                        Write-Host "✅ Clean file: $($file.FullName)" -ForegroundColor Green
                    }
                }
            }
        } catch {
            Write-Host "  (Access denied or path not accessible)" -ForegroundColor Yellow
        }
    }
}

Write-Host ""
Write-Host "📝 Summary:"
if ($foundFiles.Count -gt 0) {
    Write-Host "Found $($foundFiles.Count) problematic query file(s):" -ForegroundColor Red
    foreach ($file in $foundFiles) {
        Write-Host "  - $file" -ForegroundColor Red
    }
    
    Write-Host ""
    Write-Host "🔧 Attempting to fix these files..."
    
    foreach ($file in $foundFiles) {
        try {
            Write-Host "Fixing: $file"
            Copy-Item "queries\highlights.scm" $file -Force
            Write-Host "✅ Fixed!" -ForegroundColor Green
        } catch {
            Write-Host "❌ Failed to fix: $_" -ForegroundColor Red
            Write-Host "You may need to manually replace this file or run as administrator."
        }
    }
} else {
    Write-Host "✅ No problematic query files found!" -ForegroundColor Green
    Write-Host "The issue might be with cached parsers or runtime files."
}

Write-Host ""
Write-Host "🎯 Additional troubleshooting steps:"
Write-Host "1. Close Neovim completely"
Write-Host "2. Delete parser cache directories:"
Write-Host "   - $env:LOCALAPPDATA\nvim-data\lazy\nvim-treesitter\parser"
Write-Host "   - $env:LOCALAPPDATA\nvim-data\site\pack\packer\start\nvim-treesitter\parser"
Write-Host "3. In Neovim, completely reinstall:"
Write-Host "   :TSUninstall twoif"
Write-Host "   :TSUninstall 2if"  
Write-Host "   :TSInstall twoif"
Write-Host "4. Check what query files Neovim is actually loading:"
Write-Host "   :echo nvim_get_runtime_file('queries/twoif/highlights.scm', v:true)"