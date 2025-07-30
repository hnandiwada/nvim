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
        open_fold_hl_timeout = 0,
        enable_get_fold_virt_text = true, -- enable custom preview
        fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
          local line_start = vim.fn.getline(lnum):gsub("^%s*", "")
          local line_end = vim.fn.getline(endLnum):gsub("^%s*", "")
          local fold_size = endLnum - lnum + 1
          local text = line_start .. " … " .. fold_size .. " lines … " .. line_end
          return { { text, "Folded" } }
        end
      })

      -- Disable auto opening folds when entering a buffer
      vim.api.nvim_create_autocmd({ "BufWinEnter", "BufReadPost" }, {
        callback = function()
          vim.opt.foldenable = false
        end
      })

      -- Global folding settings
      vim.opt.foldlevel = 99
      vim.opt.foldlevelstart = 99
      vim.opt.foldenable = false
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
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

