" === Vundle
" required by vundle
set nocompatible              " be iMproved
filetype off                  " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Grab Vundle Bundles
source ~/.vim/repos.vim

" ===  Basics
syntax on
set number
" share system clipboard on osx
set clipboard=unnamed

" === Looks
colorscheme Tomorrow-Night-Eighties

set laststatus=2
" statusline stolen from http://stackoverflow.com/a/5380230/1048479
set statusline=%f         " Path to the file
set statusline+=%=        " Switch to the right side
set statusline+=%l        " Current line
set statusline+=/         " Separator
set statusline+=%L        " Total lines

"set statusline=
"set statusline +=%1*\ %n\ %*            "buffer number
"set statusline +=%5*%{&ff}%*            "file format
"set statusline +=%3*%y%*                "file type
"set statusline +=%4*\ %<%F%*            "full path
"set statusline +=%2*%m%*                "modified flag
"set statusline +=%1*%=%5l%*             "current line
"set statusline +=%2*/%L%*               "total lines
"set statusline +=%1*%4v\ %*             "virtual column number
"set statusline +=%2*0x%04B\ %*          "character under cursor

" === Input
" don't copy numbers with mouse
set mouse=a
" non insane paste
set pastetoggle=<F2>
" use system clipboard
set clipboard=unnamed

" ===  Syntax 
" enable per-language settings: http://stackoverflow.com/a/1743255/1048479
" required by vundle
filetype plugin on
filetype plugin indent on
scriptencoding utf-8


" === Plugins

"" * NERD_tree
autocmd VimEnter * if !argc() | NERDTree | endif
" I come from the sublime text world, so this makes a lot of sense to me
nmap <C-k><C-b> :NERDTreeToggle<CR>


"" * ctrlp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
" https://github.com/kien/ctrlp.vim#basic-options
let g:ctrlp_working_path_mode = 'c'
" custom ignore https://github.com/kien/ctrlp.vim/issues/58
let g:ctrlp_custom_ignore = 'node_modules\|DS_store\|git\|*.pyc'

" open new files in tab
" https://github.com/kien/ctrlp.vim/issues/160#issuecomment-4527442
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-t>'],
    \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
    \ }
