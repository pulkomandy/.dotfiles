:set nocp

" Load pathogen based plugins.
execute pathogen#infect()

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

" nerd tree and tagbar
let NERDTreeShowHidden=0
let NERDTreeMouseMode=3

map <C-O> :NERDTreeToggle<CR>
map <C-T> :TagbarToggle<CR>

autocmd VimEnter * NERDTree
autocmd BufEnter * NERDTreeMirror

autocmd VimEnter * nested :call tagbar#autoopen(1)
autocmd FileType * nested :call tagbar#autoopen(0)
autocmd BufEnter * nested :call tagbar#autoopen(0)

" Relayout nerdtree and tagbar in a single column...
autocmd VimEnter * wincmd J
autocmd VimEnter * wincmd k
autocmd VimEnter * wincmd L
autocmd VimEnter * wincmd w

let g:tagbar_singleclick = 1 " Single click jumps to tag
let g:tagbar_sort = 0 " Do not sort tags by filename, keep in file order.
let g:tagbar_compact = 1 " I know that F1 and ? are for help, thanks!

" Exit when only nerdtree is left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

set winwidth=110
set colorcolumn=100

set shell=/bin/bash

command Todo execute 'silent lgrep -nr TODO *'

" :make
set autowrite
set autoread
au quickFixCmdPost make :cw

" Auto-open result window after :grep
au quickFixCmdPost grep :cw

set switchbuf=useopen

" airline cfg
set laststatus=2
set encoding=utf-8
setglobal fileencoding=utf-8
let g:airline_powerline_fonts=1
let g:airline#extensions#tagbar#enabled = 1

" Mark tabs, trailing whitespace and non-breakable space
set list listchars=tab:→\ ,trail:·,nbsp:¬

" Colorize parenthesis
let g:rainbow_active = 1
let basic5 = ['DarkCyan','DarkMagenta','DarkGreen','DarkBlue','DarkRed']
let separators = ',\|;'
let operators = '&& \||| \|== \|!= \|>= \|<= \|+ \|- \|/ \|* \|< \|> '
let g:rainbow_conf = {
\   'operators': '_'.separators.'\|'.operators.'_',
\   'parentheses': ['start=/(/ end=/)/'],
\   'ctermfgs': basic5
\}
