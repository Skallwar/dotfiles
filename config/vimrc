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
Plugin 'prabirshrestha/async.vim'
Plugin 'prabirshrestha/vim-lsp'

"Rust
Plugin 'rust-lang/rust.vim'

"Code
Plugin 'sheerun/vim-polyglot'
Plugin 'tomtom/tcomment_vim'

"Tools
Plugin 'vim-airline/vim-airline'

call vundle#end()            " required
filetype plugin indent on    " required

""Set section
"General
syntax on
set path=$PWD/**
set number
set cursorline 
set wildmenu
set cc=80

"Indentation
set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab

"Theme
set background=dark
set t_ut=

""Dev
"Rust
if executable('rls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': {server_info->['rustup', 'run', 'stable', 'rls']},
        \ 'workspace_config': {'rust': {'clippy_preference': 'on'}},
        \ 'whitelist': ['rust'],
        \ })
endif
let g:rustfmt_autosave = 1
