set autoread
set history=1000
set undofile
syntax on
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'bling/vim-airline'


" Indentation
set autoindent
set smartindent
set softtabstop=4
" set tabstop=4
set shiftwidth=4
" set expandtab

" Other things
set number
set backup
set ruler
set showcmd
set incsearch
set hlsearch
set mouse=a	    " make mouse available for all editing modes
set laststatus=2
set ttyfast
" set cursorline

set formatoptions+=w
set tw=120

set viminfo='10,\"100,:20,%,n~/.viminfo

set nocompatible    " Use Vim defaults instead of 100% vi compatibility
set backspace=2     " more powerful backspacing (same as backspace=indent,eol,start)

if has("autocmd")
    " Enable filetype detection
    filetype on
    filetype plugin indent off
    set runtimepath+=$GOROOT/misc/vim
    filetype plugin indent on

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    " Also don't do it when the mark is in the first line, that is the default
    " position when opening a file.
    autocmd BufReadPost *
		\ if line("'\"") > 1 && line("'\"") <= line("$") |
		\   exe "normal! g`\"" |
		\ endif
endif

set t_Co=256

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		\ | wincmd p | diffthis
endif

autocmd FileType text setlocal textwidth=80
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

highlight BadWhitespace ctermbg=red guibg=red
match BadWhitespace /\s\+$\| \+\ze\t/

:map :wj :w <Enter> :! spcp -d spmschunder2 % <Enter> <Enter>
:map :diffo :DiffOrig

let g:airline_theme='simple'
