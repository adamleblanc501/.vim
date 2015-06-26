" If you have colorscheme issues, run with 'TERM=xterm-256color nvim'
" Run install.sh for full features, or else remove config related to YCM

call pathogen#infect() " Runs the package manager (from bundle folder)

set relativenumber
set number
" set spell
set cursorline
syntax enable
"set background=dark " conflicts with color scheme
set autoindent
set smartindent
set smartcase
set smarttab
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
set incsearch

" enable wordwrap and linebreak (instead of splitting the words)
"set wrap
"set linebreak

set ttyfast
" mouse support
"set mouse=a
"set ttymouse=xterm2

set matchpairs+=<:> " Allows ci< to work between <...>
set scrolloff=5     " Set max and min cursor position before scrolling
set showmode
set nohlsearch      " Dont highlight after searching

set nocompatible    " Disable vi-compatibility, requires a full vim install
set laststatus=2    " Always show the statusline
set encoding=utf-8  " Necessary to show Unicode glyphs
set t_Co=256        " Explicitly tell Vim that the terminal supports 256 colors

set relativenumber

set iskeyword+=-

set backspace=2     " Sometimes backspace will not work properly on some systems, this is used to fix that. 

"set timeout " Do time out on mappings and others
" When you’re pressing Escape to leave insert mode in the terminal, it will by default take a second or another keystroke to leave insert mode completely and update the statusline. This should fix that. I got this from: https://powerline.readthedocs.org/en/latest/tipstricks.html#vim
" if !has('gui_running')
"     set ttimeoutlen=10
"     augroup FastEscape
"         autocmd!
"         au InsertEnter * set timeoutlen=0
"         au InsertLeave * set timeoutlen=1000
"     augroup END
" endif

filetype indent on
filetype plugin on

colorscheme molokai

" let g:molokai_original = 1 " conflicts with custom color scheme
let g:rehash256 = 1 " Themeing 256 colors

" spelling toggle
nmap \s :setlocal spell!<cr>
" number line toggle (useful for copying code)
nmap \l :setlocal number!<cr>
nmap \k :setlocal relativenumber!<cr>
" Used for java compiling from working folder
nmap <F7> :w<cr> :! ../compile.sh %<cr>
nmap <F8> :w<cr> :! ../compileOnly.sh %<cr>
nmap <F6> :TagbarToggle<CR>
" Makes j and k act like normal up and down on multi-lines
nmap j gj
nmap k gk
" Remap paste to auto-indent
" Commented out because although it's nice, it will chang cursor position for simple things like 'xp'
"nnoremap p p=`] 
"nnoremap P P=`] 
" normal p is now ^p
"nnoremap <c-p> p
" Nerdtree as a 'panel' (all tabs)
nmap <C-b> :NERDTreeTabsToggle<CR>
nmap <C-f> ysiw

" Jump lines quickly
nmap <C-j> 5j
nmap <C-k> 5k
xmap <C-j> 5j
xmap <C-k> 5k
" Better tab switching (ctrl+key instead of g+key)
nmap <C-l> gt
nmap <C-h> gT

" <C-c> instead of <Esc> because of timeout issues
imap {<CR> {<CR>}<C-c>O

" Add a new line (without having to go into insert mode)
nmap <S-CR> O<Esc>
nmap <CR> o<Esc>

" Disable arrow keys in normal and visual mode
nnoremap <Up> <NOP>
nnoremap <Down> <NOP>
nnoremap <Left> <NOP>
nnoremap <Right> <NOP>
vnoremap <Up> <NOP>
vnoremap <Down> <NOP>
vnoremap <Left> <NOP>
vnoremap <Right> <NOP>

" Remove all whitespace at the EOL
:nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" Custom commands with <leader>
nmap <leader>e :sp $MYVIMRC<cr> " Edit vimrc
nmap <leader>r :so $MYVIMRC<cr> " Reload vimrc

" Tabularize
nmap <Leader>a- :Tabularize /-<CR>
nmap <Leader>a& :Tabularize /&<CR>
nmap <Leader>a= :Tabularize /^[^=]*\zs=<CR>
nmap <Leader>a=> :Tabularize /=><CR>
nmap <Leader>a: :Tabularize /:<CR>
nmap <Leader>a:: :Tabularize /:\zs<CR>
nmap <Leader>a, :Tabularize /,<CR>
nmap <Leader>a,, :Tabularize /,\zs<CR>
nmap <Leader>a<Bar> :Tabularize /<Bar><CR>

" JavaDoc Comment, needs rework
let @c = "o/** NAME\<Esc>o*\<Esc>o* DESCRIPTION\<Esc>o*/\<Esc>kkkllR"
" Auto tab page
let @v = "ggVG="

" addon for auto compiling on save.
let g:syntastic_java_javac_classpath = "../*"

" Need to install the fonts in the fonts folder (run install.sh)
" I'm not sure what to do after that.
set guifont=Liberation\ Mono\ for\ Powerline\ 10
let g:airline_powerline_fonts = 1
let g:airline_theme = 'powerlineish'
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep  = '»'
let g:airline_left_sep  = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'

" Compiles SCSS files on saving.
function ScssToCss()
    let current_file = shellescape(expand('%:p'))
    let filename = shellescape(expand('%:r'))
    let command = "silent !sass " . current_file . " " . filename . ".css"
    execute command
endfunction
autocmd BufWritePost,FileWritePost *.scss call ScssToCss()

" set up custom auto close pairs
let g:AutoClosePairs = ("() [] ` \" '")

