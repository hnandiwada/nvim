let s:projections = {
      \ 'src/cli/*.ts': {'type': 'typescript', 'alternate': 'src/test/units/{}.test.ts'},
      \ 'src/test/units/*.test.ts': {'type': 'typescript', 'alternate': 'src/cli/{}.ts'},
      \ 'cli/*.ts': {'type': 'typescript', 'alternate': 'test/units/{}.test.ts'},
      \ 'test/units/*.test.ts': {'type': 'typescript', 'alternate': 'cli/{}.ts'},
      \ '*.ts': {'type': 'typescript', 'alternate': '../test/units/{}.test.ts'},
      \ 'units/*.test.ts': {'type': 'typescript', 'alternate': '../cli/{}.ts'},
      \ }
" this only kind of works. they're all dependent on where you open the
" directory, so the last two in particualr are brittle. also figure out folder
" generics

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
