return {
  {
    "mhinz/vim-grepper",
    config = function()
      local startup_cwd = vim.loop.cwd()

      vim.g.grepper = {
        tools = { "rg", "git" },
        simple_prompt = 0,
        quickfix = 1,
      }

      vim.api.nvim_create_autocmd("User", {
        pattern = "Grepper",
        callback = function()
          -- Ensure Grepper runs from the Neovim launch dir
          vim.cmd("lcd " .. startup_cwd)

          vim.defer_fn(function()
            for _, win in ipairs(vim.api.nvim_list_wins()) do
              local bufnr = vim.api.nvim_win_get_buf(win)
              if vim.bo[bufnr].buftype == "quickfix" then
                vim.api.nvim_set_current_win(win)
                break
              end
            end
          end, 150)
        end,
      })

    end,
  },

  {
    "romainl/vim-qf",
    config = function()
      vim.g.qf_auto_open_quickfix = 1
      vim.g.qf_auto_resize = 1
    end,
  },

  { "dyng/ctrlsf.vim" },
}

