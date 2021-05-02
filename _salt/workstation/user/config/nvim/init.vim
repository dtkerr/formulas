""""""""""""""
""" plug setup
let plug_dir = '~/.config/nvim'
if empty(glob(plug_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.plug_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.config/nvim/plug')

"""""""""""
""" plugins

" aesthetics
Plug 'arcticicestudio/nord-vim'
Plug 'itchyny/lightline.vim'
Plug 'ap/vim-buftabline'
" utilitiy
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-commentary'
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
" syntax
Plug 'cespare/vim-toml'
Plug 'dag/vim-fish'
Plug 'hashivim/vim-terraform'
" completion
Plug 'neoclide/coc.nvim',             {'branch': 'release'}
Plug 'neoclide/coc-json',             {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-yaml',             {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-css',              {'do': 'yarn install --frozen-lockfile'}
Plug 'fannheyward/coc-rust-analyzer', {'do': 'yarn install --frozen-lockfile'}
Plug 'fannheyward/coc-pyright',       {'do': 'yarn install --frozen-lockfile'}
Plug 'fannheyward/coc-deno',          {'do': 'yarn install --frozen-lockfile'}
Plug 'kkiyama117/coc-toml',           {'do': 'yarn install --frozen-lockfile'}
Plug 'oncomouse/coc-fish',            {'do': 'yarn install --frozen-lockfile'}

"""""""""""""""""""
""" plug finalizing
call plug#end()
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

""""""""""""""""""""
""" general settings
filetype plugin indent on
syntax enable

set clipboard+=unnamedplus
set hidden
set modeline
set noshowmode
set signcolumn=yes
set number
set cmdheight=1
set updatetime=300
set shortmess+=c

set nobackup
set nowritebackup

set termguicolors
set t_Co=256
set background=dark
silent! colorscheme nord

"""""""""""""
""" key binds
let mapleader = ";"
let maplocalleader = ","
nnoremap <silent> <C-n> :bnext<CR>
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <C-l> :nohl<CR>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> <leader>rn <Plug>(coc-rename)
nmap <silent> <leader>fm <Plug>(coc-format)
nnoremap <silent> K :call <SID>show_documentation()<CR>
autocmd CursorHold * silent call CocActionAsync('highlight')

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

"""""""""""""
""" filetypes
autocmd BufRead,BufNewFile *.h set ft=c
autocmd BufRead,BufNewFile *.sls set ft=yaml
autocmd BufRead,BufNewFile *.tera set ft=htmldjango

""""""""""""
""" coc-nvim
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

"""""""""""""
""" lightline
let g:lightline = {
  \ 'colorscheme': 'nord',
  \ 'active': {
  \     'left': [ [ 'mode', 'paste' ],
  \               [ 'cocstatus', 'readonly', 'filename', 'modified' ] 
  \     ],
  \     'right': [ [ 'filetype', 'lineinfo' ],
  \                [ 'gitbranch' ],
  \     ],
  \ },
  \ 'component_function': {
  \     'cocstatus': 'coc#status',
  \ },
  \ }
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

"""""""""""""
""" terraform
let g:terraform_align = 1
let g:terraform_fmt_on_save = 1
