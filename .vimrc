" The vimrc

let mapleader=","
let maplocalleader="\\"

" Easy editing of vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Abbreviations
iabbrev hw Hello World

" Disable viminfo
set viminfo=
