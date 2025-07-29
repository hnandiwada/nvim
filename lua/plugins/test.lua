return {
  "vim-test/vim-test",
  config = function()
    if vim.env.TMUX == nil or vim.env.TMUX == "" then
      vim.g["test#strategy"] = "neoterm"
    else
      vim.g["test#strategy"] = "vimux"
    end
  end
}