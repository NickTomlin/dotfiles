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
set t_Co=256 " 256 colors
set number
scriptencoding utf-8
set ttyfast " for faster redraws etc
" share system clipboard on osx
" but not in tmux!
if $TMUX == ''
    set clipboard+=unnamed
endif
" Disable annoying ex mode (Q)
map Q <nop>
" the /g flag on :s substitutions by default
set gdefault

" * SEARCH
" clear highlighted seaches
set incsearch                    " find as you type search
set hlsearch                     " highlight search terms
" smart case searching
" http://stackoverflow.com/a/2288438/1048479
set ignorecase
set smartcase
" clear highlighted searches with enter
map  <silent> <LocalLeader>nh :nohls<CR>

" * SPLITS
" http://robots.thoughtbot.com/vim-splits-move-faster-and-more-naturally
" more natural split opening
set splitbelow
set splitright
" Equalize splits after a window resize (should this be in an autocommand group?)
autocmd VimResized * wincmd =

" * indentation
set shiftwidth=4
set tabstop=4
set expandtab " no tabs!
" override this later on if need be in after
set autoindent

" * breaks
" http://vim.wikia.com/wiki/Word_wrap_without_line_breaks
set wrap linebreak nolist  " list disables linebreak
command! -nargs=* Wrap set wrap linebreak nolist


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
set title
set scrolloff=3 " lines above/below cursor
set vb t_vb= " disable beep and flashing
set cursorline " I get lost sometimes T_T
set colorcolumn=80 " color long lines

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
" we need to use set filetype instead of setfiletype
" here because setfiletype will not work on a filetype that
" has already been set. Whew. Now say that 5 times in a row.
au BufRead,BufNewFile *.twig set filetype=jinja
au BufRead,BufNewFile *.module set filetype=php
" django
autocmd FileType python set ft=python.django " For SnipMate
autocmd FileType html set ft=htmldjango.html " For SnipMate
" handlebars
au BufRead,BufNewFile *.handlebars set filetype=html

" === Files
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,.DS_STORE,*.pyc

""" Keybindings {{{
	" Quickly edit/source .vimrc
	noremap <leader>ve :edit $HOME/.vimrc<CR>
	noremap <leader>vs :source $HOME/.vimrc<CR>
	" Quickly edit bundles
	noremap <leader>be :edit $HOME/.vim/repos.vim<CR>
  " Quickly edit snippets
  noremap <leader>se :edit $HOME/.vim/snippets<CR>
  """ command line mode {{{
    " cnoremap <C-n> <Down>
    " cnoremap <C-b> <Left>
  """ }}}
""" }}}

""" Plugins {{{
	" enable per-language settings: http://stackoverflow.com/a/1743255/1048479
	filetype plugin on
	filetype plugin indent on
    "" * MATCHIT (included in most vims by default, grab it from https://github.com/vim-scripts/matchit.zipc if it is not
    runtime macros/matchit.vim
	"" * NERD_tree
	autocmd VimEnter * if !argc() | NERDTree | endif
	" I come from the sublime text world, so this makes a lot of sense to me
	nmap <leader>nt :NERDTreeToggle<CR>

	"" * TComment
	map <leader>c <c-_><c-_>

    "" * vim-trailing-whitespace"
    map <leader>fws :FixWhitespace<CR>

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
    " * Syntastic
    " On by default, turn it off for html
    let g:syntastic_mode_map = { 'mode': 'active',
        \ 'active_filetypes': [],
        \ 'passive_filetypes': ['html'] }
    " requires pyflakes (``pip install pyflakes``)
    let g:syntastic_python_checkers = ['flake8']
    " Better :sign interface symbols
    let g:syntastic_error_symbol = '✗'
    let g:syntastic_warning_symbol = '!'
""" }}}

