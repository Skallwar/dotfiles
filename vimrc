set nocompatible              " be iMproved, required
filetype off                  " required

"Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

"Themes
Plugin 'flazz/vim-colorschemes'

"Git
Plugin 'tpope/vim-fugitive'

"Languages server
Plugin 'w0rp/ale'
Plugin 'ludovicchabant/vim-gutentags'

"Rust
Plugin 'rust-lang/rust.vim'

"Code
Plugin 'sheerun/vim-polyglot'
Plugin 'tomtom/tcomment_vim'
Plugin 'luochen1990/rainbow'

"Tools
Plugin 'vim-airline/vim-airline'
Plugin 'tpope/vim-vinegar'

call vundle#end()            " required
filetype plugin indent on    " required

"General
syntax on
set path=$PWD/**
set number
set cursorline
set wildmenu
set cc=80
set scrolloff=5
set list!
set listchars=trail:.,tab:>\ ,eol:¬

"Tools
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case

"Indentation
set autoindent
set smartindent
set tabstop=8
set shiftwidth=4
set expandtab

"Theme
set background=dark
set t_ut=
let g:rainbow_active = 1

"Plugin
let g:ale_linters_explicit = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_fix_on_save = 1
let g:ale_linters = {}
let g:ale_fixers = {}

""Dev
"C
let g:ale_linters.c = ['clangd', 'clang-tidy']
let g:ale_fixers.c = ['clang-format']

"Rust
let g:ale_linters.rust = ['analyser']
" let g:ale_fixers.rust = ['rustfmt']
