if executable('ag')
  set grepprg=ag
endif

nnoremap <leader>g :Ag! --ignore-dir=vendor <cword><cr>
nnoremap <leader>ag :Ag!<Space>

" vim:ft=vim