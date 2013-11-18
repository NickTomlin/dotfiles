" ===  Basics
syntax on
set nocompatible              " be iMproved
filetype off                  " required!
set number

" === Looks
colorscheme Tomorrow-Night-Eighties

" === Input
" don't copy numbers with mouse
set mouse=a
" non insane paste
set pastetoggle=<F2>

" ===  Syntax 
" enable per-language settings: http://stackoverflow.com/a/1743255/1048479
" required by vundle
filetype plugin indent on

" === Packages
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'kien/ctrlp.vim'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'L9'
Bundle 'FuzzyFinder'
Bundle 'mattn/emmet-vim'
Bundle 'cakebaker/scss-syntax.vim'
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install (update) bundles
" :BundleSearch(!) foo - search (or refresh cache first) for foo
" :BundleClean(!)      - confirm (or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle commands are not allowed.


"" * ctrlp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
" https://github.com/kien/ctrlp.vim#basic-options
let g:ctrlp_working_path_mode = 'c'

