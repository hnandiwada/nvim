<!-- vim: set foldmethod=marker -->

# Plug-ins

This file lists and documents the plugins used in this configuration. They are organized by category.  
Each plugin includes a short description and, where applicable, a screenshot.  

---

## Table of Contents
<!--ts-->
* [Plugin Manager](#plugin-manager)
* [Color Schemes](#color-schemes)
  * [chriskempson/base16-vim](#chriskempsonbase16-vim)
  * [joshdick/onedark.vim](#joshdickonedarkvim)
  * [kadekillary/Turtles](#kadekillaryturtles)
  * [challenger-deep-theme/vim](#challenger-deep-themevim)
* [UI](#ui)
  * [nvim-lualine/lualine.nvim](#nvim-lualinelualinenvim)
  * [mhinz/vim-startify](#mhinzvim-startify)
  * [kshenoy/vim-signature](#kshenoyvim-signature)
  * [folke/which-key.nvim](#folkewhich-keynvim)
* [Editing](#editing)
  * [tpope/vim-commentary](#tpopevim-commentary)
  * [pelodelfuego/vim-swoop](#pelodelfuegovim-swoop)
  * [terryma/vim-expand-region](#terrymavim-expand-region)
  * [AndrewRadev/splitjoin.vim](#andrewradevsplitjoinvim)
  * [junegunn/vim-easy-align](#junegunnvim-easy-align)
  * [matze/vim-move](#matzevim-move)
  * [tpope/vim-surround](#tpopevim-surround)
  * [tpope/vim-repeat](#tpopevim-repeat)
  * [tpope/vim-endwise](#tpopevim-endwise)
  * [tommcdo/vim-exchange](#tommcdovim-exchange)
* [General Tools](#general-tools)
  * [junegunn/fzf](#junegunnfzf)
  * [junegunn/fzf.vim](#junegunnfzfvim)
  * [preservim/nerdtree](#preservimnerdtree)
  * [airblade/vim-gitgutter](#airbladevim-gitgutter)
  * [junegunn/goyo.vim](#junegunngoyovim)
  * [mhinz/vim-sayonara](#mhinzvim-sayonara)
  * [nvim-treesitter/nvim-treesitter](#nvim-treesitternvim-treesitter)
<!--te-->

---

## Plugin Manager <!--{-->

### [`folke/lazy.nvim`](https://github.com/folke/lazy.nvim)

Modern plugin manager for Neovim, written in Lua. Handles lazy-loading, startup optimization,  
and clean plugin management.

This configuration bootstraps `lazy.nvim` in `init.lua` and loads all plugin specs from the `lua/plugins` directory.

```lua
-- init.lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins")

