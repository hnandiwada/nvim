return {
  {
    "neoclide/coc.nvim",
    branch = "release",
    build = "npm ci",
    config = function()
      vim.g.coc_global_extensions = { "coc-pyright", "coc-eslint", "coc-tsserver" }
    end
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter.install").prefer_git = true
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "python", "lua", "json", "bash", "markdown", "javascript", "typescript", "tsx" },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end
  }
}

