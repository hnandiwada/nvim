if executable('fd')
  let $FZF_DEFAULT_COMMAND = 'fd --exclude={.git,.sass-cache,node_modules,build,out} --type f --hidden --no-ignore'
elseif executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*" --glob "!node_modules/*" --glob "!out/*"'
'
elseif executable('ag')
  let $FZF_DEFAULT_COMMAND = 'ag -g ""'
endif

command! -bang -nargs=* FZFRg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" ---glob "!out/*" -color "always" '
      \      . shellescape(<q-args>), 1, <bang>0
      \ )

command! -bang FZFWorkspaceFiles call fzf#vim#files('~/workspace', <bang>0)

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
