:set nocp

" Load pathogen based plugins.
execute pathogen#infect()

:set mousemodel=popup
:set number
:set mouse=a "enable mouse features
set backspace=indent,eol,start

" Indent with tabs, tabs are 4 space.
:set tabstop=4
:set sw=4
:set smarttab
:set cindent

let mysyntaxfile='~/.vim/doxygen_load.vim'
:syntax enable
:set showmatch " highlight all search matches
filetype indent plugin on

:set titlestring=%t%M "set xterm title to filename+modified indicator
:set title
:set guifont=Liberation\ Mono\ 7
:set t_Co=256 " 256 colors in terminal
:colorscheme summerfruit256

" show 4 columns of folding indicators, unfold everything, create folds based
" on syntax (C blocks, etc)
:set foldcolumn=4
:set fdm=syntax
:set foldlevelstart=99

" search
:set hlsearch
:set incsearch "incremental search
:set ignorecase
:set smartcase

set colorcolumn=100 " your lines are too long!
set updatetime=250 " fast update of git-gutter, youcompleteme errors, etc

set shell=/bin/bash

command Todo execute 'silent lgrep -nr TODO *'

" ------------------------
"  QUICKFIX
" ------------------------

" :make
set autowrite
set autoread
au quickFixCmdPost make :cw

" Auto-open result window after :grep
au quickFixCmdPost grep :cw

" reuse open files when clicking in quickfix window
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

" Usable colors and signs for git gutter
let g:gitgutter_override_sign_column_highlight = 0
highlight SignColumn guibg=Black

let g:gitgutter_sign_added = '►'
let g:gitgutter_sign_modified = '◆'
let g:gitgutter_sign_removed = '◀'
let g:gitgutter_sign_modified_removed = '◆◀'
