set autoread
set history=1000
syntax on

" Indentation
set autoindent
set smartindent
set softtabstop=4
"set tabstop=4
set shiftwidth=4
set expandtab


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

set viminfo='10,\"100,:20,%,n~/.viminfo

set nocompatible    " Use Vim defaults instead of 100% vi compatibility
set backspace=2     " more powerful backspacing (same as backspace=indent,eol,start)

if has("autocmd")
	" Enable filetype detection
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

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

autocmd FileType text setlocal textwidth=80

highlight BadWhitespace ctermbg=red guibg=red
match BadWhitespace /\s\+$\| \+\ze\t/

:map :wj :w <Enter> :! spcp -d spmschunder2 % <Enter> <Enter>
:map :diffo :DiffOrig

" a friendly, useful, and descriptive status line
set statusline=%t       "tail of the filename
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
set statusline+=%{&ff}] "file format
set statusline+=%h      "help file flag
set statusline+=%m      "modified flag
set statusline+=%r      "read only flag
set statusline+=%y      "filetype
set statusline+=%=      "left/right separator
set statusline+=%c:%v,     "cursor column (actual,virtual - great with tabs)
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file


