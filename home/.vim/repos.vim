call plug#begin('~/.vim/plugged')
" let Vundle manage Vundle
" required!
Plug 'itchyny/lightline.vim'
Plug 'chriskempson/base16-vim'
Plug 'gmarik/Vundle.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'kien/ctrlp.vim'
Plug 'L9'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'editorconfig/editorconfig-vim'
Plug 'tomtom/tcomment_vim'
Plug 'jiangmiao/auto-pairs'
Plug 'bufexplorer.zip'
Plug 'benmills/vimux'
Plug 'bronson/vim-trailing-whitespace'
Plug 'tommcdo/vim-exchange'
"{{{ markdown
Plug 'gabrielelana/vim-markdown'
" Plug 'godlygeek/tabular'
" Plug 'plasticboy/vim-markdown'
Plug 'junegunn/goyo.vim'
"}}}
" {{{ html/css
Plug 'mattn/emmet-vim'
Plug 'cakebaker/scss-syntax.vim'
" }}}
"{{{ Ruby
Plug 'vim-ruby/vim-ruby'
Plug 'pgr0ss/vimux-ruby-test'
" Rails
Plug 'tpope/vim-rails'
"}}}
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
Plug 'jelera/vim-javascript-syntax'
Plug 'pangloss/vim-javascript'
Plug 'muffs/wap-it'
" ---
Plug 'kchmck/vim-coffee-script'
" }}}
Plug 'vim-scripts/SyntaxRange'
call plug#end()
