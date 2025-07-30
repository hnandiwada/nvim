
<!-- vim: set foldmethod=marker -->

# Plug-ins

This lists, justifies and briefly documents each plug-in included in this distribution. Separating them in categories.
You can find full documentation on the plug-in's github page or by accessing its help (usually at `:h <plugin-name>`).
Most user configuration should be put in your `lua/config` unless otherwise stated on the docs for the plug-in or here.

Table of Contents
=================

<!--ts-->
   * [Plug-ins](#plug-ins)
   * [Table of Contents](#table-of-contents)
      * [Plugin Manager](#plugin-manager)
      * [Color schemes](#color-schemes)
      * [UI - User interface additions](#ui---user-interface-additions)
      * [Editing - Text manipulation](#editing---text-manipulation)
      * [General -- Helpful generic tools](#general----helpful-generic-tools)
<!--te-->

## Plugin Manager

### [`folke/lazy.nvim`](https://github.com/folke/lazy.nvim)

Lazy.nvim is used as the plugin manager to handle installation, updates, and lazy-loading of all plugins.

## Color schemes

### [`chriskempson/base16-vim`](https://github.com/chriskempson/base16-vim)
A collection of 16-color themes.

### [`joshdick/onedark.vim`](https://github.com/joshdick/onedark.vim)
Atom's One Dark theme (currently the default).

### [`kadekillary/Turtles`](https://github.com/kadekillary/Turtles)
Extra color scheme option.

### [`challenger-deep-theme/vim`](https://github.com/challenger-deep-theme/vim)
Challenger Deep theme.

## UI - User interface additions

### [`nvim-lualine/lualine.nvim`](https://github.com/nvim-lualine/lualine.nvim)
Statusline plugin with `onedark` theme applied.

### [`folke/which-key.nvim`](https://github.com/folke/which-key.nvim)
Popup with keybinding hints. Configured with simple arrow separators and no icons.

### [`mhinz/vim-startify`](https://github.com/mhinz/vim-startify)
Start screen showing recent files and sessions with a custom ASCII header.

### [`kshenoy/vim-signature`](https://github.com/kshenoy/vim-signature)
Shows marks in the gutter.

### [`nvim-tree/nvim-web-devicons`](https://github.com/nvim-tree/nvim-web-devicons)
Provides filetype icons for statuslines and file explorers.

## Editing - Text manipulation

### [`tpope/vim-surround`](https://github.com/tpope/vim-surround)
Quoting/parenthesizing made simple; e.g. ysiw) to wrap word in parens.

### [`tpope/vim-repeat`](https://github.com/tpope/vim-repeat)
Enables `.` repeat support for other plugins.

### [`airblade/vim-gitgutter`](https://github.com/airblade/vim-gitgutter)
Git diff signs in the gutter.

### [`tpope/vim-endwise`](https://github.com/tpope/vim-endwise)
Auto-complete `end` in Ruby and other block-structured languages.

### [`tpope/vim-speeddating`](https://github.com/tpope/vim-speeddating)
Use CTRL-A/CTRL-X to increment dates, times, and more.

### [`matze/vim-move`](https://github.com/matze/vim-move)
Move lines and selections with `<C-j>`/`<C-k>`.

### [`terryma/vim-expand-region`](https://github.com/terryma/vim-expand-region)
Incrementally expand and contract visual selections. Use + and - to expand/contract.

### [`tommcdo/vim-exchange`](https://github.com/tommcdo/vim-exchange)
Easy text exchange operator for Vim. cx<motion> in normal mode or X in visual mode. Running again after making a selection (which will be visually highlighted) will swap the two regions.

### [`maxbrunsfeld/vim-emacs-bindings`](https://github.com/maxbrunsfeld/vim-emacs-bindings)
Provides emacs-like keybindings in insert and command modes.

## General -- Helpful generic tools

### [`junegunn/fzf`](https://github.com/junegunn/fzf)
Core FZF fuzzy finder.

### [`junegunn/fzf.vim`](https://github.com/junegunn/fzf.vim)
Vim integration for FZF.

### [`mhinz/vim-grepper`](https://github.com/mhinz/vim-grepper)
Easy grep integration. Trigger with `<leader>sg`

### [`dyng/ctrlsf.vim`](https://github.com/dyng/ctrlsf.vim)
Search and replace in a sidebar.

### [`preservim/nerdtree`](https://github.com/preservim/nerdtree)
File tree explorer with `\`.

### [`tpope/vim-sleuth`](https://github.com/tpope/vim-sleuth)
Auto-detect indent settings per file.

### [`tpope/vim-eunuch`](https://github.com/tpope/vim-eunuch)
Adds handy Unix shell commands to Vim.

### [`Konfekt/FastFold`](https://github.com/Konfekt/FastFold)
Optimizes fold updates.

### [`kevinhwang91/nvim-ufo`](https://github.com/kevinhwang91/nvim-ufo)
Improved folding powered by Treesitter and indent.

### [`mhinz/vim-sayonara`](https://github.com/mhinz/vim-sayonara)
Smart buffer/window closing.

### [`tpope/vim-projectionist`](https://github.com/tpope/vim-projectionist)
Define project structure and alternate files. Use `:A` to switch to the alternate file.

### [`tpope/vim-eunuch`](https://github.com/tpope/vim-eunuch)
Adds handy Unix shell commands to Vim, such as `:Delete` to delete files.

### [`romainl/vim-qf`](https://github.com/romainl/vim-qf)
Enhances the quickfix list.
