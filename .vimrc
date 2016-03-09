set nocompatible
set backspace=indent,eol,start
set scrolloff=1

set modelines=2
set modeline

set dir=~/tmp/
set undofile
set undodir=~/.vim/undodir

"dein Scripts-----------------------------
" Required:
set runtimepath^=.vim/dein//repos/github.com/Shougo/dein.vim

" Required:
call dein#begin(expand('.vim/dein/'))

" Let dein manage dein
" Required:
call dein#add('Shougo/dein.vim')

" Add or remove your plugins here:
call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/neosnippet-snippets')

" looking cool
call dein#add('sjl/badwolf')
call dein#add('bling/vim-airline')

" git stuff
call dein#add('tpope/vim-fugitive')
call dein#add('airblade/vim-gitgutter')
call dein#add('gregsexton/gitv')

" pystuff
call dein#add('klen/python-mode')

" clojure foo
call dein#add('scrooloose/syntastic.git')
call dein#add('kien/rainbow_parentheses.vim.git')

" Required:
call dein#end()

" Required:
filetype plugin indent on

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

"Now for my stuff ....

let g:task_paper_date_format = "%Y-%m-%dT%H:%M:%S%z"

colorscheme badwolf

set background=dark

syntax on
filetype off
filetype indent on
filetype plugin on

" further backup
set history=100

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1 
let g:syntastic_auto_loc_list = 1 
let g:syntastic_check_on_open = 1 
let g:syntastic_check_on_wq = 0 

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound

" pymode
" syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

" ignore some warnings and erorrs
let g:pep8_ignore="E501,E265,W601,W0611,C0301,C0111,W0401,W0614,W0622"
let g:pymode_lint_ignore="E501,E265,W601,W0611,C0301,C0111,W0401,W0614,W0622"

"Linting
"let g:pymode_lint = 1
"" let g:pymode_lint_checkers = ['pep8', 'pylint']
let g:pymode_lint_checkers = ['pep8',]
" Auto check on save
" let g:pymode_lint_write = 1

" insert timestamp and author
command -nargs=0 -bar Now execute "normal! a\<C-R>=strftime(\"%Y-%m-%d %H:%M\")\<CR>"

" if not has 'Last Change' in first 5 lines
fun! InsertChangeLog()
  let l:flag=0
  for i in range(1,5)
    if getline(i) !~ '.*Last Change.*'
      let l:flag = l:flag + 1
    endif
  endfor
  if l:flag >= 5
    normal(1G)
    call append(1, '#  ' . expand("$USER") . " " . strftime("%Y-%m-%d %H:%M"))
    normal gg
  endif
endfun

" vim-gitgutter
let g:gitgutter_realtime = 1


"status menu stuff
set laststatus=2
"set statusline=%<%f\%h%m%r%=%-20.(line=%l\ \ col=%c%V\ \ totlin=%L%)\ \ \%h%m%r%=%-40(bytval=0x%B,%n%Y%)\%P

set statusline=
set statusline+=%t%m%r%h%w
set statusline+=%=
set statusline+=\%{HasPaste()}
"set statusline+=\[%n]
set statusline+=%r
set statusline+=\[%{&ft}:%{&ff}:%{&enc}]
set statusline+=\[asc,hex=%03.3b,%02.2B]
set statusline+=\[line,col=%04l,%04v]
set statusline+=\[%L]
set statusline+=\[%p%%]
