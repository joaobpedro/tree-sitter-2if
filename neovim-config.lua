-- Neovim configuration for 2if/twoif language support
-- Add this to your Neovim configuration (init.lua or a plugin file)

-- Set comment string for 2if files
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "twoif", "2if" },
  callback = function()
    -- Set comment string for native commenting (gcc, gc)
    vim.bo.commentstring = "# %s"
    
    -- Also set for older versions or different comment plugins
    vim.b.comment_leader = "#"
  end,
})

-- Ensure filetype detection for .2if files
vim.filetype.add({
  extension = {
    ["2if"] = "twoif",
  },
})

-- Optional: If you're using Comment.nvim plugin, you can also configure it
-- local ft = require('Comment.ft')
-- ft.set('twoif', '# %s')
-- ft.set('2if', '# %s')