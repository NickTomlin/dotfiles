" vim: foldmethod=marker
" Uze zi to toggle folds OOOOOOR
" use z + shift + r to decrease fold level and show all fold
" use z + m to increase fold level to hide folds

call plug#begin('~/.config/nvim/plugged')
" External commands
Plug 'benmills/vimux'
" Plug 'christoomey/vim-tmux-runner'

" Editing improvments
Plug 'mattn/emmet-vim'
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
let g:jsx_ext_required = 1
" }}}
Plug 'editorconfig/editorconfig-vim'
Plug 'tomtom/tcomment_vim'
"=== TComment Config {{{
map <leader>c <c-_><c-_>
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,.DS_STORE,*.pyc
" }}}

"=== Walker Config {{{
" Add a stop to your code walk
nmap <silent> <leader>wm :call walker#mark()<CR>

" Open all stops in your codewalk in the quickfix list
nmap <silent> <leader>ww :call walker#walk()<CR>
" }}}
Plug 'bronson/vim-trailing-whitespace'
Plug 'jiangmiao/auto-pairs'

" Node
Plug 'moll/vim-node', { 'for': ['javascript'] }

" Tpope
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-rails', { 'for': ['ruby'] }
Plug 'tpope/vim-endwise', { 'for': ['ruby'] }
Plug 'vim-ruby/vim-ruby', { 'for': ['ruby'] }

" Looks
Plug 'w0ng/vim-hybrid'
Plug 'rakr/vim-one'
"=== Looks config {{{
  syntax enable
  set termguicolors
  set background=dark
  let g:one_allow_italics = 1
  autocmd VimEnter * colorscheme one
  autocmd VimEnter * call one#highlight('Comment', 'cleared', '', 'none')

  set cursorline
  hi CursorLineNr ctermbg=none guibg=none ctermfg=180 guifg=#e5c07b
  hi CursorLine ctermbg=16 guibg=#333841
  highlight LineNr ctermfg=59 guifg=#5c6370
  highlight Comment gui=italic cterm=italic
" }}}

" Plug 'mhartington/nvim-typescript'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
"=== fzf Config {{{
map <leader>ff :Files<CR>
" git status files
map <leader>fg :GFiles?<CR>
map <leader>fa :Files<CR>
map <leader>fh :Helptags<CR>
map <leader>fb :Buffers<CR>
" }}}

Plug 'w0rp/ale'
" === Ale Config {{{

" always keep the signal column open (helps make the visual 'jog' for things like linting warning signs less awful)
set signcolumn=yes
let b:ale_linters = {
\   'javascript': ['standard'],
\   'javascript.jsx': ['standard'],
\}

function! DetermineJSLinter()
  " we should inspect for jshint, jscs, eslint here
  let files = split(globpath('.', '.eslintrc'), '\n')
  if len(files) > 0
    let b:ale_linters = { 'javascript': ['eslint'], 'javascript.jsx': ['eslint'] }
  else
    " unsure why we need to set this here
    let b:ale_linters = {
          \   'javascript': ['standard'],
          \   'javascript.jsx': ['standard'],
          \}
  endif
endfunction

augroup FiletypeGroup
  autocmd!
  au BufNewFile,BufRead *.js,*.jsx :call DetermineJSLinter()
augroup END

let g:ale_echo_msg_format = '%linter%: %s'
" }}}
Plug 'janko-m/vim-test'
" Vim Test config {{{
let test#strategy = "vimux"
nmap <silent> <leader>rf :TestNearest<CR>
nmap <silent> <leader>rb :TestFile<CR>
nmap <silent> <leader>rl :TestLast<CR>

map <silent> <LocalLeader>ds :call VimuxRunCommand('clear; grep -E "^ *describe[ \( ]\|^ *context[ \( ]\|^ *it[ \( ]" ' . bufname("%"))<CR>
" }}}

" Completion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
Plug 'ternjs/tern_for_vim', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'othree/jspc.vim', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'Shougo/neco-vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

"  UltiSnips Config {{{
let g:UltiSnipsExpandTrigger="<C-j>"
" }}}

" Tern config {{{
" Default key mappings \t
" https://github.com/ternjs/tern_for_vim/blob/ae42c69ada7243fe4801fce3b916bbc2f40ac4ac/autoload/tern.vim#L108
let g:tern_map_keys=1
let g:tern_request_timeout = 1
let g:tern_show_signature_in_pum = '0'  " This do disable full signature type on autocomplete

" deoplete interop
let g:tern#command = ["tern"]
let g:tern#arguments = ["--persistent"]
" }}}

" Deoplete config {{{
" https://www.gregjs.com/vim/2016/neovim-deoplete-jspc-ultisnips-and-tern-a-config-for-kickass-autocompletion/
let g:deoplete#enable_at_startup = 1
let g:deoplete#omni#functions = {}
let g:deoplete#omni#functions.javascript = [
  \ 'tern#Complete',
  \ 'jspc#omni'
\]

set completeopt=longest,menuone,preview
let g:deoplete#sources = get(g:,'deoplete#sources',{})
let g:deoplete#sources['javascript.jsx'] = ['file', 'ternjs', 'ultisnips']
" I'm not a fan of deoplete in markdown
let g:deoplete#sources['markdown'] = []
autocmd VimEnter * call deoplete#custom#set('ultisnips', 'matchers', ['matcher_fuzzy'])

" Close the preview window once we autocomplete
" https://github.com/ternjs/tern_for_vim/issues/21#issuecomment-239468366
autocmd CompleteDone * pclose
" }}}

" My shizzle
Plug '$HOME/workspace/walker.vim'
Plug '$HOME/workspace/potion.vim'
Plug 'NickTomlin/plug-open.vim'
call plug#end()

" From: https://andrew.stwrt.ca/posts/project-specific-vimrc/
" Allow automatic reading of per directory .vimrc
set exrc
" But... Ensure that only vimrc files cannot run shell commands unless owned
" by me
set secure

" Autoremove trailing spaces when saving the buffer
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

" Status
set statusline=%f\ -\ %y

" === Mappings

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

" Easily add a semicolon to the current line
" https://vi.stackexchange.com/a/3723
nnoremap <expr> <leader>; getline('.') =~ ';$' ? '' : "mqA;\<esc>`q"

" Random Helpful mappings
" less awkward =>
imap <C-L> <SPACE>=><SPACE>

" less awkward () =>
imap <C-K> () =><SPACE>

" Autocommands

" Reload vimrc on save http://www.bestofvim.com/tip/auto-reload-your-vimrc/
augroup reload_vimrc
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

" Restore cursor position between Vim sessions
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END
