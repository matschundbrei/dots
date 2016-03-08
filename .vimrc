set nocompatible
set backspace=indent,eol,start
set scrolloff=1

set modelines=2
set modeline

set dir=~/tmp/
set undofile
set undodir=~/.vim/undodir

filetype off
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'windows' : 'make -f make_mingw32.mak',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }

" colors, looks, etc.
NeoBundle 'sjl/badwolf'
NeoBundle 'bling/vim-airline'

" comment helper
NeoBundle 'tomtom/tcomment_vim'

" git
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'gregsexton/gitv'

" languages
NeoBundle 'klen/python-mode'

" clojure foo
NeoBundle 'scrooloose/syntastic.git'
NeoBundle 'kien/rainbow_parentheses.vim.git'

" misc
NeoBundle 'tpope/vim-sleuth'

" do magic?!
call neobundle#end()

let g:task_paper_date_format = "%Y-%m-%dT%H:%M:%S%z"

" if &term =~ "xterm" || &term =~ "screen" || has("gui_running") || &term =~ "xterm-256color"
set t_Co=256
if has("terminfo")
  let &t_Sf=nr2char(27).'[3%p1%dm'
  let &t_Sb=nr2char(27).'[4%p1%dm'
else
  let &t_Sf=nr2char(27).'[3%dm'
  let &t_Sb=nr2char(27).'[4%dm'
endif

colorscheme badwolf

set background=dark

if has("gui_running")
  set guioptions+=T
  set guioptions+=t
  set guioptions-=r
  " Powerline setup
  set laststatus=2
  highlight Pmenu guibg=#cccccc gui=bold
endif

syntax on
filetype off
filetype indent on
filetype plugin on

"increase history size
set history=100

"improved tab completion in command mode
set wildmode=list:longest

"intuitive backspace in insert mode
set backspace=indent,eol,start

" vim-gitgutter
let g:gitgutter_realtime = 1

"remap tComment trigger
let g:tcommentMapLeader2 = '<Leader>#'
exec 'noremap <silent> '. g:tcommentMapLeader2 .'# :TComment<cr>'
exec 'xnoremap <silent> '. g:tcommentMapLeader2 .'# :TCommentMaybeInline<cr>'

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

"misc settings
" set paste
" set number
" set autoindent

autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd BufRead *.org set noai

set ts=4
set sw=4
set sta
" set et
set sts=4
set ai
set nohls

" Functions
function! HasPaste()
  if &paste
    return '[PASTE]'
  else
    return ''
  endif
endfunction

"set cursorline
"noremap <silent><f12> :set cursorline!<cr>

function! WinMove(key)
  let t:curwin = winnr()
  exec "wincmd ".a:key
  if (t:curwin == winnr()) "we havent moved
    if (match(a:key,'[jk]')) "were we going up/down
      wincmd v
    else
      wincmd s
    endif
    exec "wincmd ".a:key
  endif
endfunction

map <leader>h              :call WinMove('h')<cr>
map <leader>k              :call WinMove('k')<cr>
map <leader>l              :call WinMove('l')<cr>
map <leader>j              :call WinMove('j')<cr>

map <leader>wc :wincmd q<cr>
map <leader>wr <C-W>r

map <leader>H              :wincmd H<cr>
map <leader>K              :wincmd K<cr>
map <leader>L              :wincmd L<cr>
map <leader>J              :wincmd J<cr>
nmap <leader><left>  :3wincmd <<cr>
nmap <leader><right> :3wincmd ><cr>
nmap <leader><up>    :3wincmd +<cr>
nmap <leader><down>  :3wincmd -<cr>

" Bubble single lines
" nmap <C-Up> [e
" nmap <C-Down> ]e
" Bubble multiple lines
"map <C-Up> [egv
"map <C-Down> ]egv

augroup vimrc_autocmds
  autocmd!
  " highlight characters past column 120
  autocmd FileType python highlight Excess ctermbg=DarkGrey guibg=Black
  autocmd FileType python match Excess /\%120v.*/
  autocmd FileType python set nowrap
augroup END

" Python-mode
" Activate rope
" Keys:
" K             Show python docs
" <Ctrl-Space>  Rope autocomplete
" <Ctrl-c>g     Rope goto definition
" <Ctrl-c>d     Rope show documentation
" <Ctrl-c>f     Rope find occurrences
" <Leader>b     Set, unset breakpoint (g:pymode_breakpoint enabled)
" [[            Jump on previous class or function (normal, visual, operator modes)
" ]]            Jump on next class or function (normal, visual, operator modes)
" [M            Jump on previous class or method (normal, visual, operator modes)
" ]M            Jump on next class or method (normal, visual, operator modes)
let g:pymode_rope = 1

let g:pymode_options_max_line_length = 120

" Folding
let g:pymode_folding = 0

" Documentation
set completeopt=menu
let g:pymode_doc = 1
let g:pymode_doc_key = 'K'

"Linting
let g:pymode_lint = 1
" let g:pymode_lint_checkers = ['pep8', 'pylint']
let g:pymode_lint_checkers = ['pep8',]
" Auto check on save
let g:pymode_lint_write = 1

" Support virtualenv
" let g:pymode_virtualenv = 0

" Enable breakpoints plugin
" let g:pymode_breakpoint = 1
" let g:pymode_breakpoint_key = '<leader>b'

" syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

" ignore some warnings and erorrs
let g:pep8_ignore="E501,E265,W601,W0611,C0301,C0111,W0401,W0614,W0622"
let g:pymode_lint_ignore="E501,E265,W601,W0611,C0301,C0111,W0401,W0614,W0622"

" additional python paths
" let g:pymode_paths = ['/Users/mcp/projects/selector']

" use space to fold code
" nnoremap <space> za
" vnoremap <space> zf
" set foldmethod=indent
" set foldnestmax=2
" set list
set listchars=tab:»·,trail:·,eol:¬
nmap <leader>L :set list!<CR>
nmap <leader>N :set number!<CR>
nmap <leader>Q :set paste!<CR>
map <F11> :set background=light<CR>
map <F12> :set background=dark<CR>


" airline
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

" buffers and tabs
" This allows buffers to be hidden if you've modified a buffer.
" This is almost a must if you wish to use buffers in this way.
set hidden

" To open a new empty buffer
" This replaces :tabnew which I used to bind to this mapping
nmap <leader>T :enew<cr>

" Move to the next buffer
nmap <leader>l :bnext<CR>

" Move to the previous buffer
nmap <leader>h :bprevious<CR>

" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
nmap <leader>bq :bp <BAR> bd #<CR>

" Show all open buffers and their status
nmap <leader>bl :ls<CR>

" gundo
nnoremap <leader>G :GundoToggle<CR>

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

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1 
let g:syntastic_auto_loc_list = 1 
let g:syntastic_check_on_open = 1 
let g:syntastic_check_on_wq = 0 

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound

" Installation check.
NeoBundleCheck

