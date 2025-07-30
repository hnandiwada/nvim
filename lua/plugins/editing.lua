return {
  { "tpope/vim-commentary", event = "BufRead" },
  { "mg979/vim-visual-multi", branch = "master" },
  { "terryma/vim-expand-region" },
  { "tpope/vim-endwise" },
  { "rstacruz/vim-closer" },
  { "tpope/vim-surround" },
  { "tpope/vim-repeat" },
  { "maxbrunsfeld/vim-emacs-bindings" },
  { 
    "matze/vim-move",
    init = function()
      vim.g.move_key_modifier = "C"
    end
  },
  { "tpope/vim-speeddating" },
  { "tommcdo/vim-exchange" },
  { "mhinz/vim-sayonara" }
}
