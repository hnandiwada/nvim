return {
  -- UFO for better folding
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    config = function()
      require("ufo").setup({
        provider_selector = function()
          return { "treesitter", "indent" }
        end,
        open_fold_hl_timeout = 0, -- disables auto highlight/fold open
        enable_get_fold_virt_text = false, -- disable auto preview text
      })

      -- Disable auto opening folds when entering a buffer
      vim.api.nvim_create_autocmd({ "BufWinEnter", "BufReadPost" }, {
        callback = function()
          vim.opt.foldenable = false
        end
      })
    end
  },

  -- FastFold to avoid auto recomputation on save/open
  {
    "Konfekt/FastFold",
    config = function()
      vim.g.fastfold_savehook = 0
      vim.g.fastfold_fold_command_suffixes = { "x", "X", "a", "A", "o", "O", "c", "C" }
      vim.g.fastfold_skip_filetypes = { "vim", "help" }
    end
  }
}

