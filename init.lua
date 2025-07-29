-- Set leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Capture the directory where Neovim was launched (fixes FZF PWD issue)
local startup_cwd = vim.loop.cwd()
vim.opt.autochdir = false
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.cmd("cd " .. startup_cwd)
  end,
})

-- Stop plugins from changing cwd
vim.g.netrw_keepdir = 0
vim.g.startify_change_to_vcs_root = 0

vim.g.coc_node_path = vim.fn.expand("~/.nvm/versions/node/v18.20.8/bin/node") -- update path

-- Bootstrap Lazy.nvim BEFORE config files
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins
require("lazy").setup("plugins")

-- Load your config
require("config.options")
require("config.keymaps")
require("config.colorscheme")

