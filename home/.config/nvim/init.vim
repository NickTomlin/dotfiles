" vim: foldmethod=marker
" Uze zi to toggle folds OOOOOOR
" use z + shift + r to decrease fold level and show all fold
" use z + m to increase fold level to hide folds


" Remap leader to space
" we do this way early because:
" https://stackoverflow.com/questions/446269/can-i-use-space-as-mapleader-in-vim#comment72147920_446293
noremap <Space> <Nop>
map <Space> <leader>
let mapleader = " "
let maplocalleader=" "
map \ <Nop>

call plug#begin('~/.config/nvim/plugged')
" External commands
Plug 'benmills/vimux'
" Plug 'christoomey/vim-tmux-runner'

" Editing improvements
Plug 'mattn/emmet-vim', { 'for': ['erb', 'html', 'javascript.jsx', 'ejs', 'markdown'] }
" === Emmet Config {{{
let g:user_emmet_settings = {
\  'javascript.jsx' : {
\      'extends': 'jsx',
\      'quote_char': "'",
\  },
\}
" }}}
Plug 'sheerun/vim-polyglot'
" === JS syntax Config {{{
let g:jsx_ext_required = 0
" }}}
Plug 'editorconfig/editorconfig-vim'
Plug 'tomtom/tcomment_vim'
"=== TComment Config {{{
map <leader>c <c-_><c-_>
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,.DS_STORE,*.pyc
" }}}

Plug 'ntpeters/vim-better-whitespace' "{{{
  nmap <LocalLeader>ws :StripWhitespace<cr>
"}}}"

Plug 'jiangmiao/auto-pairs'

" Markdown
Plug 'godlygeek/tabular', { 'for': ['markdown', 'md'] }
Plug 'plasticboy/vim-markdown', { 'for': ['markdown', 'md'] }
Plug 'junegunn/goyo.vim', { 'for': ['markdown', 'md'] }

" Markdown config {{{
  let g:vim_markdown_new_list_item_indent = 2
  let g:vim_markdown_folding_disabled = 1
  let g:vim_markdown_frontmatter = 1
  let g:vim_markdown_autowrite = 1
" }}}

" Node/JS
Plug 'elzr/vim-json'

" Tpope
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-endwise', { 'for': ['ruby', 'elixir'] }

" Looks
" Plug 'w0ng/vim-hybrid'
" Plug 'rakr/vim-one'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

"=== fzf Config {{{
map <leader>ff :Files<CR>
" git status files
map <leader>fg :GFiles?<CR>
map <leader>fa :Files<CR>
map <leader>fh :Helptags<CR>
map <leader>fb :Buffers<CR>

" }}}
"
Plug 'janko-m/vim-test'
" Vim Test config {{{
let test#strategy = "vimux"
nmap <silent> <leader>rf :TestNearest<CR>
nmap <silent> <leader>rb :TestFile<CR>
nmap <silent> <leader>rl :TestLast<CR>

map <silent> <LocalLeader>ds :call VimuxRunCommand('clear; grep -E "^ *describe[ \( ]\|^ *context[ \( ]\|^ *it[ \( ]" ' . bufname("%"))<CR>
" }}}


call plug#end()

"=== Looks config {{{
  syntax enable
  set termguicolors
  set background=dark
  let g:one_allow_italics = 1

  colorscheme catppuccin-macchiato

  set cursorline
  hi CursorLineNr ctermbg=none guibg=none ctermfg=180 guifg=#e5c07b
  hi CursorLine ctermbg=16 guibg=#333841
  hi LineNr ctermfg=59 guifg=#5c6370
  hi Comment gui=italic cterm=italic
  hi ExtraWhitespace guibg=#e06c75 ctermbg=red

  " Statusline

  " T_T T_T T_T
  " https://vi.stackexchange.com/a/3356/12886
  set statusline=%f
  set statusline+=\ %1*
  set statusline+=%y
  set statusline+=%*
  set statusline+=%=\ {%l\|%c}

  autocmd VimEnter,ColorScheme *
        \ hi User1 cterm=italic gui=italic,bold ctermfg=176 guifg=#c678dd guibg=#2c323c |
        \ hi StatusLine ctermfg=145 ctermbg=16 guifg=#abbaaa guibg=#2c323c |
        \ hi StatusLineNC ctermfg=NONE ctermbg=NONE gui=NONE cterm=NONE guifg=NONE guibg=NONE
" }}}


" From: https://andrew.stwrt.ca/posts/project-specific-vimrc/
" Allow automatic reading of per directory .vimrc
set exrc
" But... Ensure that only vimrc files cannot run shell commands unless owned
" by me
set secure

" autoremove trailing spaces when saving the buffer
autocmd FileType c,cpp,eruby,html,java,javascript,php,ruby autocmd BufWritePre <buffer> :%s/\s\+$//e

" Disable annoying ex mode (Q)
map Q <nop>
" the /g flag on :s substitutions by default
set gdefault
" I don't spell good
set spell

" === SEARCH
" clear highlighted seaches
set incsearch                    " find as you type search
set hlsearch                     " highlight search terms
" smart case searching
" http://stackoverflow.com/a/2288438/1048479
set ignorecase
set smartcase

" === ETC

" left margin width http://stackoverflow.com/a/7941499/1048479
set foldcolumn=0

if $TMUX == ''
  set clipboard+=unnamed
endif

set title
set scrolloff=3 " lines above/below cursor
" don't copy numbers with mouse
set mouse=

" I don't spell good
set spell

" === SPLITS
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

" ===  indentation

set shiftround " only tab in multiples of two
" keep visual selection when shifting
noremap > >gv
vnoremap < <gv
set shiftwidth=2
set tabstop=2
set expandtab " https://stackoverflow.blog/2017/06/15/developers-use-spaces-make-money-use-tabs/
set number " Linenumbers
set autoindent

" ===  breaks

" http://vim.wikia.com/wiki/Word_wrap_without_line_breaks
set wrap
set linebreak
set nolist  " list disables linebreak"
set textwidth=0
set wrapmargin=0

" no slow crappy sql autocomplete when <ctrl-c>c
" https://www.reddit.com/r/vim/comments/2om1ib/how_to_disable_sql_dynamic_completion/
let g:omni_sql_no_default_maps = 1

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
silent execute '!mkdir -p $HOME/.nvimbackup'
silent execute '!mkdir -p $HOME/.nvimswap'
silent execute '!mkdir -p $HOME/.nvimviews'
silent execute '!mkdir -p $HOME/.nvimundo'

" disable swapfiles
set noswapfile

" EX
set wildmenu " nice, zsh-like completion for ex commands
set wildmode=longest:list

" {{{ === netrw
" https://gist.github.com/KevinSjoberg/5068370
let g:netrw_localrmdir='rm -r'
" }}}

" === Mappings

function! GitGrepWord()
  cgetexpr system("git grep -n '" . expand("<cword>") . "'")
  cwin
  echo 'Number of matches: ' . len(getqflist())
endfunction
command! -nargs=0 GitGrepWord :call GitGrepWord()
nnoremap <silent> <Leader>gw :GitGrepWord<CR>

" Pasting over a selection does not replace the clipboard
xnoremap <expr> p 'pgv"'.v:register.'y'"'

" clear highlighted searches with enter
map  <silent> <LocalLeader>nh :nohls<CR>

" Convenience for Vim development
noremap <leader>vv :vsp $MYVIMRC<CR>
noremap <leader>vs :source $MYVIMRC<CR>
noremap <leader>vf :source %<CR>

" make :E actually work
" http://stackoverflow.com/a/14367507/1048479
command! -nargs=* -bar -bang -count=0 -complete=dir E Explore <args>

" Make ctrcl+c act like escape (instead of terminating)
vnoremap <C-c> <Esc>

" Easily toggle semicolon to the current line
" https://vi.stackexchange.com/a/3723
nnoremap <expr> <leader>; getline('.') =~ ';$' ? 'mq$x\<esc>`q' : "mqA;\<esc>`q"
nnoremap <expr> <leader>rd getline('.') =~ 'binding\.pry' ?  'dd' : 'Obinding.pry'

" Random Helpful mappings
" less awkward =>
imap <C-L> <SPACE>=><SPACE>
imap <C-K> <SPACE>\|><SPACE>

" Autocommands

" Reload vimrc on save http://www.bestofvim.com/tip/auto-reload-your-vimrc/
augroup reload_vimrc
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

function! GitHubURL() range
   let branch = systemlist("git name-rev --name-only HEAD")[0]
   let remote = systemlist("git config branch." . branch . ".remote")[0]
   let repo = systemlist("git config --get remote." . remote . ".url | sed 's/\.git$//' | sed 's_^git@\\(.*\\):_https://\\1/_' | sed 's_^git://_https://_'")[0]
   let revision = systemlist("git rev-parse HEAD")[0]

  let path = systemlist("git ls-files --full-name " . @%)[0]
  let url = repo . "/blob/" . revision . "/" . path . "#L" . a:firstline . "-L" . a:lastline
  echomsg url
endfunction
command! -range GitHubURL <line1>,<line2>call GitHubURL()

" Restore cursor position between Vim sessions
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  "
  autocmd BufWinEnter * if index(['netrw'], &ft) < 0 | call ResCur()
augroup END
