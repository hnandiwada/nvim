return {
  {
    "tpope/vim-projectionist",
    lazy = false,
    config = function()
      local python_projections = {
        ["*.py"] = {
          type = "python",
          alternate = "test/units/{}_test.py",
        },
        ["test/units/*_test.py"] = {
          type = "python",
          alternate = "{}.py",
        },
        ["integrations/*/integration.py"] = {
          type = "python",
          alternate = "test/integrations/{}_test.py",
        },
        ["test/integrations/*_test.py"] = {
          type = "python",
          alternate = "integrations/{}/integration.py",
        },
      }

      -- Detect Python files and apply projections dynamically
      vim.api.nvim_create_autocmd("User", {
        pattern = "ProjectionistDetect",
        callback = function()
          if vim.bo.filetype == "python" then
            vim.fn["projectionist#append"](vim.fn.getcwd(), python_projections)
          end
        end,
      })

      -- Set foldmethod for Python automatically
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "python",
        callback = function()
          vim.opt_local.foldmethod = "indent"
        end,
      })

      -- Mappings to jump between source/test files
      vim.keymap.set("n", "<leader>a", ":A<CR>", { silent = true, desc = "Alternate File" })
      vim.keymap.set("n", "<leader>v", ":AV<CR>", { silent = true, desc = "Alternate Vertical Split" })
      vim.keymap.set("n", "<leader>s", ":AS<CR>", { silent = true, desc = "Alternate Horizontal Split" })
      vim.keymap.set("n", "<leader>t", ":AT<CR>", { silent = true, desc = "Alternate Tab" })
    end
  }
}

