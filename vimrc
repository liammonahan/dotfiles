
" Modified by: Liam Monahan
" Last modified: 2017 Dec 11

" Use vim settings rather then vi settings
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file; use versions instead
else
  set backup		" keep a backup file
endif

set history=50		" keep 50 lines of command line history
set ruler		    " show the cursor position all the time
set showcmd		    " display incomplete commands
set incsearch		" do incremental searching

" Switch syntax highlighting on when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END
else
  set autoindent		" always set autoindenting on
endif " has("autocmd")

highlight Comment ctermfg=white

" instead of spewing swp files everywhere, locate them all centrally
set backupdir=~/.vim/tmp

" text formatting...
set textwidth=79  " lines longers than 79 columns will be broken
" tab shit...
set shiftwidth=4  " >> indents 4 columns
set tabstop=4     " a hard TAB displays as 4 columns
set expandtab     " insert spaces when hitting TAB
set softtabstop=4 " insert/delete 4 spaces when hitting TAB/BACKSPACE
set shiftround    " tab to the closest multiple of 'shiftwidth'

" automatically enter and leave paste mode
let &t_SI .= "\<Esc>[?2004h"
 let &t_EI .= "\<Esc>[?2004l"

 inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

 function! XTermPasteBegin()
   set pastetoggle=<Esc>[201~
     set paste
       return ""
endfunction

let g:closetag_filenames = "*.html"

" Disable bell sound
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

" enhanced tab completion
set wildmenu
set wildmode=longest:list,full

" CTRL-N twice to toggle line numbers
nmap <C-N><C-N> :set invnumber<CR>

" wrap commit messages at 74 characters
autocmd FileType gitcommit set textwidth=74

" always start on the first line of a git commit message
autocmd FileType gitcommit call setpos('.', [0, 1, 1, 0])
