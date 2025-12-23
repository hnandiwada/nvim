vim.opt.exrc = true
vim.opt.secure = true

vim.opt.syntax = "on"

-- Always show absolute and relative line numbers
vim.opt.number = true
vim.opt.relativenumber = false

-- Optional: ensure Signature (marks) is always enabled
vim.g.SignatureEnabledAtStartup = 1

-- Always open vertical splits to the right of the current window
vim.opt.splitright = true

-- Case insensitive search, but case sensitive if uppercase letters are used
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Set fold method to 'indent' for Python files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.opt.foldmethod = "indent"
  end
})

