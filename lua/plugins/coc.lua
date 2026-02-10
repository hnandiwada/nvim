return {
  {
    "neoclide/coc.nvim",
    branch = "release",
    build = "npm ci",
    config = function()
      vim.g.coc_global_extensions = { "coc-pyright" }
    end
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter.install").prefer_git = true
      require("nvim-treesitter.config").setup({
        ensure_installed = { "python", "lua", "json", "bash", "markdown" },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end
  }
}

