" pathogen runtime manager https://github.com/tpope/vim-pathogen
call pathogen#infect()
syntax on
filetype plugin indent on
" line numbers whee
set number
" enable system clipboard support in mac os x http://goo.gl/fX8ZZ
set clipboard=unnamed
" Map ctrl-c to be equivalent to esc http://unix.stackexchange.com/a/42419
vnoremap <C-c> <Esc>