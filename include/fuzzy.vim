let to_ignore = ['.git', 'node_modules', 'build', 'out', 'venv', 'dist', '__pycache__', '*.so', 'yarn.lock', 'package-lock.json', 's_*.py', 'serverless_sdk', 'tmp-serverless.yml']
let globs = map(copy(to_ignore), 'printf(" --glob !%s", v:val)')
if executable('fd')
  let exclusion = join(to_ignore, ",")
  let $FZF_DEFAULT_COMMAND = printf('fd --exclude={%s} --type f --no-ignore --strip-cwd-prefix', exclusion)
elseif executable('rg')
  let $FZF_DEFAULT_COMMAND = printf('rg --files --follow %s', globs)
elseif executable('ag')
  let $FZF_DEFAULT_COMMAND = 'ag -g ""'
endif

command! -bang -nargs=* FZFRg
      \ call fzf#vim#grep(
      \   printf('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow %s --color "always" ', globs)
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
