set nocompatible              " be iMproved, required
filetype off                  " required

""Vundle
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

"Themes
Plugin 'powerline/powerline-fonts'
Plugin 'flazz/vim-colorschemes'

"Git
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'

"Languages
Plugin 'sheerun/vim-polyglot'

"Code
Plugin 'w0rp/ale'
Plugin 'vhdirk/vim-cmake'
Plugin 'rust-lang/rust.vim'
Plugin 'timonv/vim-cargo'
Plugin 'tomtom/tcomment_vim'
" Plugin 'jiangmiao/auto-pairs'
Plugin 'luochen1990/rainbow'
Plugin 'bronson/vim-trailing-whitespace'

Plugin 'vim-airline/vim-airline'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


""Set section
"General
syntax on
set number
set wildmenu
set cc=80
"Indentation
set autoindent
set smartindent
set cindent
set shiftwidth=4
set tabstop=4
set expandtab

""Plugin config
"Ale
let g:ale_lint_on_text_changed = 'never'
" let g:ale_completion_enabled = 1
let ale_linters = {
            \'rust' : ['cargo', 'rls', 'rustc']
            \}

"Rust
let g:rustfmt_autosave = 1
let g:ale_rust_rls_toolchain = 'stable'

""Theme
colorscheme molokai
set t_ut=
let g:rainbow_active = 1
