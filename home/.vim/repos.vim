call plug#begin('~/.vim/plugged')
" let Vundle manage Vundle
" required!
Plug 'Th3Whit3Wolf/one-nvim'
Plug 'itchyny/lightline.vim'
Plug 'mhartington/oceanic-next'
Plug 'chriskempson/base16-vim'
Plug 'altercation/vim-colors-solarized'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'ctrlpvim/ctrlp.vim'
" Plug 'L9'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'editorconfig/editorconfig-vim'
Plug 'tomtom/tcomment_vim'
Plug 'jiangmiao/auto-pairs'
Plug 'jlanzarotta/bufexplorer' " bufexplorer.zip'
Plug 'benmills/vimux'
Plug 'bronson/vim-trailing-whitespace'
Plug 'tommcdo/vim-exchange'
"{{{ PHP T_T
Plug 'lumiliet/vim-twig'
"}}}
"{{{ markdown
" Plug 'godlygeek/tabular'
" Plug 'plasticboy/vim-markdown'
Plug 'junegunn/goyo.vim'
"}}}
" {{{ html/css
Plug 'mattn/emmet-vim'
" }}}
"{{{ Ruby
Plug 'vim-ruby/vim-ruby'
Plug 'pgr0ss/vimux-ruby-test'
Plug 'kana/vim-textobj-user'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'tpope/vim-bundler'
" Rails
Plug 'tpope/vim-rails'
"}}}
" Rust {{{
Plug 'rust-lang/rust.vim'
" }}}
" {{{ Clojure (saving this for later)
" Plug 'tpope/vim-fireplace'
" Plug 'guns/vim-clojure-static'
" Plug 'luochen1990/rainbow'
" }}}
" {{{ snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" }}}
" {{{ javascript / compile to js(T_T)

Plug 'nicktomlin/wap-it'
" ---
" }}}
Plug 'vim-scripts/SyntaxRange'
" All the syntax highlighting
Plug 'sheerun/vim-polyglot'
call plug#end()
