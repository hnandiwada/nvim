return {
  -- FZF core
  {
    "junegunn/fzf",
    build = "./install --all",
    init = function()
      vim.g.fzf_command_prefix = "FZF"

      -- Store startup CWD
      local startup_cwd = vim.loop.cwd()
      local home = os.getenv("HOME")

      local function homeify(path)
        return path:gsub("^" .. home, "~")
      end

      -- Ignore patterns
      local to_ignore = {
        ".git", "node_modules", "build", "out", "venv", "dist",
        "__pycache__", "*.so", "yarn.lock", "package-lock.json",
        "s_*.py", "serverless_sdk", "tmp-serverless.yml", "cdk.out"
      }

      -- fd/rg defaults
      if vim.fn.executable("fd") == 1 then
        local exclusion = table.concat(to_ignore, ",")
        vim.env.FZF_DEFAULT_COMMAND = string.format(
          'fd --exclude={%s} --type f --no-ignore --strip-cwd-prefix', exclusion
        )
      elseif vim.fn.executable("rg") == 1 then
        local globs = {}
        for _, pat in ipairs(to_ignore) do
          table.insert(globs, string.format("--glob !%s", pat))
        end
        vim.env.FZF_DEFAULT_COMMAND = "rg --files --follow " .. table.concat(globs, " ")
      elseif vim.fn.executable("ag") == 1 then
        vim.env.FZF_DEFAULT_COMMAND = 'ag -g ""'
      end

      -- Layout and preview
      vim.g.fzf_layout = { window = { width = 0.9, height = 0.6 } }
      vim.g.fzf_preview_window = {}
      vim.g.fzf_colors = {
        fg      = { "fg", "Normal" },
        bg      = { "bg", "Normal" },
        hl      = { "fg", "Comment" },
        ["fg+"] = { "fg", "CursorLine", "CursorColumn", "Normal" },
        ["bg+"] = { "bg", "CursorLine", "CursorColumn" },
        ["hl+"] = { "fg", "Statement" },
        info    = { "fg", "PreProc" },
        border  = { "fg", "Ignore" },
        prompt  = { "fg", "Conditional" },
        pointer = { "fg", "Exception" },
        marker  = { "fg", "Keyword" },
        spinner = { "fg", "Label" },
        header  = { "fg", "Comment" },
      }

      vim.g.fzf_history_dir = "~/.local/share/fzf-history"

      -- Helper to run fzf#vim#files with ~ path
      local function fzf_files(dir)
        local display_dir = homeify(dir)
        vim.fn["fzf#vim#files"](display_dir, 0)
      end

      -- Custom commands with consistent cwd + ~ display
      vim.api.nvim_create_user_command("FZFRg", function(opts)
        local args = table.concat(opts.fargs, " ")
        local cmd = [[rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always" ]] .. args
        vim.fn["fzf#vim#grep"](cmd, 1, opts.bang == "!", {})
      end, { bang = true, nargs = "*" })

      vim.api.nvim_create_user_command("FZFWorkspaceFiles", function()
        fzf_files(home .. "/workspace")
      end, { bang = true })

      vim.api.nvim_create_user_command("FZFAllFiles", function()
        local dir = startup_cwd
        local display_dir = homeify(dir)
        vim.fn["fzf#run"](vim.fn["fzf#wrap"]({
          source = string.format("fd --type f --hidden --no-ignore --strip-cwd-prefix", dir),
          dir = dir,
          options = string.format('--prompt="all %s/"', display_dir)
        }))
      end, { bang = true })

      vim.api.nvim_create_user_command("FZFAllWorkspaceFiles", function()
        vim.fn["fzf#run"](vim.fn["fzf#wrap"]({
          source = "fd --type f --hidden --no-ignore --strip-cwd-prefix",
          dir = home .. "/workspace",
          options = '--prompt="all ~/workspace/"'
        }))
      end, { bang = true })

      vim.api.nvim_create_user_command("FZFHomeFiles", function()
        fzf_files(home)
      end, { bang = true })

      vim.api.nvim_create_user_command("FZFAllHomeFiles", function()
        vim.fn["fzf#run"](vim.fn["fzf#wrap"]({
          source = "fd --type f --hidden --no-ignore --strip-cwd-prefix",
          dir = home,
          options = '--prompt="all ~/"'
        }))
      end, { bang = true })

      vim.api.nvim_create_user_command("FZFFiles", function()
        fzf_files(startup_cwd)
      end, { bang = true })
    end
  },

  -- FZF Vim bindings
  { "junegunn/fzf.vim", lazy = false },

  -- Grepper / CtrlSF
  { "mhinz/vim-grepper" },
  { "dyng/ctrlsf.vim" },

  -- Vinegar for netrw
  { "tpope/vim-vinegar" },
}

