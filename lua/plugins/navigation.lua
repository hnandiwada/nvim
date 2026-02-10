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

      -- Ignore patterns for fd/rg
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

      -- Global ctrl-s and ctrl-n
      vim.g.fzf_action = {
        ["ctrl-s"] = "split",
        ["ctrl-n"] = "vsplit",
      }

      -- Helper for consistent cwd and homeify
      local function fzf_files(dir)
        local real_dir = vim.fn.fnamemodify(dir, ":p")
        local display_dir = homeify(real_dir)
        local exclusion = table.concat(to_ignore, ",")
        local source = string.format(
          'cd %s && fd --exclude={%s} --type f --no-ignore --strip-cwd-prefix',
          vim.fn.shellescape(real_dir), exclusion
        )

        local wrapped = vim.fn["fzf#wrap"]({
          source = source,
          options = '--prompt="' .. display_dir .. '" --expect=ctrl-n',
        })

        wrapped["sink*"] = function(lines)
          if not lines or #lines == 0 then
            return
          end
          local action = lines[1]
          local file = lines[2] or lines[1]
          local full_path = real_dir .. file

          if action == "ctrl-n" then
            vim.cmd("vsplit " .. vim.fn.fnameescape(full_path))
          else
            vim.cmd("edit " .. vim.fn.fnameescape(full_path))
          end
        end

        vim.fn["fzf#run"](wrapped)
      end

      -- Custom commands with consistent cwd + ~ display
      vim.api.nvim_create_user_command("FZFRg", function(opts)
        local args = table.concat(opts.fargs, " ")
        local cmd = [[rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always" ]] .. args

        local spec = vim.fn["fzf#vim#with_preview"]({
          source = cmd,
          options = '--prompt="rg> " --expect=ctrl-n',
        })

        spec["sink*"] = function(lines)
          if not lines or #lines == 0 then
            return
          end
          local action = lines[1]
          local file_line = lines[2] or lines[1]
          local file, lnum = file_line:match("([^:]+):(%d+)")
          if action == "ctrl-n" then
            vim.cmd("vsplit +" .. lnum .. " " .. vim.fn.fnameescape(file))
          else
            vim.cmd("edit +" .. lnum .. " " .. vim.fn.fnameescape(file))
          end
        end

        vim.fn["fzf#run"](spec)
      end, { bang = true, nargs = "*" })

      vim.api.nvim_create_user_command("FZFFiles", function()
        local real_cwd = vim.fn.fnamemodify(startup_cwd, ":p")
        local display_dir = homeify(real_cwd)

        local wrapped = vim.fn["fzf#wrap"]({
          dir = real_cwd,
          options = '--prompt="' .. display_dir .. '" --expect=ctrl-n',
        })

        wrapped["sink*"] = function(lines)
          if not lines or #lines == 0 then
            return
          end
          local action = lines[1]
          local file = lines[2] or lines[1]

          if action == "ctrl-n" then
            vim.cmd("vsplit " .. vim.fn.fnameescape(file))
          else
            vim.cmd("edit " .. vim.fn.fnameescape(file))
          end
        end

        vim.fn["fzf#run"](wrapped)
      end, { bang = true })

      vim.api.nvim_create_user_command("FZFAllFiles", function()
        local source = "fd --type f --hidden --no-ignore --strip-cwd-prefix"
        local real_cwd = vim.fn.fnamemodify(startup_cwd, ":p")
        local display_dir = homeify(real_cwd)

        local wrapped = vim.fn["fzf#wrap"]({
          source = source,
          dir = real_cwd,
          options = '--prompt="all ' .. display_dir .. '" --expect=ctrl-n',
        })

        wrapped["sink*"] = function(lines)
          if not lines or #lines == 0 then
            return
          end
          local action = lines[1]
          local file = lines[2] or lines[1]

          if action == "ctrl-n" then
            vim.cmd("vsplit " .. vim.fn.fnameescape(file))
          else
            vim.cmd("edit " .. vim.fn.fnameescape(file))
          end
        end

        vim.fn["fzf#run"](wrapped)
      end, { bang = true })

      vim.api.nvim_create_user_command("FZFWorkspaceFiles", function()
        fzf_files(home .. "/workspace")
      end, { bang = true })

      vim.api.nvim_create_user_command("FZFAllWorkspaceFiles", function()
        local ws_dir = vim.fn.fnamemodify(home .. "/workspace", ":p")
        local source = string.format(
          'cd %s && fd --type f --hidden --no-ignore --strip-cwd-prefix',
          vim.fn.shellescape(ws_dir)
        )

        local wrapped = vim.fn["fzf#wrap"]({
          source = source,
          options = '--prompt="all ~/workspace/" --expect=ctrl-n',
        })

        wrapped["sink*"] = function(lines)
          if not lines or #lines == 0 then return end
          local action = lines[1]
          local file = lines[2] or lines[1]
          local full_path = ws_dir .. file
          if action == "ctrl-n" then
            vim.cmd("vsplit " .. vim.fn.fnameescape(full_path))
          else
            vim.cmd("edit " .. vim.fn.fnameescape(full_path))
          end
        end

        vim.fn["fzf#run"](wrapped)
      end, { bang = true })

      vim.api.nvim_create_user_command("FZFHomeFiles", function()
        fzf_files(home)
      end, { bang = true })

      vim.api.nvim_create_user_command("FZFAllHomeFiles", function()
        local home_dir = vim.fn.fnamemodify(home, ":p")
        local source = string.format(
          'cd %s && fd --type f --hidden --no-ignore --strip-cwd-prefix',
          vim.fn.shellescape(home_dir)
        )

        local wrapped = vim.fn["fzf#wrap"]({
          source = source,
          options = '--prompt="all ~/" --expect=ctrl-n',
        })

        wrapped["sink*"] = function(lines)
          if not lines or #lines == 0 then return end
          local action = lines[1]
          local file = lines[2] or lines[1]
          local full_path = home_dir .. file
          if action == "ctrl-n" then
            vim.cmd("vsplit " .. vim.fn.fnameescape(full_path))
          else
            vim.cmd("edit " .. vim.fn.fnameescape(full_path))
          end
        end

        vim.fn["fzf#run"](wrapped)
      end, { bang = true })
    end
  },

  -- FZF Vim bindings
  { "junegunn/fzf.vim", lazy = false },

  -- Vinegar
  { "tpope/vim-vinegar" },
}

