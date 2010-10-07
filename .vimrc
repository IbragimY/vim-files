set nocompatible

set backspace=indent,eol,start	" allow backspacing over everything in insert mode
set history=50			" keep 50 lines of command line history
set ruler			" show th cursor position all teh time
set showcmd			" display incomplete commands
set incsearch			" do incremental searching

if has('mouse')
  set mouse=a
endif

if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

if has('autocmd')

  " Enable file type detection.
  " Use the defult filetype settings, so that mail gets 'tw' set to 72
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " Whet editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent

endif " has("autcmd")

set number
set vb t_vb=
set tabstop=4
if !has("gui_running")
  colorscheme desert
endif
set syntax=go
set encoding=utf-8 " fileencondings=utf-8,cp1251
set list lcs=eol:¶,tab:→∙
set nolist

func FToggleList()
  let lst = &list
  if lst == 1
    set nolist
  else
    set list
  endif
endfunction

command ToggleList call FToggleList()
nmap <C-l> :ToggleList<CR>

" Add Python file header
function! BufNewFile_PY()
        0put = '#!/usr/bin/env python'
        1put = '#-*- coding: utf-8 -*-'
        $put = ''
        $put = ''
        normal G
endfunction
autocmd BufNewFile *.py call BufNewFile_PY()
" end of Add Python file header

function! BufNewFile_HTML()
        0put = '<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01//EN\" \"http://www.w3.org/TR/html4/strict.dtd\">'
        1put = '<html>'
        2put = '<head>'
        3put = '        <meta http-equiv=\"Content-Type\" content=\"text/html;charset=utf-8\">'
        4put = '        <script type=\"text/javascript\" src=\"ui_template/js/jquery-1.4.2.js\"></script>'
        5put = '        <script type=\"text/javascript\">'
        6put = '                $(document).ready(function() {'
        7put = '                        $(\"#content\").html(\"Hello, World!\");'
        8put = '                });'
        9put = '        </script>'
        10put = '</head>'
        11put = '<body>'
        12put = '       <div id=\"content\"></div>'
        13put = '</body>'
        14put = '</html>'
endfunction
autocmd BufNewFile *.html call BufNewFile_HTML()

set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
set laststatus=2

set nowrap
