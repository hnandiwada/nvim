-- Fix syntax highlight redraw
vim.keymap.set("n", "<C-l>", ":nohlsearch<CR>:diffupdate<CR>:syntax sync fromstart<CR><C-l>", { silent = true })

-- coc.nvim snippet mappings
vim.keymap.set("i", "<C-j>", "<Plug>(coc-snippets-expand-jump)", { silent = true })
vim.keymap.set("v", "<C-j>", "<Plug>(coc-snippets-select)", { silent = true })
vim.g.coc_snippet_next = "<C-j>"
vim.g.coc_snippet_prev = "<C-k>"
vim.keymap.set("i", "<M-Space>", 'coc#refresh()', { expr = true, silent = true })

-- ALE navigation
vim.keymap.set("n", "<M-p>", "<Plug>(ale_previous_wrap)", { silent = true })
vim.keymap.set("n", "<M-n>", "<Plug>(ale_next_wrap)", { silent = true })

-- Completion with Tab/Shift-Tab
vim.keymap.set("i", "<Tab>", 'coc#pum#visible() ? coc#pum#next(1) : "\\<Tab>"', { expr = true, silent = true })
vim.keymap.set("i", "<S-Tab>", 'coc#pum#visible() ? coc#pum#prev(1) : "\\<S-Tab>"', { expr = true, silent = true })

-- Copilot accept on Enter
vim.keymap.set("i", "<CR>", 'copilot#Accept("\\<CR>")', { expr = true, silent = true, script = true })
vim.g.copilot_no_tab_map = true

-- Commentary
vim.keymap.set("x", "<C-_>", "<Plug>Commentary")
vim.keymap.set("o", "<C-_>", "<Plug>Commentary")
vim.keymap.set("n", "<C-_>", "<Plug>CommentaryLine")

-- Yank till end of line
vim.keymap.set("n", "Y", "y$")

-- Keep visual selection when shifting
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", "<Tab>", ">gv")
vim.keymap.set("v", "<S-Tab>", "<gv")

-- Save on Enter
vim.keymap.set("n", "<CR>", function()
  return ":w<CR>"
end, { expr = true, silent = true })

-- Emmet leader
vim.g.user_emmet_leader_key = "<leader>e"
vim.g.user_emmet_mode = "nv"

-- Escape clears search
vim.keymap.set("n", "<Esc>", ":noh<CR>", { silent = true })

-- Close buffer
vim.keymap.set("n", "<M-q>", ":Sayonara<CR>", { silent = true })

-- Copy to clipboard
vim.keymap.set("v", "Y", '"+y')

-- Disable plugin default mappings
vim.g.gitgutter_map_keys = 0
vim.g.dispatch_no_maps = 1

-- FZF quick open
vim.keymap.set("n", "<C-p>", ":FZFFiles<CR>", { silent = true })
vim.g.fzf_action = {
  ["ctrl-s"] = "split",
  ["ctrl-n"] = "vsplit",
}

-- restore default quickfix behavior ? 
vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.keymap.set("n", "<CR>", "<CR>", { buffer = true })
  end,
})


-- Coc.nvim goto mappings
vim.keymap.set("n", "gd", "<Plug>(coc-definition)", { silent = true })
vim.keymap.set("n", "gy", "<Plug>(coc-type-definition)", { silent = true })
vim.keymap.set("n", "gi", "<Plug>(coc-implementation)", { silent = true })
vim.keymap.set("n", "gr", "<Plug>(coc-references)", { silent = true })
vim.keymap.set("n", "gG", "<Plug>(coc-declaration)", { silent = true })

-- gD opens definition in vsplit
vim.keymap.set("n", "gD", ":call CocAction('jumpDefinition', 'vsplit')<CR>", { silent = true })


-- GitGutter hunks
vim.keymap.set("n", "]c", "<Plug>(GitGutterNextHunk)")
vim.keymap.set("n", "[c", "<Plug>(GitGutterPrevHunk)")

-- Move plugin key modifier
vim.g.move_key_modifier = "C"

-- Toggle NERDTree
vim.keymap.set("n", "\\", ":NERDTreeToggle %<CR>", { silent = true })

-- ✅ Which-Key mappings (immediate execution with <cmd>)
local wk = require("which-key")
wk.add({
  -- General menu under <leader><space>
  { "<leader><space>", group = "general" },
  { "<leader><space>a", "<cmd>FZFColors<CR>", desc = "Search colorschemes" },
  { "<leader><space>c", "<cmd>FZFCommands<CR>", desc = "Search commands" },
  { "<leader><space>z", "<cmd>Goyo<CR>", desc = "Zen mode" },

  -- Testing
  { "<leader>t", group = "testing" },
  { "<leader>tt", "<cmd>TestNearest<CR>", desc = "Run Nearest" },
  { "<leader>t.", "<cmd>TestLast<CR>", desc = "Run Last" },
  { "<leader>tf", "<cmd>TestFile<CR>", desc = "Run File" },
  { "<leader>ts", "<cmd>TestSuite<CR>", desc = "Run Suite" },
  { "<leader>tg", "<cmd>TestVisit<CR>", desc = "Goto last ran test" },

  -- Files
  { "<leader>f", group = "files" },
  { "<leader>ff", "<cmd>FZFFiles<CR>", desc = "File Search" },
  { "<leader>fF", "<cmd>FZFAllFiles<CR>", desc = "File Search (all)" },
  { "<leader>fw", "<cmd>FZFWorkspaceFiles<CR>", desc = "Workspace Files" },
  { "<leader>fW", "<cmd>FZFAllWorkspaceFiles<CR>", desc = "Workspace Files (all)" },
  { "<leader>f-", "<cmd>FZFHomeFiles<CR>", desc = "File Search (Home)" },
  { "<leader>f_", "<cmd>FZFAllHomeFiles<CR>", desc = "File Search (Home All)" },
  { "<leader>fo", "<cmd>FZFBuffers<CR>", desc = "Open Buffers" },
  { "<leader>fm", "<cmd>FZFHistory<CR>", desc = "Recent Files" },
  { "<leader>f.", "<C-^>", desc = "Last Buffer" },

  -- Hunks
  { "<leader>h", group = "hunks" },
  { "<leader>ht", "<cmd>GitGutterToggle<CR>", desc = "Toggle Git Gutter" },
  { "<leader>hp", "<Plug>(GitGutterPreviewHunk)", desc = "Preview Hunk" },
  { "<leader>hs", "<Plug>(GitGutterStageHunk)", desc = "Stage Hunk" },
  { "<leader>hu", "<Plug>(GitGutterUndoHunk)", desc = "Undo Hunk" },

  -- Git
  { "<leader>g", group = "git" },
  { "<leader>gs", "<cmd>Git<CR>", desc = "Git Status" },
  { "<leader>gd", "<Plug>(GitGutterPreviewHunk)", desc = "Git Diff" },
  { "<leader>ga", "<Plug>(GitGutterStageHunk)", desc = "Git Add Hunk" },
  { "<leader>g.", "<cmd>!git add .<CR>", desc = "Git Add ." },
  { "<leader>gf", "<cmd>Gwrite<CR>", desc = "Git Add File" },
  { "<leader>gu", "<Plug>(GitGutterUndoHunk)", desc = "Undo Hunk" },
  { "<leader>gc", "<cmd>Git commit<CR>", desc = "Commit" },
  { "<leader>gC", "<cmd>Git commit --amend<CR>", desc = "Commit Amend" },
  { "<leader>gp", "<cmd>Git push<CR>", desc = "Push" },
  { "<leader>gP", "<cmd>Git push --force<CR>", desc = "Force Push" },
  { "<leader>gl", "<cmd>FZFCommits<CR>", desc = "Commit Log" },
  { "<leader>gb", "<cmd>Git blame<CR>", desc = "Git Blame" },

  -- Search
  { "<leader>s", group = "search" },
  { "<leader>sg", "<cmd>Grepper<CR>", desc = "Find in directory (quickfix)" },
  { "<leader>sf", "<cmd>FZFRg<CR>", desc = "Find in directory (live)" },
  { "<leader>st", "<cmd>FZFTags<CR>", desc = "Find tags" },
  { "<leader>sl", "<cmd>FZFLines<CR>", desc = "Find lines in open files" },
  { "<leader>sb", "<cmd>FZFBlines<CR>", desc = "Find lines in current buffer" },
  { "<leader>sp", "<Plug>CtrlSFPrompt", desc = "Find in directory (ctrlsf)" },

  -- Buffer
  { "<leader>b", group = "buffer" },
  { "<leader>bd", "<cmd>bd<CR>", desc = "Delete Buffer" },
  { "<leader>bl", "<cmd>b#<CR>", desc = "Last Buffer" },
  { "<leader>bn", "<cmd>bnext<CR>", desc = "Next Buffer" },
  { "<leader>bp", "<cmd>bprevious<CR>", desc = "Previous Buffer" },
  { "<leader>bs", "<cmd>FZFBuffers<CR>", desc = "Search Buffer" },

  -- Language server
  { "<leader>l", group = "language-server" },
  { "<leader>lk", '<cmd>call CocAction("doHover")<CR>', desc = "Hover" },
  { "<leader>ls", "<cmd>FZFTags<CR>", desc = "Symbols" },
  { "<leader>lt", "<cmd>Vista!!<CR>", desc = "Tag Bar" },
  { "<leader>la", "<Plug>(coc-codeaction)", desc = "Code Action", mode = "n" },
  { "<leader>la", "<Plug>(coc-codeaction-selected)", desc = "Code Action", mode = "v" },
  { "<leader>l=", "<Plug>(coc-format)", desc = "Code Format", mode = "n" },
  { "<leader>l=", "<Plug>(coc-format-selected)", desc = "Code Format", mode = "v" },
  { "<leader>lr", "<Plug>(coc-rename)", desc = "Rename" },
  { "<leader>lf", "<Plug>(coc-fix-current)", desc = "Autofix Current" },
})

