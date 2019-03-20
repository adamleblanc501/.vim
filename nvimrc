" If you have colorscheme issues, run with 'TERM=xterm-256color nvim'
" Run install.sh for all features

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

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

Plugin 'scrooloose/nerdtree'

call pathogen#infect() " Runs the package manager (from bundle folder)

"let base16colorspace=256

" sets that are enabled in neovim
if !has('nvim')
    set autoindent
    set autoread
    set encoding=utf-8
    set history=10000
    set incsearch
    set mouse=a
    set smarttab
    set wildmenu
endif

set number
set cursorline
syntax enable

au! FileType python setl nosmartindent " disable smartindent for python
set smartcase
set ignorecase

" 4 space tabs
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4

" Round indent
set shiftround

" Underscores is a word
set iskeyword-=_

"set colorcolumn=80
call matchadd('ColorColumn', '\%81v', 100)

" enable wordwrap and linebreak (instead of splitting the words)
set wrap
set linebreak

set matchpairs+=<:> " Allows ci< to work between <...>
set scrolloff=5     " Set max and min cursor position before scrolling
set nohlsearch      " Dont highlight after searching

set laststatus=2    " Always show the statusline
set t_Co=256        " Explicitly tell Vim that the terminal supports 256 colors


" Set x clipboard support for older systems
" (note: xclip is required either way!)
if executable('xclip') && has('clipboard')
    set clipboard=unnamedplus
endif

" makes foo-bar one keyword instead of two.
au FileType html|css set iskeyword+=-

" Sometimes backspace will not work properly on some systems,
" this is used to fix that.
set backspace=2

set lazyredraw      " Don't draw the screen during macros

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.exe,*.swp,.git

" add characters for tabs
exec "set listchars=tab:\uBB\uBB,nbsp:~"
set list

filetype indent on
filetype plugin on

" Set autocompletion based on languge (^x ^o)
set omnifunc=syntaxcomplete#Complete

colorscheme Redeye_Green
" custom colorscheme config
if g:colors_name == "molokai"
    let g:airline_theme = 'powerlineish'
elseif g:colors_name == "jellybeans"
    let g:airline_theme = 'base16_default'
    let g:jellybeans_use_term_italics = 1
    " Custom specialcharacter color
    hi SpecialChar ctermfg=135
endif

" let g:molokai_original = 1 " conflicts with custom color scheme
let g:rehash256 = 1 " Themeing 256 colors

" map <leader> from \ to ' '
let mapleader = "\<Space>"

" spelling toggle
nmap <leader>s :setlocal spell!<cr>
" paste toggle
nmap <leader>p :set paste!<cr>

" number line toggle (useful for copying code)
nmap <leader>l :setlocal number!<cr>
nmap <leader>k :setlocal relativenumber!<cr>

" Used for java compiling from working folder
nmap <F7> :w<cr> :! ../compile.sh %<cr>
nmap <F8> :w<cr> :! ../compileOnly.sh %<cr>

" Makes j and k act like normal up and down on multi-lines
nmap j gj
nmap k gk

" Remap to auto-indent
nnoremap p pmz=`]`z
nnoremap P Pmz=`]`z

" write to file quickly
nnoremap <Leader>w :w<CR>

" Surround.vim plugin shortcut
if has('nvim')
    nmap <A-f> ysiw
endif

" Better tab switching (alt+key instead of g+key)
if has('nvim')
    nmap <A-o> gt
    nmap <A-i> gT
else
    nmap <leader>o gt
    nmap <leader>i gT
endif

" add quick find and replace
nmap <leader>S :%s//g<LEFT><LEFT>
" search with /find then \Yreplace<cr> to replace all matched items in the
" search
nmap <expr> Y ':%s/' . @/ . '//g<LEFT><LEFT>'

" Dont put x into buffer
nmap x "_dl

" remove history and replace with :q because I always mess it up
nmap q: :q

" Disable Q because I dont use it
nnoremap Q <NOP>

" Add a new line (without having to go into insert mode)
nmap <S-CR> O<Esc>
nmap <CR> o<Esc>

" indent block of code
nmap <leader>i vi{>

" set tabs depending on file
nmap <leader>t :set expandtab tabstop=4 shiftwidth=4 softtabstop=4<CR>
nmap <leader>T :set expandtab tabstop=8 shiftwidth=8 softtabstop=4<CR>
nmap <leader>M :set noexpandtab tabstop=8 softtabstop=4 shiftwidth=4<CR>
nmap <leader>m :set expandtab tabstop=2 shiftwidth=2 softtabstop=2<CR>

" Sudo to write
cmap w!! :w !sudo tee % >/dev/null

" make arrow keys more useful, resize viewports
nnoremap <Left> :vertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>
nnoremap <Up> :resize -2<CR>
nnoremap <Down> :resize +2<CR>

" keep cursor in place when joining lines
nnoremap J mzJ`z

if has('nvim')
    " Terminal
    tnoremap <Esc> <C-\><C-n>
    tnoremap <A-h> <C-\><C-n><C-w>h
    tnoremap <A-j> <C-\><C-n><C-w>j
    tnoremap <A-k> <C-\><C-n><C-w>k
    tnoremap <A-l> <C-\><C-n><C-w>l
    nnoremap <A-h> <C-w>h
    nnoremap <A-j> <C-w>j
    nnoremap <A-k> <C-w>k
    nnoremap <A-l> <C-w>l
endif

" Remove all whitespace at the EOL
nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" Remove all whitespace at the EOL on write
let blacklist = ['md', 'markdown']
autocmd BufWritePre * if index(blacklist, &ft) < 0 | :%s/\s\+$//e

" restore last line number we were on in the file
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Mkview when automatic (doesn't work for neovim...?)
set viewoptions-=options
"autocmd BufWinLeave ?* mkview
"autocmd BufWinEnter ?* silent loadview

" Custom commands with <leader>
" Edit vimrc
nmap <leader>e :sp $MYVIMRC<cr>
" Reload vimrc
nmap <leader>r :so $MYVIMRC<cr>


" addon for auto compiling on save.
let g:syntastic_java_javac_classpath = "../*"
let g:syntastic_cpp_compiler_options = "-std=c++11"
let g:syntastic_c_compiler_options = "-std=c99"
let g:syntastic_javascript_checkers = ['jshint']

" delimate settings
let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1
let g:delimitMate_matchpairs = "(:),[:],{:}"
au FileType html let b:delimitMate_matchpairs = "<:>,(:),[:],{:}"

" easytags settings
let g:easytags_async = 1

hi Normal ctermbg=none
