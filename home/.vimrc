" unbind all autocommands
autocmd!

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
" Disable the built in explorer
let g:loaded_netrw=1
let g:loaded_netrwPlugin=1
" I don't spell good
set spell

" Autoremove trailing spaces when saving the buffer
autocmd FileType c,cpp,eruby,html,java,javascript,php,ruby autocmd BufWritePre <buffer> :%s/\s\+$//e

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

" make switching between windows more natural
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Equalize splits after a window resize (should this be in an autocommand group?)
autocmd VimResized * wincmd =

" * indentation
set shiftround " only tab in multiples of two
" keep visual selection when shifting
noremap > >gv
vnoremap < <gv
set shiftwidth=2
set tabstop=2
set expandtab " no tabs!
" override this later on if need be in after
set autoindent

" * breaks
" http://vim.wikia.com/wiki/Word_wrap_without_line_breaks
set wrap
set linebreak
set nolist  " list disables linebreak"
set textwidth=0
set wrapmargin=0


" === Directories
" stolen from https://github.com/kgust/dotvim/blob/master/vimrc#L40 (thanks, Kevin!)
" we use the <path>// notation to try to reduce clobbering a little bit
set backup                         " backups are nice ...
set backupdir=$HOME/.vimbackup     " but not when they clog .
" no swap files for the time being
"set directory=$HOME/.vimswap//     " Same for swap files
set viewdir=$HOME/.vimviews        " same for view files
set undodir=$HOME/.vimundo         " same for undo files

" Creating directories if they don't exist
" keeping swapdir for the time being, in case there is a need to read it
silent execute '!mkdir -p $HOME/.vimbackup'
silent execute '!mkdir -p $HOME/.vimswap'
silent execute '!mkdir -p $HOME/.vimviews'
silent execute '!mkdir -p $HOME/.vimundo'

" disable swapfiles
set noswapfile

" === EX {{{
set wildmenu " nice, zsh-like completion for ex commands
" }}}

" === Looks
colorscheme base16-tomorrow
let base16colorspace=256
set background=dark
set title
set scrolloff=3 " lines above/below cursor
set vb t_vb= " disable beep and flashing
hi Search ctermfg=221 guifg=#ffcc66 term=reverse ctermbg=238 guibg=#515151
hi IncSearch ctermfg=221 guifg=#ffcc66 term=standout ctermbg=238 guibg=#515151
hi SpellBad cterm=bold,underline ctermfg=251 ctermbg=bg
hi SpellCap ctermfg=114 ctermbg=bg
" zero this out since I don't find it to be helpful
hi SpellRare ctermfg=fg ctermbg=bg
" @todo: revisit this
hi SpellLocal ctermfg=fg ctermbg=bg
" commenting out to troubleshoot slowness
" set cursorline " I get lost sometimes T_T
" set colorcolumn=80 " color long lines

set laststatus=2
" statusline stolen from http://stackoverflow.com/a/5380230/1048479
set statusline=\%{fugitive#statusline()} " git status via fugitive
set statusline+=\:\       " Separator
set statusline+=%f        " Path to the file
set statusline+=%=        " Switch to the right side
set statusline+=%3*%y%*                "file type
set statusline+=%1*%4v\ %* "virtual column number
set statusline+=%l        " Current line
set statusline+=/         " Separator
set statusline+=%L        " Total lines

"set statusline=
"set statusline +=%1*\ %n\ %*            "buffer number
"set statusline +=%5*%{&ff}%*            "file format
"set statusline +=%4*\ %<%F%*            "full path
"set statusline +=%2*%m%*                "modified flag
"set statusline +=%2*/%L%*               "total lines
"set statusline +=%2*0x%04B\ %*          "character under cursor

" === Input
" don't copy numbers with mouse
set mouse=a
" non insane paste
set pastetoggle=<F2>
" Pasting over a selection does not replace the clipboard
xnoremap <expr> p 'pgv"'.v:register.'y'"'

" ===  Syntax
" we need to use set filetype instead of setfiletype
" here because setfiletype will not work on a filetype that
" has already been set. Whew. Now say that 5 times in a row.
au BufRead,BufNewFile *.twig set filetype=jinja
au BufRead,BufNewFile *.module set filetype=php
au BufRead,BufNewFile *.md.* set filetype=markdown
au BufRead,BufNewFile *.pro set syntax=prolog
" django
autocmd FileType python set ft=python.django " For SnipMate
autocmd FileType html set ft=htmldjango.html " For SnipMate
" handlebars
au BufRead,BufNewFile *.handlebars set filetype=html
" ruby
au BufRead,BufNewFile Guardfile set filetype=ruby
" Make
au BufRead,BufNewFile make setlocal noexpandtab

" === Files
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,.DS_STORE,*.pyc

""" Keybindings {{{
  " shorcut for only
  noremap <leader>on :on<CR>
	" Quickly edit/source .vimrc
	noremap <leader>ve :tabedit $HOME/.vimrc<CR>
	noremap <leader>vs :source $HOME/.vimrc<CR>
	" Quickly edit vundle bundles
	noremap <leader>vb :tabedit $HOME/.vim/repos.vim<CR>
  " Quickly edit snippets
  noremap <leader>se :tabedit $HOME/.vim/snippets<CR>
  """ command line mode {{{
    " cnoremap <C-n> <Down>
    " cnoremap <C-b> <Left>
  """ }}}
  """ conveience normal methods
      nmap <leader>k :norm ysabb  :startinsert<CR>
  """ convience insert methods {{{
      " less awkward =>
      imap <C-L> <SPACE>=><SPACE>
      " less awkward ->
      imap <C-J> <SPACE>-><SPACE>
      " less awkward () =>
      imap <C-K> () =><SPACE>
  """ }}}
""" }}}

""" Plugins {{{
	" enable per-language settings: http://stackoverflow.com/a/1743255/1048479
	filetype plugin on
	filetype plugin indent on
  "" * MATCHIT (included in most vims by default, grab it from https://github.com/vim-scripts/matchit.zipc if it is not
  runtime macros/matchit.vim

  "" * ultisnips https://github.com/SirVer/ultisnips
  let g:UltiSnipsExpandTrigger="<tab>"
  " i'd really prefer to just tab through all options
  " working on figuring out how to do that now
  let g:UltiSnipsJumpForwardTrigger="<c-b>"
  let g:UltiSnipsJumpBackwardTrigger="<c-z>"

	"" * NERD_tree
	" I come from the sublime text world, so this makes a lot of sense to me
	map <leader>nt :NERDTreeToggle<CR>
  map <silent> <LocalLeader>nf :NERDTreeFind<CR>

	"" * TComment
	map <leader>c <c-_><c-_>

  "" * vim-trailing-whitespace"
  map <leader>fws :FixWhitespace<CR>

  "" * surround
  " compatability with jimmychan/dustjs.vim
  let g:surround_{char2nr('d')} = "{\r}"

	"" * ctrlp
  let g:ctrlp_map = '<c-p>'
  let g:ctrlp_cmd = 'CtrlP'
  " mirror shared environment setting for local vimrc
  " not sure if this is the best way to do this
  nmap <leader>ff :CtrlP<CR>
  nnoremap <leader>ft :CtrlPTag<cr>
  " https://github.com/kien/ctrlp.vim#basic-options
  let g:ctrlp_working_path_mode = 'a'
  " custom ignore https://github.com/kien/ctrlp.vim/issues/58
  let g:ctrlp_custom_ignore = 'node_modules\|bower_components\|DS_store\|git\|dist'

  " open multiple files (maximum of 4)
  " (default bindings are <c-o> and <c-z>)
  let g:ctrlp_open_multiple_files = '4vjr'

  " replace current file with new file
  " use ctrl + v or ctrl + t in the quick list
  " if you want to circumvent this
  let g:ctrlp_open_new_file = 'r'

  " allow ctrlp to replace nerdtree
  " https://github.com/mhinz/vim-startify/issues/6#issuecomment-21863572
  " (normally ctrlp does not replace the window of anotother plugin)
  let g:ctrlp_reuse_window  = 'nerdtree'

	" want to open new files in a tab?
	" https://github.com/kien/ctrlp.vim/issues/160#issuecomment-4527442

  " stolen from https://github.com/skwp/dotfiles/blob/master/vim/settings/ctrlp.vim#L4
  if executable('ag')
    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    let g:ctrlp_user_command =
      \ 'ag %s --files-with-matches -g "" --ignore "\.git$\|\.hg$\|\.svn$"'

    " ag is fast enough that CtrlP doesn't need to cache
    let g:ctrlp_use_caching = 0
  else
    " Fall back to using git ls-files if Ag is not available
    let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others']
  endif

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
  " consider http://stackoverflow.com/a/28577965/1048479
  " autocmd FileType javascript let b:syntastic_checkers = findfile('.eslintrc', '.;') != '' ? ['eslint'] : ['jshint']
  let g:syntastic_javascript_checkers = ['eslint']

  " make error coloring less awful
  hi SyntasticError cterm=bold,underline ctermfg=210 guifg=#f2777a
  hi SyntasticWarning term=underline cterm=underline ctermfg=81 gui=underline guifg=#80a0ff

  " * lightline
  let g:lightline = {
        \ 'colorscheme': 'Tomorrow',
        \ }

  " * Rainbow
  let g:rainbow_active = 0

  map <leader>rt :RainbowToggle<CR>

  " * Vimux Ruby Test("https://github.com/pgr0ss/vimux-ruby-test")
  map <silent> <LocalLeader>rf :RunRubyFocusedTest<CR>
  map <silent> <LocalLeader>rb :RunAllRubyTests<CR>

  " * Vimux (https://github.com/benmills/vimux)
  map <silent> <LocalLeader>rl :wa<CR> :VimuxRunLastCommand<CR>
  map <silent> <LocalLeader>vi :wa<CR> :VimuxInspectRunner<CR>
  map <silent> <LocalLeader>vk :wa<CR> :VimuxInterruptRunner<CR>
  map <silent> <LocalLeader>vx :wa<CR> :VimuxClosePanes<CR>
  map <silent> <LocalLeader>vp :VimuxPromptCommand<CR>

  map <silent> <LocalLeader>ds :call VimuxRunCommand('clear; grep -E "^ *describe[ \( ]\|^ *context[ \( ]\|^ *it[ \( ]" ' . bufname("%"))<CR>

  " @ todo fix these conflicts yo
  " vmap <silent> <LocalLeader>vs "vy :call VimuxRunCommand(@v)<CR>
  " nmap <silent> <LocalLeader>vs vip<LocalLeader>vs<CR>
""" }}}
  " * wap it
  :nmap <LocalLeader>wi :call WapIt()<CR>
  :nmap <LocalLeader>wd :call WapDescribe()<CR>

" save vimrc after writing courtesy of VimCasts
" http://vimcasts.org/episodes/updating-your-vimrc-file-on-the-fly/
if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
endif
