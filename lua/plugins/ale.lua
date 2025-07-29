return {
  "dense-analysis/ale",
  event = "BufRead",
  config = function()
    vim.g.ale_sign_error = "✘"
    vim.g.ale_sign_warning = "➤"
    vim.g.ale_sign_info = "➟"
    vim.g.ale_fix_on_save = 1
  end
}