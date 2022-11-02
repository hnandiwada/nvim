" Full redraw finxing syntax highlight bugs
nnoremap <silent> <c-l> :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>

" coc.nvim
imap <C-j> <Plug>(coc-snippets-expand-jump)
vmap <C-j> <Plug>(coc-snippets-select)
let g:coc_snippet_next = '<c-j>'
let g:coc_snippet_prev = '<c-k>'
inoremap <silent><expr> <M-space> coc#refresh()

" ALE
nmap <silent> <M-p> <Plug>(ale_previous_wrap)
nmap <silent> <M-n> <Plug>(ale_next_wrap)

" Eanble completion with tab/shift-tab
inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"

" Use enter for copilot
imap <silent><script><expr> <CR> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true


" Extra commentary mappings
xmap <c-_>  <Plug>Commentary
omap <c-_>  <Plug>Commentary
nmap <c-_>  <Plug>CommentaryLine

" Mimic behavior from D, C
nnoremap Y y$

vnoremap > >gv
vnoremap < <gv

vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" Save with enter
function! keyboard#should_save_on_enter()
  return bufname('%') !=# 'swoopBuf' && empty(&buftype)
endfunction
nnoremap <silent> <expr> <CR> keyboard#should_save_on_enter() ? ':w<CR>' : '<CR>'

" Emmet
let g:user_emmet_leader_key='<leader>e'
let g:user_emmet_mode='nv'              " only enable normal and visual mode functions

" Escape to clear search
nnoremap <silent> <esc> :noh<cr>

" Close and delete buffer
nnoremap <silent> <M-q> :Sayonara<cr>

" Copy to system clipboard
vnoremap Y "+y

" Disable plugin mappings
let g:swoopUseDefaultKeyMap = 0
let g:gitgutter_map_keys = 0
let g:dispatch_no_maps = 1

" Current file's path in command mode
" cnoremap <expr> %% expand('%:h').'/'

nnoremap <silent> <c-p> :FZFFiles<CR>
" Bind ctrl-n to open FZF window in vsplit
let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-s': 'split',
      \ 'ctrl-n': 'vsplit'
      \ }

" Leader mappings {{{
" Leader is <Space>
let g:mapleader=' '
let g:maplocalleader = ','

nnoremap <silent><nowait> <leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent><nowait> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>
nnoremap <silent><nowait> <localleader> :<c-u>WhichKey  ','<CR>
vnoremap <silent><nowait> <localleader> :<c-u>WhichKeyVisual ','<CR>

call which_key#register('<Space>', "g:leader_key_map")

let g:leader_key_map=  {}

let g:leader_key_map[' '] = {
      \ 'name': '+general',
      \ 's': ['Startify',      'Home Buffer'],
      \ 'c': [':FZFCommands', 'Search commands'],
      \ 'a': [':FZFColors',  'Search colorshcemes'],
      \ 'f': [':FocusMode',  'Focus-mode: remove gutter info for a cleaner experience'],
      \ 'z': [':Goyo',  'Zen-mode: distraction free editing'],
      \ }

let g:leader_key_map.t = {
      \ 'name': '+testing',
      \ 't': [':TestNearest', 'Run Nearest'],
      \ '.': [':TestLast',    'Run Last'],
      \ 'f': [':TestFile',    'Run File'],
      \ 's': [':TestSuite',   'Run Suite'],
      \ 'g': [':TestVisit',   'Goto last ran test'],
      \ }

let g:leader_key_map.f = {
      \ 'name': '+files',
      \ 'f': [':FZFFiles',          'File Search in Opened Directory'],
      \ 'F': [':FZFAllFiles',          'File Search in Opened Directory (all)'],
      \ 'w': [':FZFWorkspaceFiles',          'File Search in Workspace'],
      \ 'W': [':FZFAllWorkspaceFiles',          'File Search in Workspace (all)'],
      \ '-': [':FZFHomeFiles',          'File Search in Home'],
      \ '_': [':FZFAllHomeFiles',          'File Search in Home (all)'],
      \ 'o': [':FZFBuffers',        'Open Buffer Search'],
      \ 'm': [':FZFHistory',        'Recent Files Search'],
      \ '.': ['<c-^>',                'Goto Last Buffer'],
      \ }

let g:leader_key_map.h = {
      \ 'name': '+hunks',
      \ 't': [':GitGutterToggle',             'Toggle Git Gutter'],
      \ 'p': ['<Plug>(GitGutterPreviewHunk)', 'Preview Hunk'],
      \ 's': ['<Plug>(GitGutterStageHunk)',   'Stage Hunk'],
      \ 'u': ['<Plug>(GitGutterUndoHunk)',    'Undo Hunk'],
      \ }

let g:leader_key_map.g = {
      \ 'name': '+git',
      \ 's': [':Git',   'Git Status'],
      \ 'd': ['<Plug>(GitGutterPreviewHunk)', 'Git Diff'],
      \ 'a': ['<Plug>(GitGutterStageHunk)',   'Git Add Hunk'],
      \ '.': [':!git add .',   'Git Add .'],
      \ 'f': [':Gwrite',   'Git Add File'],
      \ 'u': ['<Plug>(GitGutterUndoHunk)',    'Undo Hunk'],
      \ 'c': [':Git commit',    'Commit'],
      \ 'C': [':Git commit --amend',   'Commit Amend'],
      \ 'p': [':Git push',    'Push'],
      \ 'P': [':Git push --force',    'Force Push'],
      \ 'l': [':FZFCommits',    'Commit Log'],
      \ 'b': [':Git blame',    'Git Blame'],
      \ }

let g:leader_key_map.s = {
      \ 'name': '+search',
      \ 'g': ['Grepper',            'Find in directory (quickfix)'],
      \ 'f': [':FZFRg ',        'Find in directory (live)'],
      \ 't': [':FZFTags',     'Find tags'],
      \ 'l': [':FZFLines',        'Find lines in open files'],
      \ 'b': [':FZFBlines',       'Find lines in current buffer'],
      \ 'p': ['<Plug>CtrlSFPrompt', 'Find in directory (ctrlsf)'],
      \ }

let g:leader_key_map.c = {
      \ 'name': '+cscope',
      \ 's': [':cs find s <cword>', 'Cscope Symbol'],
      \ 'g': [':cs find g <cword>', 'Cscope Definition'],
      \ 'c': [':cs find c <cword>', 'Cscope Callers'],
      \ 'd': [':cs find d <cword>', 'Cscope Callees'],
      \ 'a': [':cs find a <cword>', 'Cscope Assignments'],
      \ 'o': [':cs add cscope.out', 'Cscope Open Database'],
      \
      \ 'z': [':!sh -xc ''starscope -e cscope -e ctags''', 'Cscope Build Database'],
      \ }


let g:leader_key_map.e = { 'name': '+emmet' }

let g:leader_key_map.l = {
      \ 'name': '+language-server',
      \ 'k': [':call CocAction("doHover")',    'Hover'],
      \ 's': [':FZFTags',                    'Symbols'],
      \ 't': [':Vista!!',                      'Tag Bar'],
      \ }

nmap <silent> <leader>la <Plug>(coc-codeaction)
vmap <silent> <leader>la <Plug>(coc-codeaction-selected)
let g:leader_key_map.l.a = 'Code Action'

nmap <silent> <leader>l= <Plug>(coc-format)
vmap <silent> <leader>l= <Plug>(coc-format-selected)
let g:leader_key_map.l['='] = 'Code Format'

nmap <silent> <leader>lr <Plug>(coc-rename)
let g:leader_key_map.l.r = 'Rename'

nmap <silent> <leader>lf <Plug>(coc-fix-current)
let g:leader_key_map.l.f = 'Autofix Current'

let g:leader_key_map.b = {
      \ 'name' : '+buffer' ,
      \ 'd': ['bd',            'Delete Buffer'],
      \ 'h': ['Startify',      'Home Buffer'],
      \ 'l': ['b#',            'Last Buffer'],
      \ 'n': ['bnext',         'Next Buffer'],
      \ 'p': ['bprevious',     'Previous Buffer'],
      \ 's': [':FZFBuffers', 'Search Buffer'],
      \ }

" }}}

" g mappings {{{

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gG <Plug>(coc-declaration)
" open in new split with gD
nmap <silent> gD :call CocAction('jumpDefinition', 'vsplit')<CR>
" g* searches under cursor

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(LiveEasyAlign)
" TODO investigate

" These unfortunately would make it so defaults don't work, so we can't yet
" have a menu for non leader mappings.

" nnoremap <silent> g :<c-u>WhichKey 'g'<CR>
" vnoremap <silent> g :<c-u>WhichKeyVisual 'g'<CR>

" call which_key#register('g', "g:g_key_map")

" let g:g_key_map=  {}

" let g:g_key_map.d = 'Go to definition'
" let g:g_key_map.y = 'Go to type'
" let g:g_key_map.i = 'Go to implementation'
" let g:g_key_map.r = 'Find references'

" let g:g_key_map['#'] = 'which_key_ignore'
" let g:g_key_map['*'] = 'which_key_ignore'
" let g:g_key_map['F'] = 'which_key_ignore'
" let g:g_key_map['/'] = 'which_key_ignore'
" let g:g_key_map['b'] = 'which_key_ignore'
" let g:g_key_map['%'] = 'which_key_ignore'
" let g:g_key_map['x'] = 'which_key_ignore'

" " from plugins

" " splitjoin
" let g:g_key_map.J = 'Smart join lines'
" let g:g_key_map.S = 'Smart split lines'

" " swap
" let g:g_key_map['<'] = 'Swap left'
" let g:g_key_map['>'] = 'Swap right'
" let g:g_key_map.s = 'Swap Mode'

" " commentary
" let g:g_key_map.c = 'Comment (<control-/>)'
" let g:g_key_map.cc = 'which_key_ignore'

" }}}

" [] mappings {{{

" hunk jumping (changes)
nmap ]c <Plug>(GitGutterNextHunk)
nmap [c <Plug>(GitGutterPrevHunk)

" highlight text and move it with <C-j> etc
let g:move_key_modifier = 'C'

" toggle NERDTree
nnoremap \ :NERDTreeToggle %<CR>
" }}}

