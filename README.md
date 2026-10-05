Originally forked from [luan/vimfiles](https://github.com/luan/vimfiles).

Key commands include:
- `brew install tree-sitter-cli`
- `git clone git@github.com:hnandiwada/nvim.git ~/.config/nvim`
- `pip3 install ruff`
- `brew install fd`
- `brew install node` (coc.nvim needs Node; no npm/yarn install is needed in this repo)
- `:CocInstall coc-prettier` (coc-pyright, coc-eslint, coc-tsserver auto-install via `coc_global_extensions`)
- `brew install --cask font-jetbrains-mono-nerd-font`

Updating everything:
- `:Lazy sync` (plugins)
- `:CocUpdate` (coc extensions, including the bundled pyright)
- `:TSUpdate` (treesitter parsers)
