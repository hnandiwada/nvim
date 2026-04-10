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
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install({ "python", "json", "bash", "markdown", "javascript", "typescript", "tsx" })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "python", "json", "bash", "markdown", "javascript", "typescript", "tsx" },
        callback = function() vim.treesitter.start() end,
      })
    end
  }
}

