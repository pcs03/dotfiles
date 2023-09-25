" Set the leader key to space
let mapleader = "\<Space>"

" Map <leader>pv in normal mode to execute :Ex
nnoremap <leader>pv :Ex<CR>

" Map J in visual mode to move the selected lines down and reselect
"vnoremap J :m '>+1<CR>gv=gv

" Map K in visual mode to move the selected lines up and reselect
"vnoremap K :m '<-2<CR>gv=gv

" Map <C-d> in normal mode to scroll down and keep cursor centered
nnoremap <C-d> <C-d>zz

" Map <C-u> in normal mode to scroll up and keep cursor centered
nnoremap <C-u> <C-u>zz

" Map n in normal mode to move to the next match and keep cursor centered
nnoremap n nzzzv

" Map N in normal mode to move to the previous match and keep cursor centered
nnoremap N Nzzzv

" Map <leader>p in visual mode to paste without yanking to the unnamed register
vnoremap <leader>p "_dP

" Map <leader>y in normal and visual mode to yank to the system clipboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y

" Map <leader>Y in normal mode to yank the entire line to the system clipboard
nnoremap <leader>Y "+Y

" Map <C-c> in insert mode to exit insert mode
inoremap <C-c> <Esc>

set nu
set rnu

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

set smartindent

set nowrap

set nohlsearch
set incsearch

set termguicolors

set scrolloff=8
set signcolumn=yes

set updatetime=40

set colorcolumn=100


