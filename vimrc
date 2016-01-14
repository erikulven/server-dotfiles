" Copied and inspired by fullstackpython.com and others
" Show title in console title bar
set title
" change the leader to be a comma vs slash
let mapleader=","             
" enable syntax highlighting
syntax on
" show line numbers
set number
" set tabs to have 4 spaces
set ts=4
" indent when moving to the next line while writing code
set autoindent
" expand tabs into spaces
set expandtab
" when using the >> or << commands, shift lines by 4 spaces
set shiftwidth=4
" show a visual line under the cursor's current line
set cursorline
" show the matching part of the pair for [] {} and ()
set showmatch

" Python stuff
" enable all Python syntax highlighting features
let python_highlight_all = 1

" set list listchars=tab:▷⋅,trail:⋅,nbsp:⋅
filetype plugin indent on
au FileType py set autoindent
au FileType py set smartindent
au FileType py set textwidth=79
