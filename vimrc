syntax on
filetype plugin indent on

set history=1000
set smartindent
set softtabstop=4
"set tabstop=4
"set shiftwidth=4
"set expandtab
set number
set backup
set ruler
set showcmd
set incsearch
set hlsearch 
set mouse=a	    " make mouse available for all editing modes

set viminfo='10,\"100,:20,%,n~/.viminfo

set nocompatible    " Use Vim defaults instead of 100% vi compatibility
set backspace=2     " more powerful backspacing (same as backspace=indent,eol,start)

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" Also don't do it when the mark is in the first line, that is the default
" position when opening a file.
autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

augroup END

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

autocmd FileType text setlocal textwidth=78

highlight BadWhitespace ctermbg=red guibg=red
match BadWhitespace /\s\s+%\| \+\ze\t/

:map :wj :w <Enter> :! spcp -d spmschunder2 % <Enter> <Enter>
:map :diffo :DiffOrig
