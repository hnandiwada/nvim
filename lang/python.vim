let s:projections = {
      \ '*.py': {'type': 'python', 'alternate': 'test/units/{}_test.py'},
      \ 'test/units/*_test.py': {'type': 'python', 'alternate': '{}.py'},
      \ 'integrations/*/integration.py': {'type': 'python', 'alternate': 'test/integrations/{}_test.py'},
      \ 'test/integrations/*_test.py': {'type': 'python', 'alternate': 'integrations/{}/integration.py'},
      \ }

function! s:ProjectionistDetect() abort
  if &filetype ==# 'python'
    let l:projections = deepcopy(s:projections)
    call projectionist#append(getcwd(), l:projections)
  endif
endfunction

augroup config#python
  autocmd!
  autocmd User ProjectionistDetect call s:ProjectionistDetect()
  autocmd FileType python setlocal foldmethod=indent
augroup END

