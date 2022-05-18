if executable('fd')
  let $FZF_DEFAULT_COMMAND = 'fd --exclude={node_modules,build,out,venv,dist,__pycache__} --type f --no-ignore --strip-cwd-prefix'
elseif executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --follow --glob "!node_modules/*" --glob "!out/*" --glob "!dist/*" --glob "!__pycache__/*"''
elseif executable('ag')
  let $FZF_DEFAULT_COMMAND = 'ag -g ""'
endif

command! -bang -nargs=* FZFRg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --glob "!out/*" --glob "!dist/*" --glob "!__pycache__/*" --color "always" '
      \      . shellescape(<q-args>), 1, <bang>0
      \ )

command! -bang FZFWorkspaceFiles call fzf#vim#files('~/workspace', <bang>0)

command! -bang -nargs=* FZFAllFiles call fzf#run(fzf#wrap(
      \   {'source': 'fd --type f --hidden --no-ignore --strip-cwd-prefix', 'options': '--prompt="all pwd/"'},
      \     <bang>0
      \ ))

command! -bang -complete=dir -nargs=* FZFAllWorkspaceFiles call fzf#run(fzf#wrap(
      \   {'source': 'fd --type f --hidden --no-ignore --strip-cwd-prefix', 'dir': '~/workspace', 'options': '--prompt="all ~/workspace/"'},
      \     <bang>0
      \ ))

command! -bang FZFHomeFiles call fzf#vim#files('~', <bang>0)

command! -bang -complete=dir -nargs=* FZFAllHomeFiles call fzf#run(fzf#wrap(
      \   {'source': 'fd --type f --hidden --no-ignore --strip-cwd-prefix', 'dir': '~', 'options': '--prompt="all ~/"'},
      \     <bang>0
      \ ))

augroup config#fzf
  autocmd!
  autocmd FileType fzf set laststatus=0 noruler
        \| autocmd BufLeave <buffer> set laststatus=2 ruler
augroup END

let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

let g:fzf_preview_window = []

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

let g:fzf_history_dir = '~/.local/share/fzf-history'
