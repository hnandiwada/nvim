let s:projections = {
      \ '*.ts': {'type': 'typescript', 'alternate': 'test/units/{}.test.ts'},
      \ 'test/units/*.test.ts': {'type': 'typescript', 'alternate': '{}.ts'},
      \ 'src/*.ts': {'type': 'typescript', 'alternate': 'src/test/units/{}.test.ts'},
      \ 'src/test/units/*.test.ts': {'type': 'typescript', 'alternate': 'src/{}.ts'},
      \ }

function! s:ProjectionistDetect() abort
  if &filetype ==# 'typescript'
    let l:projections = deepcopy(s:projections)
    call projectionist#append(getcwd(), l:projections)
  endif
endfunction

augroup config#typescript
  autocmd!
  autocmd User ProjectionistDetect call s:ProjectionistDetect()
augroup END
