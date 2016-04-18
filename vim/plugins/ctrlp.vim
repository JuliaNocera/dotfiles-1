nnoremap <leader>t :CtrlP<cr>
nnoremap <leader>. :CtrlPTag<cr>
nnoremap <leader>; :CtrlPBuffer<CR>

let g:ctrlp_max_files = 0

if executable('ag')
  let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden -g ""'
endif

if has('python')
  let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
endif

" vim:ft=vim