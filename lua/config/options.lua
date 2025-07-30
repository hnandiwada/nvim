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

-- Always open horizontal splits below the current window
vim.opt.splitbelow = true

-- Case insensitive search, but case sensitive if uppercase letters are used
vim.opt.ignorecase = true
vim.opt.smartcase = true
