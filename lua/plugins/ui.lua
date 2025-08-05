return {
  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "onedark",
          icons_enabled = true
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch" },
          lualine_c = {
            {
              "filename",
              path = 1, -- 👈 This makes the path relative to cwd
            },
          },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      })
    end
  },

  -- Color schemes
  { "chriskempson/base16-vim" },
  { "joshdick/onedark.vim", lazy = false },
  { "kadekillary/Turtles" },
  { "challenger-deep-theme/vim", name = "challenger-deep" },

  -- WhichKey (icons disabled)
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("which-key").setup({
        icons = {
          breadcrumb = "",
          separator = "→",
          group = "",
        },
        win = { border = "single" }
      })
    end
  },

  -- Marks
  { "kshenoy/vim-signature", event = "BufRead" },

  -- Startify
  {
    "mhinz/vim-startify",
    lazy = false,
    config = function()
      vim.g.startify_lists = {
        { type = "files", header = { "MRU" } },
        { type = "sessions", header = { "Sessions" } },
        { type = "bookmarks", header = { "Bookmarks" } }
      }
      vim.g.startify_custom_header = {
        "                       █▀▀▄ █▀▀ █▀▀█ ▀█░█▀ ░▀░ █▀▄▀█",
        "                       █░░█ █▀▀ █░░█ ░█▄█░ ▀█▀ █░▀░█",
        "                       ▀░░▀ ▀▀▀ ▀▀▀▀ ░░▀░░ ▀▀▀ ▀░░░▀",
      }
    end
  },

  -- File tree
  { "preservim/nerdtree", cmd = "NERDTreeToggle" },

  -- GitGutter (always on with signs)
  {
    "airblade/vim-gitgutter",
    lazy = false,
    config = function()
      vim.opt.number = true
      vim.opt.relativenumber = false
      vim.opt.signcolumn = "yes"
      vim.g.gitgutter_enabled = 1

      -- Enable on startup
      vim.defer_fn(function()
        vim.cmd("GitGutterEnable")
      end, 100)

      -- Force refresh on write and when text changes
      vim.api.nvim_create_autocmd({ "BufWritePost", "TextChanged", "TextChangedI" }, {
        callback = function()
          vim.cmd("GitGutter")
        end
      })
    end
  },

  -- Devicons (always loaded)
  {
    "nvim-tree/nvim-web-devicons",
    lazy = false,
    config = function()
      require("nvim-web-devicons").setup({
        default = true,
        override = {},
      })
    end
  },
}

