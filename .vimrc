filetype plugin indent on
syntax on

let mapleader = " "
let maplocalleader = "\\"

set scrolloff=10
set sidescrolloff=5
set autoindent
set smartindent
set number
set relativenumber
set ignorecase
set smartcase
set incsearch
set hlsearch
set shiftround
set timeoutlen=10000
set notimeout
set undolevels=10000
set wrap
set backspace=indent,eol,start
set formatoptions=tcqj
set listchars=tab:>\ ,trail:-,nbsp:+
set shortmess=filnxtToOF
set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz

nnoremap <Space> <Nop>
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap Q gq
nnoremap Y y$
nnoremap <Esc> :nohlsearch<CR>
nnoremap <leader>ur :nohlsearch<CR>
nnoremap <leader>K :help <C-r><C-w><CR>

" Keep selection active after indenting in visual mode
vnoremap > >gv
vnoremap < <gv

nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
nmap <leader>- <C-w>s
nmap <leader><Bar> <C-w>v

nnoremap <leader>bb <C-^>
nnoremap <leader>` <C-^>

nmap <leader>: :history<CR>
nmap <leader>s" :registers<CR>
nmap <leader>sc :history<CR>
nmap <leader>sk :map<CR>
nmap <leader>sm :marks<CR>

nmap <leader>us :setlocal spell!<CR>
nmap <leader>uw :setlocal wrap!<CR>
nmap <leader>uL :set relativenumber!<CR>
nmap <leader>ul :set number!<CR>

nmap [t ?TODO<CR>
nmap ]t /TODO<CR>

inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-U> <C-G>u<C-U>
inoremap <C-W> <C-G>u<C-W>

" Russian keyboard aliases for regular Vim commands.
nmap ё `
nmap Ё ~
nmap б ,
nmap ю .
nmap Б <
nmap Ю >
nmap о j
nmap л k
nmap р h
nmap д l
nmap ц w
nmap и b
nmap у e
nmap пп gg
nmap П G
