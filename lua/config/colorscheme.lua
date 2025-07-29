if vim.g.colors_name == nil then
  vim.g.lightline = { colorscheme = "onedark" }
  vim.o.background = "dark"
  vim.cmd.colorscheme("onedark")
end
vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#646d82" })
