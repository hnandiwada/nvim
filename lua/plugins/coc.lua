return {
  {
    "neoclide/coc.nvim",
    branch = "release",
    build = "npm ci",
    config = function()
      -- Auto-inject ruff-lsp settings into coc-settings.json if missing
      local coc_config_path = vim.fn.stdpath("config") .. "/coc-settings.json"
      local default_config = {
        languageserver = {
          ruff = {
            command = "ruff-lsp",
            filetypes = { "python" }
          }
        },
        ["python.formatting.provider"] = "ruff"
      }

      local function ensure_coc_config()
        local json = vim.fn.readfile(coc_config_path)
        local content = table.concat(json, "\n")
        if content == "" then
          vim.fn.writefile({ vim.fn.json_encode(default_config) }, coc_config_path)
        else
          -- Merge ruff config if not present
          local ok, parsed = pcall(vim.fn.json_decode, content)
          if ok and not parsed.languageserver then
            parsed.languageserver = default_config.languageserver
            parsed["python.formatting.provider"] = "ruff"
            vim.fn.writefile({ vim.fn.json_encode(parsed) }, coc_config_path)
          end
        end
      end

      ensure_coc_config()
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

