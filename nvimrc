" If you have colorscheme issues, run with 'TERM=xterm-256color nvim'
" Run install.sh for all features

call pathogen#infect() " Runs the package manager (from bundle folder)

"let base16colorspace=256

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

set matchpairs+=<:> " Allows ci< to work between <...>
set scrolloff=5     " Set max and min cursor position before scrolling
set nohlsearch      " Dont highlight after searching

set laststatus=2    " Always show the statusline
set encoding=utf-8  " Necessary to show Unicode glyphs
set t_Co=256        " Explicitly tell Vim that the terminal supports 256 colors

set relativenumber

set clipboard=unnamedplus " Set x clipboard support for older systems (note: xclip is required either way!)

set iskeyword+=-

set backspace=2     " Sometimes backspace will not work properly on some systems, this is used to fix that.

set lazyredraw      " Don't draw the screen during macros

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.exe,*.swp,.git

filetype indent on
filetype plugin on

set omnifunc=syntaxcomplete#Complete " Set autocompletion based on languge (^x ^o)

colorscheme molokai
"colorscheme base16-default

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

" Makes j and k act like normal up and down on multi-lines
nmap j gj
nmap k gk

" Remap to auto-indent (annoying when using 'xp' ... might have fixed that by disabling 'x' going to a buffer)
nnoremap p p=`]
nnoremap P P=`]

" Nerdtree as a 'panel' (all tabs)
if has('nvim')
    nmap <A-b> :NERDTreeTabsToggle<CR>
else
    nmap <C-b> :NERDTreeTabsToggle<CR>
endif

" Surround.vim plugin shortcut
nmap <A-f> ysiw

" Better tab switching (alt+key instead of g+key)
if has('nvim')
    nmap <A-o> gt
    nmap <A-i> gT
else
    nmap \o gt
    nmap \i gT
endif

" Dont put x into buffer
nmap x "_dl

nmap q: :q

" Disable Q because I dont use it
nnoremap Q <NOP>

" <C-c> instead of <Esc> because of timeout issues
imap {<CR> {<CR>}<C-c>O

" Add a new line (without having to go into insert mode)
nmap <S-CR> O<Esc>
nmap <CR> o<Esc>

" Sudo to write
cmap w!! :w !sudo tee % >/dev/null

" Disable arrow keys in normal and visual mode
nnoremap <Up> <NOP>
nnoremap <Down> <NOP>
nnoremap <Left> <NOP>
nnoremap <Right> <NOP>
vnoremap <Up> <NOP>
vnoremap <Down> <NOP>
vnoremap <Left> <NOP>
vnoremap <Right> <NOP>

" Ctrl+SHIFT+C/V to work as expected (xclip required!)
" THIS ONLY WORKS IN TERMINALS THAT SUPPORT libtermkey! (konsole, gnome-terminal, xfce4-terminal, etc)
" For terminals that dont (guake, etc): ctrl+c works instead, but overwrites the original ctrl+c (cancel). ctrl+v works while in insert mode ONLY.
vnoremap <C-C> "+y
imap <C-V> "+p

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
autocmd BufWritePre * :%s/\s\+$//e

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
let g:syntastic_cpp_compiler_options = "-std=c++11"
let g:syntastic_javascript_checkers = ['jshint']

" Need to install the fonts in the fonts folder (run install.sh)
" I'm not sure what to do after that.
set guifont=Liberation\ Mono\ for\ Powerline\ 10
let g:airline_powerline_fonts = 1
let g:airline_theme = 'powerlineish'
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" disbale unicode symbols on airline
let g:airline_left_sep  = ''
let g:airline_left_sep  = ''
let g:airline_right_sep = ''
let g:airline_right_sep = ''

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

" CtrlP settings
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = 'ag %s -l --ignore .exe --ignore .so --ignore .dll --ignore .hg --ignore .git --ignore .svn --nocolor --hidden -g ""'
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn)$',
    \ 'file': '\v\.(exe|so|dll)$',
    \ }
