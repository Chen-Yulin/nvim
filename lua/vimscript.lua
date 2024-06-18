vim.cmd([[
set wrap

set guicursor=i:block-iCursor-blinkon0,v:block-vCursor

set winblend=0
set pumblend=0
set conceallevel=2
set nomodeline

" How each level is indented and what to prepend.
" This could make the display more compact or more spacious.
" e.g., more compact: ["▸ ", ""]
" Note: this option only works for the kind renderer, not the tree renderer.

nnoremap ss <Plug>(leap-forward-to)
nnoremap xx <Plug>(leap-forward-till)


noremap <F1><F1> :Dashboard<CR>


nnoremap <leader>p :lua require("nabla").popup()<CR> " Customize with popup({border = ...})  : `single` (default), `double`, `rounded`


" for python env
"let g:python3_host_prog = '/home/cyl/.conda/envs/nvimpy/bin/python'
"let g:python3_host_prog = '/home/cyl/.conda/envs/nvimpy/bin/python'

]])
