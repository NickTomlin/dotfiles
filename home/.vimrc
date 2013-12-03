" unbind all autocommands
autocmd!
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
scriptencoding utf-8
" share system clipboard on osx
" but not in tmux!
if $TMUX == ''
      set clipboard+=unnamed
endif
" * SPLITS
" http://robots.thoughtbot.com/vim-splits-move-faster-and-more-naturally
" more natural split opening
set splitbelow
set splitright

" * indentation
set shiftwidth=4
set tabstop=4
" override this later on if need be in after
set autoindent

" * breaks
" http://vim.wikia.com/wiki/Word_wrap_without_line_breaks
set wrap
set linebreak
set nolist  " list disables linebreak

" === Directories
" stolen from https://github.com/kgust/dotvim/blob/master/vimrc#L40 (thanks, Kevin!)
set backup                         " backups are nice ...
set backupdir=$HOME/.vimbackup     " but not when they clog .
set directory=$HOME/.vimswap       " Same for swap files
set viewdir=$HOME/.vimviews        " same for view files
set undodir=$HOME/.vimundo         " same for undo files

" Creating directories if they don't exist
silent execute '!mkdir -p $HOME/.vimbackup'
silent execute '!mkdir -p $HOME/.vimswap'
silent execute '!mkdir -p $HOME/.vimviews'
silent execute '!mkdir -p $HOME/.vimundo'

" === Looks
colorscheme Tomorrow-Night-Eighties

set laststatus=2
" statusline stolen from http://stackoverflow.com/a/5380230/1048479
set statusline=%f         " Path to the file
set statusline+=%=        " Switch to the right side
set statusline+=%1*%4v\ %* "virtual column number
set statusline+=%l        " Current line
set statusline+=/         " Separator
set statusline+=%L        " Total lines

"set statusline=
"set statusline +=%1*\ %n\ %*            "buffer number
"set statusline +=%5*%{&ff}%*            "file format
"set statusline +=%3*%y%*                "file type
"set statusline +=%4*\ %<%F%*            "full path
"set statusline +=%2*%m%*                "modified flag
"set statusline +=%2*/%L%*               "total lines
"set statusline +=%2*0x%04B\ %*          "character under cursor

" === Input
" don't copy numbers with mouse
set mouse=a
" non insane paste
set pastetoggle=<F2>

" ===  Syntax
" associate *.md with markdown filetype
au BufRead,BufNewFile *.md setfiletype markdown

" === Files
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,.DS_STORE,*.pyc


" === Plugins
" enable per-language settings: http://stackoverflow.com/a/1743255/1048479
filetype plugin on
filetype plugin indent on
"" * NERD_tree
autocmd VimEnter * if !argc() | NERDTree | endif
" I come from the sublime text world, so this makes a lot of sense to me
nmap <C-k><C-b> :NERDTreeToggle<CR>


"" * NERDCommenter
nmap <M-/> :NERDComToggleComment

"" * ctrlp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
" https://github.com/kien/ctrlp.vim#basic-options
let g:ctrlp_working_path_mode = 'a'
" custom ignore https://github.com/kien/ctrlp.vim/issues/58
let g:ctrlp_custom_ignore = 'node_modules\|DS_store\|git\'

" open new files in tab
" https://github.com/kien/ctrlp.vim/issues/160#issuecomment-4527442
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-t>'],
    \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
    \ }
