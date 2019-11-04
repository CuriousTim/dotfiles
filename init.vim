""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGINS                                                                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set the plugin directory
call plug#begin(stdpath('data') . '/plugged')

" Colorscheme
Plug 'morhetz/gruvbox'

" Language support
Plug 'lervag/vimtex', { 'for': 'tex' } " latex
Plug 'vim-pandoc/vim-pandoc'           " pandoc
Plug 'vim-pandoc/vim-pandoc-syntax'    " pandoc
Plug 'vim-pandoc/vim-rmarkdown'        " rmarkdown
Plug 'jalvesaq/Nvim-R'                 " R

" Git
Plug 'tpope/vim-fugitive' | Plug 'mhinz/vim-signify'

" Code Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Snippets
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" General 
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Initialize plugin system
call plug#end()

let g:python3_host_prog = '/home/sirphd/miniconda3/envs/neovim/bin/python'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GENERAL CONFIGURATIONS                                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set termguicolors " Get color in terminal

" resize panels with arrows
nnoremap <Up>    :resize +2<CR>
nnoremap <Down>  :resize -2<CR>
nnoremap <Left>  :vertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>

set encoding=utf-8
set colorcolumn=80,120 " Show column limits
set lazyredraw
set number
set tags=tags;
set ignorecase
set smartcase

" Indentation
set autoindent
set smartindent
set cindent
set tabstop=8
set softtabstop=2 " tab width while editing
set shiftwidth=2
set expandtab " use spaces instead of tabs

" splits
set splitbelow
set splitright

" spell checking
set spelllang=en_us

" prevent gopass from creating temp files on hard drive
au BufNewFile,BufRead /dev/shm/gopass.* setlocal noswapfile nobackup noundofile
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FILETYPE CONFIGURATIONS                                                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" correct highlighting of comments in json files
autocmd FileType json syntax match Comment +\/\/.\+$+

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGIN CONFIGURATIONS                                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""
" morhetz/gruvbox
"""""""""""""""""
set background=dark

nnoremap <silent> [oh :call gruvbox#hls_show()<CR>
nnoremap <silent> ]oh :call gruvbox#hls_hide()<CR>
nnoremap <silent> coh :call gruvbox#hls_toggle()<CR>

nnoremap * :let @/ = ""<CR>:call gruvbox#hls_show()<CR>*
nnoremap / :let @/ = ""<CR>:call gruvbox#hls_show()<CR>/
nnoremap ? :let @/ = ""<CR>:call gruvbox#hls_show()<CR>?

let g:gruvbox_italic = '1'
colorscheme gruvbox

""""""""""""""""""
" SirVer/ultisnips 
""""""""""""""""""
" Trigger configuration. Do not use <tab> if you use YouCompleteMe.
let g:UltiSnipsExpandTrigger="<F2>"
let g:UltiSnipsJumpForwardTrigger="<F3>"
let g:UltiSnipsJumpBackwardTrigger="<F4>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

"""""""""""""""""""""""
" itchyny/lightline.vim
"""""""""""""""""""""""
set noshowmode
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }

"""""""""""""""""""
" neoclide/coc.nvim
"""""""""""""""""""
let g:coc_global_extensions = [
  \'coc-prettier', 'coc-python',
  \'coc-css', 'coc-json', 'coc-r-lsp',
  \'coc-html'
  \]

" if hidden is not set TextEdit might fail
set hidden

" some servers have issues with backup files
set nobackup
set nowritebackup

" better display for messages
set cmdheight=2
set updatetime=300

" don't give |ins-completion-menu| messages
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" use tab for trigger completion
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>":
      \ <SID>check_back_space() ? "\<TAB>":
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\C-p" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~# '\s'
endfunction

" use <cr> to confirm completion
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim', 'help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" remap for format selected region
xmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" remap for do codeAction of selected region
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
