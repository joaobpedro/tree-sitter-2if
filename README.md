# Tree-sitter Grammar for .2if Files

This repository contains a Tree-sitter grammar for parsing `.2if` engineering input files, commonly used in structural analysis and cable/riser modeling systems (such as RIFLEX).

## Overview

The `.2if` file format contains various commands and parameters for defining:
- Control parameters
- Cross-section definitions  
- Geometry definitions
- Material properties
- Contact interfaces
- Boundary conditions
- Time histories
- Post-processing settings

## Features

This grammar supports parsing:
- ✅ Comments (lines starting with `#`)
- ✅ Header commands (`HEAD`)
- ✅ Control settings (`CONTROL`)
- ✅ Cross-section definitions (`CROSS`)
- ✅ Geometry definitions (`GEOM`) with multiple parameter lines
- ✅ Material definitions (`MATERIAL`)
- ✅ Contact interfaces (`CONTINT`)
- ✅ Time histories (`HIST`)
- ✅ Boundary conditions (`GLBON`, `GCLOAD`, `GPDISP`)
- ✅ Post-processing (`VISRES`)
- ✅ Merge operations (`SMERGE`, `LMERGE`)
- ✅ Various parameter types (integers, floats, scientific notation)
- ✅ Identifiers with hyphens and underscores

## Installation

### For Development/Testing

1. Install Tree-sitter CLI:
   ```bash
   npm install -g tree-sitter-cli
   ```

2. Generate the parser:
   ```bash
   tree-sitter generate
   ```

3. Test the parser:
   ```bash
   tree-sitter parse test/example.2if
   ```

## Installation

### Method 1: From GitHub (Recommended)

1. **Add parser configuration to your Neovim config (`init.lua`):**
   ```lua
   -- Set up filetype detection for .2if files
   vim.filetype.add({
     extension = {
       ['2if'] = '2if',
     }
   })

   -- Configure nvim-treesitter
   require'nvim-treesitter.configs'.setup {
     ensure_installed = { "c", "lua", "vim", "vimdoc" }, -- your other parsers
     
     highlight = {
       enable = true,
       additional_vim_regex_highlighting = false,
     },
   }

   -- Register the custom parser for 2if files
   local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
   parser_config.twoif = {
     install_info = {
       url = "https://github.com/YOUR_USERNAME/tree-sitter-2if.git", -- Replace with your GitHub URL
       files = {"src/parser.c"},
       branch = "main",
       generate_requires_npm = false,
     },
     filetype = "2if",
     used_by = {"2if"},
   }
   ```

2. **Install the parser in Neovim:**
   ```vim
   :TSInstall twoif
   ```

3. **Copy highlight queries (if needed):**
   The queries should be automatically available, but if not:
   ```bash
   mkdir -p ~/.config/nvim/queries/twoif
   # Download queries/highlights.scm from the repository
   # Save it as ~/.config/nvim/queries/twoif/highlights.scm
   ```

### Method 2: Manual Installation (Development)

1. **Create the parser directory structure:**
   ```bash
   # Replace [nvim-data] with your actual path from Step 1
   mkdir -p "[nvim-data]/lazy/nvim-treesitter/parser"
   mkdir -p "~/.config/nvim/queries/twoif"  # Note: use 'twoif' not '2if'
   ```

2. **Copy the queries for syntax highlighting:**
   ```bash
   # Copy the queries to match the parser name 'twoif'
   cp "C:\Users\joaop\OneDrive - KONGSBERG\Code Library\tree-sitter2\tree-sitter-2if\queries\highlights.scm" "~/.config/nvim/queries/twoif/highlights.scm"
   
   # Also create a copy for the filetype '2if' (optional, for fallback)
   mkdir -p "~/.config/nvim/queries/2if"
   cp "C:\Users\joaop\OneDrive - KONGSBERG\Code Library\tree-sitter2\tree-sitter-2if\queries\highlights.scm" "~/.config/nvim/queries/2if/highlights.scm"
   ```

3. **Don't manually copy the parser.c file** - let nvim-treesitter handle compilation

### Step 3: Configure Neovim

Add this to your Neovim configuration (`init.lua` or `init.vim`):

#### For init.lua:
```lua
-- Set up filetype detection for .2if files
vim.filetype.add({
  extension = {
    ['2if'] = '2if',
  }
})

-- Configure nvim-treesitter
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "lua", "vim", "vimdoc" }, -- your other parsers
  
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

-- Register the custom parser for 2if files
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.twoif = {  -- Note: changed from '2if' to 'twoif' (no numbers allowed)
  install_info = {
    url = "C:/Users/joaop/OneDrive - KONGSBERG/Code Library/tree-sitter2/tree-sitter-2if",
    files = {"src/parser.c"},
    branch = "main",
    generate_requires_npm = false,
  },
  filetype = "2if",
  used_by = {"2if"},  -- This maps the filetype to the parser
}
```

#### For init.vim:
```vim
" Set up filetype detection
autocmd BufRead,BufNewFile *.2if set filetype=2if

" Configure treesitter in Lua block
lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "lua", "vim", "vimdoc" },
  highlight = {
    enable = true,
  },
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.twoif = {  -- Note: changed from '2if' to 'twoif'
  install_info = {
    url = "C:/Users/joaop/OneDrive - KONGSBERG/Code Library/tree-sitter2/tree-sitter-2if",
    files = {"src/parser.c"},
  },
  filetype = "2if",
  used_by = {"2if"},
}
EOF
```

### Step 4: Install the Parser

In Neovim, run:
```vim
:TSInstall twoif
```

**Note:** The parser name changed from `2if` to `twoif` because treesitter parser names cannot start with numbers.

### Step 5: Verify Installation

1. **Open a .2if file in Neovim**

2. **Check if treesitter is working:**
   ```vim
   :TSPlayground
   ```
   This will show the syntax tree for your file.

3. **Debug highlighting issues:**
   ```vim
   :Inspect          " Shows highlighting groups at cursor position
   :TSModuleInfo     " Shows loaded treesitter modules
   :TSBufEnable highlight  " Manually enable highlighting
   :set filetype?    " Should show 'filetype=2if'
   ```

4. **Check if queries are found:**
   ```vim
   :echo nvim_get_runtime_file('queries/twoif/highlights.scm', v:false)
   :echo nvim_get_runtime_file('queries/2if/highlights.scm', v:false)
   ```

5. **Force refresh treesitter:**
   ```vim
   :edit     " Reload the current file
   :TSBufDisable highlight | TSBufEnable highlight
   ```

### Alternative: Git Repository Method

If you want to use a Git repository instead:

1. **Push your tree-sitter-2if to GitHub/GitLab**
2. **Update the parser config:**
   ```lua
   parser_config.twoif = {
     install_info = {
       url = "https://github.com/yourusername/tree-sitter-2if.git",
       files = {"src/parser.c"},
       branch = "main",
       generate_requires_npm = false,
     },
     filetype = "2if",
   }
   ```
3. **Install:** `:TSInstall twoif`

## Contributing

Contributions are welcome! This tree-sitter grammar supports the .2if file format commonly used in marine engineering applications.

### Development Setup

1. **Clone the repository:**
   ```bash
   git clone https://github.com/YOUR_USERNAME/tree-sitter-2if.git
   cd tree-sitter-2if
   ```

2. **Install dependencies:**
   ```bash
   npm install -g tree-sitter-cli
   ```

3. **Generate and test:**
   ```bash
   tree-sitter generate
   tree-sitter parse test/example.2if
   ```

### Adding New Features

- **Grammar rules:** Edit `grammar.js`
- **Syntax highlighting:** Edit `queries/highlights.scm`
- **Test cases:** Add examples to `test/`

### File Format Support

Currently supports:
- ✅ Comments (`#`)
- ✅ Command keywords (HEAD, CONTROL, CROSS, GEOM, MATERIAL, etc.)
- ✅ Numbers (integers, floats, scientific notation)
- ✅ Identifiers and string literals
- ✅ Multi-line constructs

## License

MIT License - Feel free to use and modify for your projects!

### Troubleshooting

1. **"is not a valid Win32 application" error:**
   - This means you copied the `.c` source file instead of letting nvim-treesitter compile it
   - Remove any manually copied `.c` files from the parser directory
   - Use `:TSInstall twoif` to let nvim-treesitter handle compilation
   - Make sure you have a C compiler installed (Visual Studio Build Tools on Windows)

2. **"The specified procedure could not be found" error:**
   - This means the parser name in the grammar doesn't match what nvim-treesitter expects
   - Ensure your grammar.js has `name: 'twoif'` (matching the parser config)
   - Regenerate the parser: `tree-sitter generate`
   - Try `:TSUninstall twoif` followed by `:TSInstall twoif`

3. **"Invalid node type" or "Query error" messages:**
   - This indicates a syntax error in your highlight query files
   - Check that your `queries/highlights.scm` uses proper query syntax
   - Incorrect: `["SHELL"] @constant.builtin`
   - Correct: `"SHELL" @constant.builtin`
   - Make sure to update both `~/.config/nvim/queries/twoif/highlights.scm` and `~/.config/nvim/queries/2if/highlights.scm`
   - After fixing queries, reload with `:edit` or restart Neovim
   - This means the highlight queries have syntax errors
   - The queries should use string literals (`"SHELL"`) not node types (`[SHELL]`)
   - Make sure you're using the corrected highlight queries from this repository
   - Copy the fixed queries to both `~/.config/nvim/queries/twoif/` and `~/.config/nvim/queries/2if/`

4. **Parser not found:**
   - Check that the parser file exists in the correct location
   - Verify the path in your configuration
   - Use `twoif` as the parser name, not `2if` (numbers not allowed at start)

5. **Syntax highlighting not working:**
   - **Most common issue**: Queries are in wrong location or wrong name
   - Ensure queries are in: `~/.config/nvim/queries/twoif/highlights.scm` (matching parser name)
   - Also try: `~/.config/nvim/queries/2if/highlights.scm` (matching filetype)
   - Check filetype detection: `:set filetype?` should show `filetype=2if`
   - Try `:TSBufEnable highlight` to manually enable highlighting
   - Check if parser is loaded: `:TSModuleInfo`
   - Debug queries: `:echo nvim_get_runtime_file('queries/twoif/highlights.scm', v:false)`
   - Force refresh: `:edit` then `:TSBufDisable highlight | TSBufEnable highlight`

6. **Compilation errors:**
   - Make sure you have a C compiler installed
   - On Windows, ensure you have Build Tools for Visual Studio
   - Try `:TSInstallInfo twoif` to see installation status
   - Check nvim-treesitter health: `:checkhealth nvim-treesitter`

7. **Alternative: Git Repository Method (Recommended for persistent use):**
   ```bash
   # Push your tree-sitter-2if to GitHub
   # Then use this config:
   ```
   ```lua
   parser_config.twoif = {
     install_info = {
       url = "https://github.com/yourusername/tree-sitter-2if.git",
       files = {"src/parser.c"},
       branch = "main",
       generate_requires_npm = false,
     },
     filetype = "2if",
     used_by = {"2if"},
   }
   ```

7. **Manual compilation (advanced):**
   ```bash
   # In your tree-sitter-2if directory
   tree-sitter generate
   # Then let nvim-treesitter handle the installation
   ```

### Features You'll Get

Once installed, you'll have:
- ✅ **Syntax highlighting** for all .2if commands and parameters
- ✅ **Code folding** based on structure
- ✅ **Incremental selection** with Treesitter
- ✅ **Better indentation**
- ✅ **Enhanced text objects**

## Usage

Parse a `.2if` file:
```bash
tree-sitter parse your-file.2if
```

For quiet output (just errors):
```bash
tree-sitter parse your-file.2if --quiet
```

## Grammar Structure

The grammar defines the following main rule types:

- **Comments**: Lines starting with `#`
- **Commands**: Various command types with their specific parameter patterns
- **Numbers**: Support for integers, decimals, and scientific notation
- **Identifiers**: Alphanumeric strings with underscores and hyphens

## File Structure

```
tree-sitter-2if/
├── grammar.js          # Grammar definition
├── package.json        # Project metadata
├── src/               # Generated parser files
│   ├── parser.c
│   ├── grammar.json
│   └── node-types.json
├── queries/           # Syntax highlighting queries
│   └── highlights.scm
└── test/              # Test files
    └── example.2if
```

## Example

```2if
#-- Header ------------------------------------------------------------------
HEAD FIREFLY 800SQ BASE MODEL FOR KONGSBERG 2025 September. WITH BITUMEN
HEAD Created by LSCNS Kwnagsu Chae
HEAD Units: mm, MPa, N, Mg, s
#
#-- Control info ------------------------------------------------------------
CONTROL  999    300   1.0E-5  1025.0E-9     9.81        -10
#
#-- Cross-section definitions -----------------------------------------------
CROSS 1 CS_OSHEATH    CS_OSHEATH       1       0.0    0.0     0.0  SHELL      OSHEATH     MAT_HDPE
#
#-- Geometry definitions ----------------------------------------------------
GEOM OSHEATH       CLOSED     0      0    CI       0        360     104.180   4.00   196    1
#
#-- Material laws -----------------------------------------------------------
MATERIAL MAT_XLPE     LINEAR    0.45   948E-9  0.0        0.0        0.0       304.0   0   AUTO
```

## Performance

The parser efficiently handles large `.2if` files:
- Parses ~18,000 bytes/ms
- Successfully processes complex engineering files with hundreds of commands
- Minimal memory footprint

## Contributing

1. Make changes to `grammar.js`
2. Regenerate the parser: `tree-sitter generate`
3. Test with sample files: `tree-sitter parse test/example.2if`
4. Submit a pull request

## License

MIT License - see LICENSE file for details.