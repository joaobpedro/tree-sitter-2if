# 🚀 Publishing tree-sitter-2if to GitHub

## Step 1: Create Repository on GitHub
1. Go to https://github.com/new
2. Repository name: `tree-sitter-2if`
3. Description: `Tree-sitter grammar for .2if (RIFLEX input) files with Neovim syntax highlighting`
4. Set as Public (recommended for tree-sitter parsers)
5. Don't initialize with README (we already have one)
6. Click "Create repository"

## Step 2: Push to GitHub
After creating the repository, GitHub will show you commands. Use these:

```bash
# Add the GitHub remote (replace YOUR_USERNAME with your actual GitHub username)
git remote add origin https://github.com/YOUR_USERNAME/tree-sitter-2if.git

# Push to GitHub
git branch -M main
git push -u origin main
```

## Step 3: Update Repository Settings
1. Go to your repository on GitHub
2. Add topics/tags: `tree-sitter`, `neovim`, `syntax-highlighting`, `2if`, `riflex`
3. Update the repository description if needed

## Step 4: Test Installation from GitHub
Once published, users can install it in Neovim with:

```lua
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.twoif = {
  install_info = {
    url = "https://github.com/YOUR_USERNAME/tree-sitter-2if.git",
    files = {"src/parser.c"},
    branch = "main",
  },
  filetype = "2if",
}
```

## 🎉 Your tree-sitter project is ready for the world!

Features included:
✅ Complete tree-sitter grammar for .2if files
✅ Syntax highlighting queries for Neovim
✅ Comprehensive README with installation instructions
✅ Test files and examples
✅ PowerShell utilities for easy setup
✅ Proper .gitignore for tree-sitter projects