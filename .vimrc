:set nocp

:set mousemodel=popup
:set number
:set mouse=a "enable mouse features
set backspace=indent,eol,start

:set tabstop=4 
:set sw=4 
:set smarttab
:set cindent
let mysyntaxfile='~/.vim/doxygen_load.vim' 
:syntax enable
:set showmatch
filetype indent plugin on

:set titlestring=%t%M "set xterm title
:set title
:set guifont=Monospace\ 8
:set t_Co=256 " 256 colors in terminal
:colorscheme summerfruit256

:set foldcolumn=4
:set fdm=syntax
:set foldlevelstart=99

" search
:set hlsearch
:set incsearch "incremental search
:set ignorecase
:set smartcase

" CTags autocompletion menu
:set wildmenu							"affiche le menu
:set wildmode=list:longest,list:full	"affiche toutes les possibilités
:set wildignore=*.o,*.r,*.so,*.sl,*.tar,*.tgz	"ignorer certains types de fichiers pour la complétion des includes
map <C-F12> :!ctags -R --c-types=+p --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
set completeopt=menu
let OmniCpp_SelectFirstItem = 2

" nerd tree
let NERDTreeShowHidden=0
map <C-O> :NERDTreeToggle<CR>

set colorcolumn=100

set shell=/bin/bash

command Todo execute 'silent lgrep -nr TODO *'|lw|redraw!

" :make
set autowrite
set autoread
au quickFixCmdPost make :cw
set switchbuf=newtab,usetab

" airline cfg
set laststatus=2
set encoding=utf-8
setglobal fileencoding=utf-8
let g:airline_powerline_fonts=1

" Mark tabs
set list listchars=tab:»\ ,trail:·
