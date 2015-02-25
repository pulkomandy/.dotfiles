:set mousemodel=popup
:set number
:set mouse=a "enable mouse features
:set tabstop=4 
:set sw=4 
:set smarttab
:set cindent
:syntax enable

:set titlestring=%t%M "set xterm title
:set title
:set guifont=Monospace\ 8
:set t_Co=256 " 256 colors in terminal
:colorscheme summerfruit256

:set foldcolumn=4
:set fdm=syntax
:set foldlevelstart=99

filetype indent plugin on
:set nocp
:set showmatch
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

autocmd QuickFixCmdPost make cw

let NERDTreeShowHidden=0
map <C-O> :NERDTreeToggle<CR>

set colorcolumn=80

set shell=/bin/bash

command Todo execute 'silent lgrep -nr TODO *'|lw|redraw!
set autowrite
au quickFixCmdPost make :cw

set autoread
